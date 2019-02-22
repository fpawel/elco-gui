unit pipe;

interface

uses System.Classes, Winapi.Messages, Winapi.Windows, REST.Json,
    System.SyncObjs,
    System.Generics.Collections,
    sysutils, Vcl.forms, superobject;

type
    TPipe = class
    private
        { Private declarations }
        _hPipe: THANDLE; // дескриптор
        FName: string;
        FId: integer;
        FRemoteError: string;

        FBusy: boolean;

        procedure _ReadFile(var Buffer; numberOfbytesToRead: DWORD);
        procedure _WriteFile(var Buffer; numberOfbytesToWrite: DWORD);

    public

        { Public declarations }
        Constructor Create(AName: string);
        function GetResponse(request: TBytes): TBytes;
    end;

    ERemoteError = class(Exception);
    EPipeBusyError = class(Exception);
    EPipeNotFound = class(Exception);

const
    WM_SERVER_APP_PIPE_BUSY = WM_USER + 1000;

function Pipe_GetUTF8Response(pipe: TPipe; request: string): String;

function Pipe_GetJsonrpcResult(pipe: TPipe; const method: string;
  params: ISuperObject): ISuperObject;

procedure SuperObject_SetField(x: ISuperObject; field: string;
  v: int64); overload;
procedure SuperObject_SetField(x: ISuperObject; field: string;
  v: double); overload;
procedure SuperObject_SetField(x: ISuperObject; field: string;
  v: boolean); overload;
procedure SuperObject_SetField(x: ISuperObject; field: string;
  v: string); overload;

procedure SuperObject_SetField(x: ISuperObject; field: string;
  v: TArray<string>); overload;

procedure SuperObject_Get(x: ISuperObject; var v: int64); overload;
procedure SuperObject_Get(x: ISuperObject; var v: integer); overload;
procedure SuperObject_Get(x: ISuperObject; var v: double); overload;
procedure SuperObject_Get(x: ISuperObject; var v: boolean); overload;
procedure SuperObject_Get(x: ISuperObject; var v: string); overload;

implementation

uses System.WideStrUtils, System.dateutils,
    math, ujsonrpc, inifiles;

function Pipe_GetJsonrpcParcedResponse(pipe: TPipe; const method: string;
  params: ISuperObject): IJsonRpcParsed;
var
    requestObj: IJsonRpcMessage;
    strResponse: string;
begin
    pipe.FId := pipe.FId + 1;
    requestObj := TJsonRpcMessage.request(pipe.FId, method, params);
    strResponse := Pipe_GetUTF8Response(pipe, requestObj.AsJSon(true, true));
    exit(TJsonRpcMessage.Parse(strResponse));
end;

function formatMessagetype(mt: TJsonRpcObjectType): string;
begin
    case mt of
        jotInvalid:
            exit('invalid');
        jotRequest:
            exit('request');
        jotNotification:
            exit('notification');
        jotSuccess:
            exit('success');
        jotError:
            exit('error');
    end;
end;

function Pipe_GetJsonrpcResult(pipe: TPipe; const method: string;
  params: ISuperObject): ISuperObject;
var
    r: IJsonRpcParsed;
    mt: TJsonRpcObjectType;
    rx: ISuperObject;
begin
    r := Pipe_GetJsonrpcParcedResponse(pipe, method, params);
    if not Assigned(r) then
        raise Exception.Create(Format('%s%s: unexpected nil response',
          [method, params.AsString]));

    if not Assigned(r.GetMessagePayload) then
        raise Exception.Create(Format('%s%s: unexpected nil message payload',
          [method, params.AsString]));

    rx := r.GetMessagePayload.AsJsonObject;

    if not Assigned(r.GetMessagePayload) then
        raise Exception.Create
          (Format('%s%s: unexpected nil message json object',
          [method, params.AsString]));

    if Assigned(rx['result']) then
    begin
        result := rx['result'];
        exit;
    end;

    if Assigned(rx['error.message']) then
        raise ERemoteError.Create(rx['error'].S['message']);

    if Assigned(r.GetMessagePayload) then
        raise Exception.Create(Format('%s%s'#13'%s'#13'message type: %s',
          [method, params.AsString, r.GetMessagePayload,
          formatMessagetype(r.GetMessageType)]));

    raise Exception.Create(Format('%s%s'#13'message type: %s',
      [method, params.AsString, formatMessagetype(r.GetMessageType)]));

end;

function Pipe_GetUTF8Response(pipe: TPipe; request: string): String;
var
    bytes_to_write: TBytes;
    read_Buffer: TBytes;
