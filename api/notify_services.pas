
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TReadCurrentHandler = reference to procedure (x:TReadCurrent);
    TStringHandler = reference to procedure (x:string);
    TDelayInfoHandler = reference to procedure (x:TDelayInfo);
    TPartyHandler = reference to procedure (x:TParty);
    TComportEntryHandler = reference to procedure (x:TComportEntry);
    TFirmwareInfoHandler = reference to procedure (x:TFirmwareInfo);
    TJournalEntryHandler = reference to procedure (x:TJournalEntry);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnReadCurrent( AHandler : TReadCurrentHandler);
procedure SetOnErrorOccurred( AHandler : TStringHandler);
procedure SetOnWorkComplete( AHandler : TStringHandler);
procedure SetOnWorkStarted( AHandler : TStringHandler);
procedure SetOnWorkStopped( AHandler : TStringHandler);
procedure SetOnStatus( AHandler : TStringHandler);
procedure SetOnWarning( AHandler : TStringHandler);
procedure SetOnDelay( AHandler : TDelayInfoHandler);
procedure SetOnLastPartyChanged( AHandler : TPartyHandler);
procedure SetOnComportEntry( AHandler : TComportEntryHandler);
procedure SetOnStartServerApplication( AHandler : TStringHandler);
procedure SetOnReadFirmware( AHandler : TFirmwareInfoHandler);
procedure SetOnNewJournalEntry( AHandler : TJournalEntryHandler);
procedure SetOnHostApplicationPanic( AHandler : TStringHandler);

procedure NotifyServices_SetEnabled(enabled:boolean);

implementation 
uses Rest.Json, stringutils, sysutils;

type
    TServerAppCmd = (CmdReadCurrent, CmdErrorOccurred, CmdWorkComplete, CmdWorkStarted, CmdWorkStopped, CmdStatus, CmdWarning, CmdDelay, CmdLastPartyChanged, CmdComportEntry, CmdStartServerApplication, CmdReadFirmware, CmdNewJournalEntry, 
    CmdHostApplicationPanic);

var
    _OnReadCurrent : TReadCurrentHandler;
    _OnErrorOccurred : TStringHandler;
    _OnWorkComplete : TStringHandler;
    _OnWorkStarted : TStringHandler;
    _OnWorkStopped : TStringHandler;
    _OnStatus : TStringHandler;
    _OnWarning : TStringHandler;
    _OnDelay : TDelayInfoHandler;
    _OnLastPartyChanged : TPartyHandler;
    _OnComportEntry : TComportEntryHandler;
    _OnStartServerApplication : TStringHandler;
    _OnReadFirmware : TFirmwareInfoHandler;
    _OnNewJournalEntry : TJournalEntryHandler;
    _OnHostApplicationPanic : TStringHandler;
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
        CmdComportEntry:
        begin
            if not Assigned(_OnComportEntry) then
                raise Exception.Create('_OnComportEntry must be set');
            _OnComportEntry(TJson.JsonToObject<TComportEntry>(str));
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
        CmdNewJournalEntry:
        begin
            if not Assigned(_OnNewJournalEntry) then
                raise Exception.Create('_OnNewJournalEntry must be set');
            _OnNewJournalEntry(TJson.JsonToObject<TJournalEntry>(str));
        end;
        CmdHostApplicationPanic:
        begin
            if not Assigned(_OnHostApplicationPanic) then
                raise Exception.Create('_OnHostApplicationPanic must be set');
            _OnHostApplicationPanic(str);
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
procedure SetOnComportEntry( AHandler : TComportEntryHandler);
begin
    if Assigned(_OnComportEntry) then
        raise Exception.Create('_OnComportEntry already set');
    _OnComportEntry := AHandler;
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
procedure SetOnNewJournalEntry( AHandler : TJournalEntryHandler);
begin
    if Assigned(_OnNewJournalEntry) then
        raise Exception.Create('_OnNewJournalEntry already set');
    _OnNewJournalEntry := AHandler;
end;
procedure SetOnHostApplicationPanic( AHandler : TStringHandler);
begin
    if Assigned(_OnHostApplicationPanic) then
        raise Exception.Create('_OnHostApplicationPanic already set');
    _OnHostApplicationPanic := AHandler;
end;


initialization
    _enabled := false;

end.