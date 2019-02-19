 
unit services;

interface
    uses server_data_types, pipe, superobject;
type 
     TPartiesCatalogue = class 
    public
        class function Days( Year: Integer; Month: Integer) : TArray<Integer>;
        class procedure DeleteDay( param1: Integer; param2: Integer; param3: Integer) ;
        class procedure DeleteMonth( param1: Integer; param2: Integer) ;
        class procedure DeletePartyID( param1: Int64) ;
        class procedure DeleteYear( param1: Integer) ;
        class function Import( ) : TParty;
        class function Months( Year: Integer) : TArray<Integer>;
        class function NewParty( ) : TParty;
        class function Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;
        class function Party( param1: Int64) : TParty;
        class function Years( ) : TArray<Integer>;
         
    end; TLastParty = class 
    public
        class procedure DeleteProductAtPlace( param1: Integer) ;
        class procedure Export( ) ;
        class function Party( ) : TParty;
        class function ProductAtPlace( param1: Integer) : TProduct;
        class procedure SelectAll( param1: Boolean) ;
        class procedure SelectBlock( Checked: Boolean; Block: Integer) ;
        class function SetPointsMethodAtPlace( Place: Integer; PointsMethod: Int64; Valid: Boolean) : Int64;
        class function SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;
        class function SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;
        class function SetProductTypeAtPlace( Place: Integer; ProductType: string) : Int64;
        class function ToggleProductProductionAtPlace( param1: Integer) : Int64;
         
    end; TProductTypes = class 
    public
        class function Gases( ) : TArray<string>;
        class function Names( ) : TArray<string>;
        class function Units( ) : TArray<string>;
         
    end; TProductFirmware = class 
    public
        class function CalculateFirmwareInfo( param1: Int64) : TFirmwareInfo;
        class procedure RunReadFirmware( param1: Integer) ;
        class procedure RunWriteFirmware( Place: Integer; Year: Integer; Month: Integer; Day: Integer; Hour: Integer; Minute: Integer; Second: Integer; Sensitivity: string; Serial: string; ProductType: string; Gas: string; Units: string; ScaleBegin: string; ScaleEnd: string; Values: TArray< string> ) ;
        class function StoredFirmwareInfo( param1: Int64) : TFirmwareInfo;
        class function TempPoints( Values: TArray< string> ) : TTempPoints;
         
    end; TSettingsSvc = class 
    public
        class function ChangePredefinedConfig( param1: string) : string;
        class function PredefinedConfig( ) : string;
        class function Sections( ) : TConfigSections;
        class function SetDefaultPredefinedConfig( ) : string;
        class procedure SetValue( param1: string; param2: string; param3: string) ;
         
    end; TRunnerSvc = class 
    public
        class procedure RunMainError( ) ;
        class procedure RunReadCurrent( param1: Boolean; param2: Boolean; param3: Boolean; param4: Boolean; param5: Boolean; param6: Boolean; param7: Boolean; param8: Boolean; param9: Boolean; param10: Boolean; param11: Boolean; param12: Boolean) ;
        class procedure RunTemperature( param1: Boolean; param2: Boolean; param3: Boolean) ;
        class procedure RunWritePartyFirmware( ) ;
        class procedure RunWriteProductFirmware( param1: Integer) ;
        class procedure SkipDelay( ) ;
        class procedure StopHardware( ) ;
         
    end; TJournal = class 
    public
        class function DayEntries( Year: Integer; Month: Integer; Day: Integer) : TArray<TJournalEntry>;
        class function DayWorks( Year: Integer; Month: Integer; Day: Integer) : TArray<TJournalWork>;
        class function Days( Year: Integer; Month: Integer) : TArray<Integer>;
        class function EntriesOfWorkID( param1: Int64) : TArray<TJournalEntry>;
        class function Months( Year: Integer) : TArray<Integer>;
        class function Years( ) : TArray<Integer>;
         
    end; 


implementation 
    uses Rest.Json;  

var
    pipe_conn: TPipe;
    