begin
    bytes_to_write := TEncoding.UTF8.GetBytes(request);
    read_Buffer := pipe.GetResponse(bytes_to_write);
    result := TEncoding.UTF8.GetString(read_Buffer);
end;

function _LastError: string;
var
    Buffer: array [0 .. 2047] of Char;
    strWinError: string;
begin
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, GetLastError, $400, @Buffer,
      SizeOf(Buffer), nil);
    exit(Trim(string(Buffer)));
end;

Constructor TPipe.Create(AName: string);
begin
    FName := AName;
    FId := 0;
    FRemoteError := '';
    FBusy := false;
end;

procedure TPipe._WriteFile(var Buffer; numberOfbytesToWrite: DWORD);
var
    writen_count: DWORD;
begin
    if not(WriteFile(_hPipe, Buffer, numberOfbytesToWrite, writen_count, nil))
    then
    begin
        _hPipe := CreateFileW(PWideChar(FName), GENERIC_READ or GENERIC_WRITE,
          FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
        if _hPipe = INVALID_HANDLE_VALUE then
            raise EPipeNotFound.Create('can not connect pipe: ' + FName + ': ' +
              _LastError);

        assert(WriteFile(_hPipe, Buffer, numberOfbytesToWrite, writen_count,
          nil), FName + ': WriteFile: ' + _LastError);

    end;

    assert(writen_count = numberOfbytesToWrite,
      Format('%s: WriteFile: writen_count=%d, must be %d', [FName, writen_count,
      numberOfbytesToWrite]));

end;

procedure TPipe._ReadFile(var Buffer; numberOfbytesToRead: DWORD);
var
    read_count: DWORD;
begin
    assert(ReadFile(_hPipe, Buffer, numberOfbytesToRead, read_count, nil),
      FName + ' ReadFile: ' + _LastError);

    assert(read_count = numberOfbytesToRead,
      Format('%s: ReadFile: writen_count=%d, must be %d', [FName, read_count,
      numberOfbytesToRead]));
end;

function TPipe.GetResponse(request: TBytes): TBytes;
var
    avail_count, read_count: DWORD;
    t: TDateTime;
begin
    if FBusy then
        raise EPipeBusyError.Create('Канал передачи данных занят');

    FRemoteError := '';
    _WriteFile(request[0], length(request));
    avail_count := 0;
    t := now;

    PostMessage(Application.MainForm.Handle, WM_SERVER_APP_PIPE_BUSY, 1, 0);
    FBusy := true;

    while avail_count = 0 do
    begin
        if not PeekNamedPipe(_hPipe, // _In_      HANDLE  hNamedPipe,
          nil, // _Out_opt_ LPVOID  lpBuffer,
          0, // _In_      DWORD   nBufferSize,
          nil, // _Out_opt_ LPDWORD lpBytesRead,
          @avail_count, // _Out_opt_ LPDWORD lpTotalBytesAvail,
          nil // _Out_opt_ LPDWORD lpBytesLeftThisMessage
          ) then
            raise Exception.Create('pipe error: ' + _LastError);
        // if SecondsBetween(t, now) > 5 then
        // raise Exception.Create('pipe hangs');
        Application.ProcessMessages;
        // Sleep(50);
    end;
    SetLength(result, avail_count);
    _ReadFile(result[0], avail_count);

    FBusy := false;
    PostMessage(Application.MainForm.Handle, WM_SERVER_APP_PIPE_BUSY, 0, 0);
end;

procedure SuperObject_SetField(x: ISuperObject; field: string; v: int64);
begin
    x.I[field] := v;
end;

procedure SuperObject_SetField(x: ISuperObject; field: string; v: double);
begin
    x.D[field] := v;
end;

procedure SuperObject_SetField(x: ISuperObject; field: string; v: boolean);
begin
    x.B[field] := v;
end;

procedure SuperObject_SetField(x: ISuperObject; field: string; v: string);
begin
    x.S[field] := v;
end;

procedure SuperObject_Get(x: ISuperObject; var v: int64);
begin
    v := x.AsInteger;
end;

procedure SuperObject_Get(x: ISuperObject; var v: double);
begin
    v := x.AsDouble;
end;

procedure SuperObject_Get(x: ISuperObject; var v: boolean);
begin
    v := x.AsBoolean;
end;

procedure SuperObject_Get(x: ISuperObject; var v: string);
begin
    v := x.AsString;
end;

procedure SuperObject_Get(x: ISuperObject; var v: integer); overload;
begin
    v := x.AsInteger;
end;

procedure SuperObject_SetField(x: ISuperObject; field: string;
  v: TArray<string>);
var
    I: integer;
begin
    x.O[field] := SA([]);
    for I := 0 to length(v) - 1 do
        x.A[field].S[I] := v[I];
end;

end.
