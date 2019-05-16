
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TPartyHandler = reference to procedure (x:TParty);
    TFirmwareInfoHandler = reference to procedure (x:TFirmwareInfo);
    TReadCurrentHandler = reference to procedure (x:TReadCurrent);
    TStringHandler = reference to procedure (x:string);
    TDelayInfoHandler = reference to procedure (x:TDelayInfo);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnReadCurrent( AHandler : TReadCurrentHandler);
procedure SetOnErrorOccurred( AHandler : TStringHandler);
procedure SetOnWorkComplete( AHandler : TStringHandler);
procedure SetOnWorkStarted( AHandler : TStringHandler);
procedure SetOnWorkStopped( AHandler : TStringHandler);
procedure SetOnStatus( AHandler : TStringHandler);
procedure SetOnTraceTemperatureInfo( AHandler : TStringHandler);
procedure SetOnTraceTemperatureError( AHandler : TStringHandler);
procedure SetOnWarning( AHandler : TStringHandler);
procedure SetOnDelay( AHandler : TDelayInfoHandler);
procedure SetOnLastPartyChanged( AHandler : TPartyHandler);
procedure SetOnStartServerApplication( AHandler : TStringHandler);
procedure SetOnReadFirmware( AHandler : TFirmwareInfoHandler);
procedure SetOnPanic( AHandler : TStringHandler);
procedure SetOnWriteConsole( AHandler : TStringHandler);

procedure NotifyServices_SetEnabled(enabled:boolean);

implementation 
uses Rest.Json, stringutils, sysutils;

type
    TServerAppCmd = (CmdReadCurrent, CmdErrorOccurred, CmdWorkComplete, CmdWorkStarted, CmdWorkStopped, CmdStatus, CmdTraceTemperatureInfo, CmdTraceTemperatureError, CmdWarning, CmdDelay, CmdLastPartyChanged, CmdStartServerApplication, CmdReadFirmware, CmdPanic, 
    CmdWriteConsole);

var
    _OnReadCurrent : TReadCurrentHandler;
    _OnErrorOccurred : TStringHandler;
    _OnWorkComplete : TStringHandler;
    _OnWorkStarted : TStringHandler;
    _OnWorkStopped : TStringHandler;
    _OnStatus : TStringHandler;
    _OnTraceTemperatureInfo : TStringHandler;
    _OnTraceTemperatureError : TStringHandler;
    _OnWarning : TStringHandler;
    _OnDelay : TDelayInfoHandler;
    _OnLastPartyChanged : TPartyHandler;
    _OnStartServerApplication : TStringHandler;
    _OnReadFirmware : TFirmwareInfoHandler;
    _OnPanic : TStringHandler;
    _OnWriteConsole : TStringHandler;
    _enabled:boolean;

procedure NotifyServices_SetEnabled(enabled:boolean);
begin
   _enabled := enabled;
end;

procedure HandleCopydata(var Message: TMessage);
var
    cd: PCOPYDATASTRUCT;
    cmd: TServerAppCmd;
    str:string;
