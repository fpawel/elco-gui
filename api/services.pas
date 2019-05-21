 
unit services;

interface
    uses server_data_types, pipe, superobject;
type 
     TPartiesCatalogueSvc = class 
    public
        class function CopyParty( param1: Int64) : TParty;
        class function Days( Year: Integer; Month: Integer) : TArray<Integer>;
        class procedure DeleteDay( param1: Integer; param2: Integer; param3: Integer) ;
        class procedure DeleteMonth( param1: Integer; param2: Integer) ;
        class procedure DeletePartyID( param1: Int64) ;
        class procedure DeleteYear( param1: Integer) ;
        class function Months( Year: Integer) : TArray<Integer>;
        class function NewParty: TParty;
        class function Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;
        class function Party( param1: Int64) : TParty;
        class function Years: TArray<Integer>;
         
    end; TLastPartySvc = class 
    public
        class function CalculateFonMinus20: TParty;
        class function CalculateSensMinus20( param1: Double) : TParty;
        class function CalculateSensPlus50( param1: Double) : TParty;
        class procedure DeleteProductAtPlace( param1: Integer) ;
        class procedure Export;
        class function GetCheckBlocks: TGetCheckBlocksArg;
        class function Import: TParty;
        class function Party: TParty;
        class function ProductAtPlace( param1: Integer) : TProduct;
        class procedure SelectAll( param1: Boolean) ;
        class function SelectOnlyOkProductsProduction: TParty;
        class function SetBlockChecked( param1: Integer; param2: Integer) : Int64;
        class function SetPointsMethodAtPlace( Place: Integer; PointsMethod: Int64; Valid: Boolean) : Int64;
        class function SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;
        class function SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;
        class function SetProductTypeAtPlace( Place: Integer; ProductType: string) : Int64;
        class function ToggleProductProductionAtPlace( param1: Integer) : Int64;
         
    end; TProductTypesSvc = class 
    public
        class function Gases: TArray<string>;
        class function Names: TArray<string>;
        class function Units: TArray<string>;
         
    end; TPlaceFirmware = class 
    public
        class function CalculateFirmwareInfo( param1: Int64) : TFirmwareInfo;
        class procedure RunReadPlaceFirmware( param1: Integer) ;
        class procedure RunWritePlaceFirmware( Place: Integer; Year: Integer; Month: Integer; Day: Integer; Hour: Integer; Minute: Integer; Second: Integer; Sensitivity: string; Serial: string; ProductType: string; Gas: string; Units: string; ScaleBegin: string; ScaleEnd: string; Values: TArray<string>) ;
        class function StoredFirmwareInfo( param1: Int64) : TFirmwareInfo;
        class function TempPoints( Values: TArray<string>) : TTempPoints;
         
    end; TSettingsSvc = class 
    public
        class function ChangePredefinedConfig( param1: string) : string;
        class function PredefinedConfig: string;
        class function Sections: TConfigSections;
        class function SetDefaultPredefinedConfig: string;
        class procedure SetValue( param1: string; param2: string; param3: string) ;
         
    end; TRunnerSvc = class 
    public
        class procedure RunMainError;
        class procedure RunReadAndSaveProductCurrents( param1: string) ;
        class procedure RunReadCurrent;
        class procedure RunTemperature( param1: Boolean; param2: Boolean; param3: Boolean) ;
        class procedure RunWritePartyFirmware;
        class procedure SkipDelay;
        class procedure StopHardware;
         
    end; TPdfSvc = class 
    public
        class procedure Run;
         
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

  
class function TPartiesCatalogueSvc.CopyParty( param1: Int64) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.CopyParty', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TPartiesCatalogueSvc.Days( Year: Integer; Month: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.Days', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class procedure TPartiesCatalogueSvc.DeleteDay( param1: Integer; param2: Integer; param3: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.DeleteDay', req);
    
end;

 
class procedure TPartiesCatalogueSvc.DeleteMonth( param1: Integer; param2: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.DeleteMonth', req);
    
end;

 
class procedure TPartiesCatalogueSvc.DeletePartyID( param1: Int64) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.DeletePartyID', req);
    
end;

 
class procedure TPartiesCatalogueSvc.DeleteYear( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.DeleteYear', req);
    
end;

 
class function TPartiesCatalogueSvc.Months( Year: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.Months', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TPartiesCatalogueSvc.NewParty: TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.NewParty', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TPartiesCatalogueSvc.Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.Parties', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                 
                    Result[Length(Result)-1] := TJson.JsonToObject < TParty > (i.AsJson);
                
            end;
        
    
end;

 
class function TPartiesCatalogueSvc.Party( param1: Int64) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.Party', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TPartiesCatalogueSvc.Years: TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogueSvc.Years', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

  
class function TLastPartySvc.CalculateFonMinus20: TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.CalculateFonMinus20', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TLastPartySvc.CalculateSensMinus20( param1: Double) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.CalculateSensMinus20', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TLastPartySvc.CalculateSensPlus50( param1: Double) : TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.CalculateSensPlus50', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class procedure TLastPartySvc.DeleteProductAtPlace( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.DeleteProductAtPlace', req);
    
end;

 
class procedure TLastPartySvc.Export;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.Export', req);
    
end;

 
class function TLastPartySvc.GetCheckBlocks: TGetCheckBlocksArg;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.GetCheckBlocks', req);
    
        
             
                Result := TJson.JsonToObject < TGetCheckBlocksArg > (resp.AsJson);
            
        
    
end;

 
class function TLastPartySvc.Import: TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.Import', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TLastPartySvc.Party: TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.Party', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TLastPartySvc.ProductAtPlace( param1: Integer) : TProduct;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.ProductAtPlace', req);
    
        
             
                Result := TJson.JsonToObject < TProduct > (resp.AsJson);
            
        
    
end;

 
class procedure TLastPartySvc.SelectAll( param1: Boolean) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SelectAll', req);
    
end;

 
class function TLastPartySvc.SelectOnlyOkProductsProduction: TParty;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SelectOnlyOkProductsProduction', req);
    
        
             
                Result := TJson.JsonToObject < TParty > (resp.AsJson);
            
        
    
end;

 
class function TLastPartySvc.SetBlockChecked( param1: Integer; param2: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SetBlockChecked', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastPartySvc.SetPointsMethodAtPlace( Place: Integer; PointsMethod: Int64; Valid: Boolean) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'PointsMethod', PointsMethod);
    SuperObject_SetField(req, 'Valid', Valid);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SetPointsMethodAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastPartySvc.SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Note', Note);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SetProductNoteAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastPartySvc.SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SetProductSerialAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastPartySvc.SetProductTypeAtPlace( Place: Integer; ProductType: string) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'ProductType', ProductType);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.SetProductTypeAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TLastPartySvc.ToggleProductProductionAtPlace( param1: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastPartySvc.ToggleProductProductionAtPlace', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

  
class function TProductTypesSvc.Gases: TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypesSvc.Gases', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TProductTypesSvc.Names: TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypesSvc.Names', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

 
class function TProductTypesSvc.Units: TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypesSvc.Units', req);
    
         
            for i in resp do
            begin
                SetLength(Result, Length(Result)+1);
                                    
                    SuperObject_Get(i, Result[Length(Result)-1]);
                
            end;
        
    
end;

  
class function TPlaceFirmware.CalculateFirmwareInfo( param1: Int64) : TFirmwareInfo;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PlaceFirmware.CalculateFirmwareInfo', req);
    
        
             
                Result := TJson.JsonToObject < TFirmwareInfo > (resp.AsJson);
            
        
    
end;

 
class procedure TPlaceFirmware.RunReadPlaceFirmware( param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PlaceFirmware.RunReadPlaceFirmware', req);
    
end;

 
class procedure TPlaceFirmware.RunWritePlaceFirmware( Place: Integer; Year: Integer; Month: Integer; Day: Integer; Hour: Integer; Minute: Integer; Second: Integer; Sensitivity: string; Serial: string; ProductType: string; Gas: string; Units: string; ScaleBegin: string; ScaleEnd: string; Values: TArray<string>) ;
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
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PlaceFirmware.RunWritePlaceFirmware', req);
    
end;

 
class function TPlaceFirmware.StoredFirmwareInfo( param1: Int64) : TFirmwareInfo;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PlaceFirmware.StoredFirmwareInfo', req);
    
        
             
                Result := TJson.JsonToObject < TFirmwareInfo > (resp.AsJson);
            
        
    
end;

 
class function TPlaceFirmware.TempPoints( Values: TArray<string>) : TTempPoints;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Values', Values);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PlaceFirmware.TempPoints', req);
    
        
             
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

 
class function TSettingsSvc.PredefinedConfig: string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.PredefinedConfig', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TSettingsSvc.Sections: TConfigSections;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.Sections', req);
    
        
             
                Result := TJson.JsonToObject < TConfigSections > (resp.AsJson);
            
        
    
end;

 
class function TSettingsSvc.SetDefaultPredefinedConfig: string;
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

  
class procedure TRunnerSvc.RunMainError;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunMainError', req);
    
end;

 
class procedure TRunnerSvc.RunReadAndSaveProductCurrents( param1: string) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunReadAndSaveProductCurrents', req);
    
end;

 
class procedure TRunnerSvc.RunReadCurrent;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
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

 
class procedure TRunnerSvc.RunWritePartyFirmware;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.RunWritePartyFirmware', req);
    
end;

 
class procedure TRunnerSvc.SkipDelay;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.SkipDelay', req);
    
end;

 
class procedure TRunnerSvc.StopHardware;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.StopHardware', req);
    
end;

  
class procedure TPdfSvc.Run;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PdfSvc.Run', req);
    
end;

 
end.