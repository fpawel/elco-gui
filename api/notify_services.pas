
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TReadCurrentHandler = reference to procedure (x:TReadCurrent);
    TStringHandler = reference to procedure (x:string);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnReadCurrent( AHandler : TReadCurrentHandler);
procedure SetOnHardwareError( AHandler : TStringHandler);
procedure SetOnHardwareStarted( AHandler : TStringHandler);
procedure SetOnHardwareStopped( AHandler : TStringHandler);
procedure SetOnStatus( AHandler : TStringHandler);


implementation 
uses Rest.Json, stringutils, sysutils;

type
    TServerAppCmd = (CmdReadCurrent, CmdHardwareError, CmdHardwareStarted, CmdHardwareStopped, 
    CmdStatus);

var
    _OnReadCurrent : TReadCurrentHandler;
    _OnHardwareError : TStringHandler;
    _OnHardwareStarted : TStringHandler;
    _OnHardwareStopped : TStringHandler;
    _OnStatus : TStringHandler;
    

procedure HandleCopydata(var Message: TMessage);
var
    cd: PCOPYDATASTRUCT;
    cmd: TServerAppCmd;
    str:string;
begin
    cd := PCOPYDATASTRUCT(Message.LParam);
    cmd := TServerAppCmd(Message.WParam);
    Message.result := 1;
    SetString(str, PWideChar(cd.lpData), cd.cbData div 2);
    case cmd of
        CmdReadCurrent:
        begin
            if not Assigned(_OnReadCurrent) then
                raise Exception.Create('_OnReadCurrent must be set');
            _OnReadCurrent(TJson.JsonToObject<TReadCurrent>(str));
        end;
        CmdHardwareError:
        begin
            if not Assigned(_OnHardwareError) then
                raise Exception.Create('_OnHardwareError must be set');
            _OnHardwareError(str);
        end;
        CmdHardwareStarted:
        begin
            if not Assigned(_OnHardwareStarted) then
                raise Exception.Create('_OnHardwareStarted must be set');
            _OnHardwareStarted(str);
        end;
        CmdHardwareStopped:
        begin
            if not Assigned(_OnHardwareStopped) then
                raise Exception.Create('_OnHardwareStopped must be set');
            _OnHardwareStopped(str);
        end;
        CmdStatus:
        begin
            if not Assigned(_OnStatus) then
                raise Exception.Create('_OnStatus must be set');
            _OnStatus(str);
        end;
        
    else
        raise Exception.Create('wrong message: ' + IntToStr(Message.WParam));
    end;
end;

procedure SetOnReadCurrent( AHandler : TReadCurrentHandler);
begin
    if Assigned(_OnReadCurrent) then
        raise Exception.Create('_OnReadCurrent already set');
    _OnReadCurrent := AHandler;
end;
procedure SetOnHardwareError( AHandler : TStringHandler);
begin
    if Assigned(_OnHardwareError) then
        raise Exception.Create('_OnHardwareError already set');
    _OnHardwareError := AHandler;
end;
procedure SetOnHardwareStarted( AHandler : TStringHandler);
begin
    if Assigned(_OnHardwareStarted) then
        raise Exception.Create('_OnHardwareStarted already set');
    _OnHardwareStarted := AHandler;
end;
procedure SetOnHardwareStopped( AHandler : TStringHandler);
begin
    if Assigned(_OnHardwareStopped) then
        raise Exception.Create('_OnHardwareStopped already set');
    _OnHardwareStopped := AHandler;
end;
procedure SetOnStatus( AHandler : TStringHandler);
begin
    if Assigned(_OnStatus) then
        raise Exception.Create('_OnStatus already set');
    _OnStatus := AHandler;
end;


end.