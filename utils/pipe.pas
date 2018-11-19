unit pipe;

interface

uses System.Classes, Winapi.Windows, REST.Json, System.SyncObjs,
    System.Generics.Collections,
    sysutils, ujsonrpc, superobject;

type
    TPipe = class
    private
        { Private declarations }
        _hPipe: THANDLE; // дескриптор
        FName: string;
        FId: integer;
        procedure _ReadFile(var Buffer; numberOfbytesToRead: DWORD);
        procedure _WriteFile(var Buffer; numberOfbytesToWrite: DWORD);
        function _GetResponse(request: string): string;
    public

        { Public declarations }
        Constructor Create(AName: string);
        function GetResponse(const method: string; params: ISuperObject)
          : IJsonRpcParsed;
    end;

implementation

uses System.WideStrUtils, System.dateutils, vcl.forms,
    math, inifiles;

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
end;

procedure TPipe._WriteFile(var Buffer; numberOfbytesToWrite: DWORD);
var
    writen_count: DWORD;
begin
    if not(WriteFile(_hPipe, Buffer, numberOfbytesToWrite, writen_count, nil))
    then
    begin
        _hPipe := CreateFileW(PWideChar('\\.\pipe\elco'), GENERIC_READ or
          GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
          OPEN_EXISTING, 0, 0);
        assert(_hPipe <> INVALID_HANDLE_VALUE, 'can not connect server pipe: ' + _LastError);

        assert(WriteFile(_hPipe, Buffer, numberOfbytesToWrite, writen_count,
          nil), 'WriteFile: ' + _LastError);

    end;

    assert(writen_count = numberOfbytesToWrite,
      Format('WriteFile: writen_count=%d, must be %d',
      [writen_count, numberOfbytesToWrite]));

end;

procedure TPipe._ReadFile(var Buffer; numberOfbytesToRead: DWORD);
var
    read_count: DWORD;
begin
    assert(ReadFile(_hPipe, Buffer, numberOfbytesToRead, read_count, nil),
      'ReadFile: ' + _LastError);

    assert(read_count = numberOfbytesToRead,
      Format('ReadFile: writen_count=%d, must be %d',
      [read_count, numberOfbytesToRead]));
end;

function TPipe._GetResponse(request: string): string;
var
    bytes_to_write: TBytes;
    avail_count, read_count: DWORD;

    read_Buffer: TBytes;
begin
    bytes_to_write := TEncoding.UTF8.GetBytes(request);
    _WriteFile(bytes_to_write[0], length(bytes_to_write));

    avail_count := 0;
    while avail_count = 0 do
    begin
        PeekNamedPipe(_hPipe, // _In_      HANDLE  hNamedPipe,
          nil, // _Out_opt_ LPVOID  lpBuffer,
          0, // _In_      DWORD   nBufferSize,
          nil, // _Out_opt_ LPDWORD lpBytesRead,
          @avail_count, // _Out_opt_ LPDWORD lpTotalBytesAvail,
          nil // _Out_opt_ LPDWORD lpBytesLeftThisMessage
          );
          Application.ProcessMessages;
    end;

    SetLength(read_Buffer, avail_count);

    _ReadFile(read_Buffer[0], avail_count);
    result := TEncoding.UTF8.GetString(read_Buffer);
end;

function TPipe.GetResponse(const method: string; params: ISuperObject)
  : IJsonRpcParsed;
var
    requestObj: IJsonRpcMessage;
    strResponse: string;
begin
    FId := FId + 1;
    requestObj := TJsonRpcMessage.request(FId, method, params);
    strResponse := _GetResponse(requestObj.AsJSon(true, true));
    exit(TJsonRpcMessage.Parse(strResponse));
end;

end.