procedure ensure_pipe_connected;
begin
    if Assigned(pipe_conn) then
        exit;
    try
        pipe_conn := TPipe.Create('\\.\pipe\elco');
    except
        begin
            if Assigned(pipe_conn) then
                pipe_conn.Free;
            raise;
        end;
    end;
end;

  
class function TPartiesCatalogue.Days( Year: Integer; Month: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Days', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class procedure TPartiesCatalogue.DeleteDay( param1: Integer; param2: Integer; param3: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.DeleteDay', req);
    
end;

 
class procedure TPartiesCatalogue.DeleteMonth( param1: Integer; param2: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.DeleteMonth', req);
    
end;

 
class procedure TPartiesCatalogue.DeletePartyID( param1: Int64) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.DeletePartyID', req);
    
end;

 
class procedure TPartiesCatalogue.DeleteYear( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.DeleteYear', req);
    
end;

 
class function TPartiesCatalogue.Import( ) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Import', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TPartiesCatalogue.Months( Year: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Months', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TPartiesCatalogue.NewParty( ) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.NewParty', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TPartiesCatalogue.Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Parties', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                 
                    Result[Length(Result)-1] := TJson.JsonToObject < TParty > (i.AsJson);
                
            end;
        
    
end;

 
class function TPartiesCatalogue.Party( param1: Int64) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Party', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TPartiesCatalogue.Years( ) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Years', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

  
class procedure TLastParty.DeleteProductAtPlace( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.DeleteProductAtPlace', req);
    
end;

 
class procedure TLastParty.Export( ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.Export', req);
    
end;

 
class function TLastParty.Party( ) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.Party', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TLastParty.ProductAtPlace( param1: Integer) : TProduct;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.ProductAtPlace', req);
    
        
             
                Result := TJson.JsonToObject < TProduct > (resp.AsJson);
            
        
    
end;

 
class procedure TLastParty.SelectAll( param1: Boolean) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SelectAll', req);
    
end;

 
class procedure TLastParty.SelectBlock( Checked: Boolean; Block: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Checked', Checked);
    SuperObject_SetField(req, 'Block', Block);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SelectBlock', req);
    
end;

 
class function TLastParty.SetPointsMethodAtPlace( Place: Integer; PointsMethod: Int64; Valid: Boolean) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'PointsMethod', PointsMethod);
    SuperObject_SetField(req, 'Valid', Valid);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetPointsMethodAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastParty.SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Note', Note);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetProductNoteAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastParty.SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetProductSerialAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastParty.SetProductTypeAtPlace( Place: Integer; ProductType: string) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'ProductType', ProductType);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetProductTypeAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastParty.ToggleProductProductionAtPlace( param1: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.ToggleProductProductionAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

  
class function TProductTypes.Gases( ) : TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypes.Gases', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TProductTypes.Names( ) : TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypes.Names', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TProductTypes.Units( ) : TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypes.Units', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

  
class function TProductFirmware.CalculateFirmwareInfo( param1: Int64) : TFirmwareInfo;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.CalculateFirmwareInfo', req);
    
        
             
                Result := TJson.JsonToObject < TFirmwareInfo > (resp.AsJson);
            
        
    
end;

 
class procedure TProductFirmware.RunReadFirmware( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.RunReadFirmware', req);
    
end;

 
class procedure TProductFirmware.RunWriteFirmware( Place: Integer; Year: Integer; Month: Integer; Day: Integer; Hour: Integer; Minute: Integer; Second: Integer; Sensitivity: string; Serial: string; ProductType: string; Gas: string; Units: string; ScaleBegin: string; ScaleEnd: string; Values: TArray< string> ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
    SuperObject_SetField(req, 'Hour', Hour);
    SuperObject_SetField(req, 'Minute', Minute);
    SuperObject_SetField(req, 'Second', Second);
    SuperObject_SetField(req, 'Sensitivity', Sensitivity);
    SuperObject_SetField(req, 'Serial', Serial);
    SuperObject_SetField(req, 'ProductType', ProductType);
    SuperObject_SetField(req, 'Gas', Gas);
    SuperObject_SetField(req, 'Units', Units);
    SuperObject_SetField(req, 'ScaleBegin', ScaleBegin);
    SuperObject_SetField(req, 'ScaleEnd', ScaleEnd);
    SuperObject_SetField(req, 'Values', Values);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.RunWriteFirmware', req);
    
end;

 
class function TProductFirmware.StoredFirmwareInfo( param1: Int64) : TFirmwareInfo;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.StoredFirmwareInfo', req);
    
        
             
                Result := TJson.JsonToObject < TFirmwareInfo > (resp.AsJson);
            
        
    
end;

 
class function TProductFirmware.TempPoints( Values: TArray< string> ) : TTempPoints;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Values', Values);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.TempPoints', req);
    
        
             
                Result := TJson.JsonToObject < TTempPoints > (resp.AsJson);
            
        
    
end;

  
class function TSettingsSvc.ChangePredefinedConfig( param1: string) : string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.ChangePredefinedConfig', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TSettingsSvc.PredefinedConfig( ) : string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.PredefinedConfig', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TSettingsSvc.Sections( ) : TConfigSections;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.Sections', req);
    
        
             
                Result := TJson.JsonToObject < TConfigSections > (resp.AsJson);
            
        
    
end;

 
class function TSettingsSvc.SetDefaultPredefinedConfig( ) : string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.SetDefaultPredefinedConfig', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class procedure TSettingsSvc.SetValue( param1: string; param2: string; param3: string) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.SetValue', req);
    
end;

  
class procedure TRunnerSvc.RunMainError( ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunMainError', req);
    
end;

 
class procedure TRunnerSvc.RunReadCurrent( param1: Boolean; param2: Boolean; param3: Boolean; param4: Boolean; param5: Boolean; param6: Boolean; param7: Boolean; param8: Boolean; param9: Boolean; param10: Boolean; param11: Boolean; param12: Boolean) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
    req.AsArray.Add(param4) ;
    req.AsArray.Add(param5) ;
    req.AsArray.Add(param6) ;
    req.AsArray.Add(param7) ;
    req.AsArray.Add(param8) ;
    req.AsArray.Add(param9) ;
    req.AsArray.Add(param10) ;
    req.AsArray.Add(param11) ;
    req.AsArray.Add(param12) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunReadCurrent', req);
    
end;

 
class procedure TRunnerSvc.RunTemperature( param1: Boolean; param2: Boolean; param3: Boolean) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunTemperature', req);
    
end;

 
class procedure TRunnerSvc.RunWritePartyFirmware( ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunWritePartyFirmware', req);
    
end;

 
class procedure TRunnerSvc.RunWriteProductFirmware( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunWriteProductFirmware', req);
    
end;

 
class procedure TRunnerSvc.SkipDelay( ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.SkipDelay', req);
    
end;

 
class procedure TRunnerSvc.StopHardware( ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.StopHardware', req);
    
end;

  
class function TJournal.DayEntries( Year: Integer; Month: Integer; Day: Integer) : TArray<TJournalEntry>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'Journal.DayEntries', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                 
                    Result[Length(Result)-1] := TJson.JsonToObject < TJournalEntry > (i.AsJson);
                
            end;
        
    
end;

 
class function TJournal.DayWorks( Year: Integer; Month: Integer; Day: Integer) : TArray<TJournalWork>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'Journal.DayWorks', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                 
                    Result[Length(Result)-1] := TJson.JsonToObject < TJournalWork > (i.AsJson);
                
            end;
        
    
end;

 
class function TJournal.Days( Year: Integer; Month: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'Journal.Days', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TJournal.EntriesOfWorkID( param1: Int64) : TArray<TJournalEntry>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'Journal.EntriesOfWorkID', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                 
                    Result[Length(Result)-1] := TJson.JsonToObject < TJournalEntry > (i.AsJson);
                
            end;
        
    
end;

 
class function TJournal.Months( Year: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'Journal.Months', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TJournal.Years( ) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'Journal.Years', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
end.