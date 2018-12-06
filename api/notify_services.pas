
unit notify_services;

interface
uses server_data_types, superobject, Winapi.Windows, Winapi.Messages;
type
    TStringHandler = reference to procedure (x:string);
    TReadCurrentHandler = reference to procedure (x:TReadCurrent);
    

procedure HandleCopydata(var Message: TMessage);

procedure SetOnReadCurrent( AHandler : TReadCurrentHandler);
procedure SetOnHardwareError( AHandler : TStringHandler);


implementation 
uses Rest.Json, stringutils, sysutils;

type
    TServerAppCmd = (CmdReadCurrent, 
    CmdHardwareError);

var
    _OnReadCurrent : TReadCurrentHandler;
    _OnHardwareError : TStringHandler;
    

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


end.