begin
    if not _enabled then
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
        CmdErrorOccurred:
        begin
            if not Assigned(_OnErrorOccurred) then
                raise Exception.Create('_OnErrorOccurred must be set');
            _OnErrorOccurred(str);
        end;
        CmdWorkComplete:
        begin
            if not Assigned(_OnWorkComplete) then
                raise Exception.Create('_OnWorkComplete must be set');
            _OnWorkComplete(str);
        end;
        CmdWorkStarted:
        begin
            if not Assigned(_OnWorkStarted) then
                raise Exception.Create('_OnWorkStarted must be set');
            _OnWorkStarted(str);
        end;
        CmdWorkStopped:
        begin
            if not Assigned(_OnWorkStopped) then
                raise Exception.Create('_OnWorkStopped must be set');
            _OnWorkStopped(str);
        end;
        CmdStatus:
        begin
            if not Assigned(_OnStatus) then
                raise Exception.Create('_OnStatus must be set');
            _OnStatus(str);
        end;
        CmdTraceTemperatureInfo:
        begin
            if not Assigned(_OnTraceTemperatureInfo) then
                raise Exception.Create('_OnTraceTemperatureInfo must be set');
            _OnTraceTemperatureInfo(str);
        end;
        CmdTraceTemperatureError:
        begin
            if not Assigned(_OnTraceTemperatureError) then
                raise Exception.Create('_OnTraceTemperatureError must be set');
            _OnTraceTemperatureError(str);
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
        CmdStartServerApplication:
        begin
            if not Assigned(_OnStartServerApplication) then
                raise Exception.Create('_OnStartServerApplication must be set');
            _OnStartServerApplication(str);
        end;
        CmdReadFirmware:
        begin
            if not Assigned(_OnReadFirmware) then
                raise Exception.Create('_OnReadFirmware must be set');
            _OnReadFirmware(TJson.JsonToObject<TFirmwareInfo>(str));
        end;
        CmdPanic:
        begin
            if not Assigned(_OnPanic) then
                raise Exception.Create('_OnPanic must be set');
            _OnPanic(str);
        end;
        CmdWriteConsole:
        begin
            if not Assigned(_OnWriteConsole) then
                raise Exception.Create('_OnWriteConsole must be set');
            _OnWriteConsole(str);
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
procedure SetOnErrorOccurred( AHandler : TStringHandler);
begin
    if Assigned(_OnErrorOccurred) then
        raise Exception.Create('_OnErrorOccurred already set');
    _OnErrorOccurred := AHandler;
end;
procedure SetOnWorkComplete( AHandler : TStringHandler);
begin
    if Assigned(_OnWorkComplete) then
        raise Exception.Create('_OnWorkComplete already set');
    _OnWorkComplete := AHandler;
end;
procedure SetOnWorkStarted( AHandler : TStringHandler);
begin
    if Assigned(_OnWorkStarted) then
        raise Exception.Create('_OnWorkStarted already set');
    _OnWorkStarted := AHandler;
end;
procedure SetOnWorkStopped( AHandler : TStringHandler);
begin
    if Assigned(_OnWorkStopped) then
        raise Exception.Create('_OnWorkStopped already set');
    _OnWorkStopped := AHandler;
end;
procedure SetOnStatus( AHandler : TStringHandler);
begin
    if Assigned(_OnStatus) then
        raise Exception.Create('_OnStatus already set');
    _OnStatus := AHandler;
end;
procedure SetOnTraceTemperatureInfo( AHandler : TStringHandler);
begin
    if Assigned(_OnTraceTemperatureInfo) then
        raise Exception.Create('_OnTraceTemperatureInfo already set');
    _OnTraceTemperatureInfo := AHandler;
end;
procedure SetOnTraceTemperatureError( AHandler : TStringHandler);
begin
    if Assigned(_OnTraceTemperatureError) then
        raise Exception.Create('_OnTraceTemperatureError already set');
    _OnTraceTemperatureError := AHandler;
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
procedure SetOnStartServerApplication( AHandler : TStringHandler);
begin
    if Assigned(_OnStartServerApplication) then
        raise Exception.Create('_OnStartServerApplication already set');
    _OnStartServerApplication := AHandler;
end;
procedure SetOnReadFirmware( AHandler : TFirmwareInfoHandler);
begin
    if Assigned(_OnReadFirmware) then
        raise Exception.Create('_OnReadFirmware already set');
    _OnReadFirmware := AHandler;
end;
procedure SetOnPanic( AHandler : TStringHandler);
begin
    if Assigned(_OnPanic) then
        raise Exception.Create('_OnPanic already set');
    _OnPanic := AHandler;
end;
procedure SetOnWriteConsole( AHandler : TStringHandler);
begin
    if Assigned(_OnWriteConsole) then
        raise Exception.Create('_OnWriteConsole already set');
    _OnWriteConsole := AHandler;
end;


initialization
    _enabled := false;

end.