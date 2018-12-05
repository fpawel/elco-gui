
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TTextMessageHandler = reference to procedure (x:TTextMessage);
    TStringHandler = reference to procedure (x:string);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnMessageBox( AHandler : TTextMessageHandler);
procedure SetOnStatusMessage( AHandler : TStringHandler);


implementation 
uses Rest.Json, stringutils, sysutils;

type
    TServerAppCmd = (CmdMessageBox, 
    CmdStatusMessage);

var
    _OnMessageBox : TTextMessageHandler;
    _OnStatusMessage : TStringHandler;
    

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
        CmdMessageBox:
        begin
            if not Assigned(_OnMessageBox) then
                raise Exception.Create('_OnMessageBox must be set');
            _OnMessageBox(TJson.JsonToObject<TTextMessage>(str));
        end;
        CmdStatusMessage:
        begin
            if not Assigned(_OnStatusMessage) then
                raise Exception.Create('_OnStatusMessage must be set');
            _OnStatusMessage(str);
        end;
        
    else
        raise Exception.Create('wrong message: ' + IntToStr(Message.WParam));
    end;
end;

procedure SetOnMessageBox( AHandler : TTextMessageHandler);
begin
    if Assigned(_OnMessageBox) then
        raise Exception.Create('_OnMessageBox already set');
    _OnMessageBox := AHandler;
end;
procedure SetOnStatusMessage( AHandler : TStringHandler);
begin
    if Assigned(_OnStatusMessage) then
        raise Exception.Create('_OnStatusMessage already set');
    _OnStatusMessage := AHandler;
end;


end.