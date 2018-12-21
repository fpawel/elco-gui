
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TPartyHandler = reference to procedure (x:TParty);
    TReadCurrentHandler = reference to procedure (x:TReadCurrent);
    TStringHandler = reference to procedure (x:string);
    TDelayInfoHandler = reference to procedure (x:TDelayInfo);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnReadCurrent( AHandler : TReadCurrentHandler);
procedure SetOnHardwareError( AHandler : TStringHandler);
procedure SetOnHardwareStarted( AHandler : TStringHandler);
procedure SetOnHardwareStopped( AHandler : TStringHandler);
procedure SetOnStatus( AHandler : TStringHandler);
procedure SetOnWarning( AHandler : TStringHandler);
procedure SetOnDelay( AHandler : TDelayInfoHandler);
procedure SetOnLastPartyChanged( AHandler : TPartyHandler);

procedure Cancel;

implementation 
uses Rest.Json, stringutils, sysutils;

type
    TServerAppCmd = (CmdReadCurrent, CmdHardwareError, CmdHardwareStarted, CmdHardwareStopped, CmdStatus, CmdWarning, CmdDelay, 
    CmdLastPartyChanged);

var
    _OnReadCurrent : TReadCurrentHandler;
    _OnHardwareError : TStringHandler;
    _OnHardwareStarted : TStringHandler;
    _OnHardwareStopped : TStringHandler;
    _OnStatus : TStringHandler;
    _OnWarning : TStringHandler;
    _OnDelay : TDelayInfoHandler;
    _OnLastPartyChanged : TPartyHandler;
    _cancel:boolean;

procedure Cancel;
begin
   _cancel := true;
end;

procedure HandleCopydata(var Message: TMessage);
var
    cd: PCOPYDATASTRUCT;
    cmd: TServerAppCmd;
    str:string;
begin
    if _cancel then
        exit;
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
        CmdWarning:
        begin
            if not Assigned(_OnWarning) then
                raise Exception.Create('_OnWarning must be set');
            _OnWarning(str);
        end;
        CmdDelay:
        begin
            if not Assigned(_OnDelay) then
                raise Exception.Create('_OnDelay must be set');
            _OnDelay(TJson.JsonToObject<TDelayInfo>(str));
        end;
        CmdLastPartyChanged:
        begin
            if not Assigned(_OnLastPartyChanged) then
                raise Exception.Create('_OnLastPartyChanged must be set');
            _OnLastPartyChanged(TJson.JsonToObject<TParty>(str));
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
procedure SetOnWarning( AHandler : TStringHandler);
begin
    if Assigned(_OnWarning) then
        raise Exception.Create('_OnWarning already set');
    _OnWarning := AHandler;
end;
procedure SetOnDelay( AHandler : TDelayInfoHandler);
begin
    if Assigned(_OnDelay) then
        raise Exception.Create('_OnDelay already set');
    _OnDelay := AHandler;
end;
procedure SetOnLastPartyChanged( AHandler : TPartyHandler);
begin
    if Assigned(_OnLastPartyChanged) then
        raise Exception.Create('_OnLastPartyChanged already set');
    _OnLastPartyChanged := AHandler;
end;


initialization
    _cancel := false;

end.