 
unit services;

interface
    uses server_data_types, pipe, superobject;
type 
     TPartiesCatalogue = class 
    public
        class function Days( Year: Integer; Month: Integer) : TArray<Integer>;
        class function Months( Year: Integer) : TArray<Integer>;
        class function Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;
        class function Party( param1: Int64) : TParty;
        class function Years( ) : TArray<Integer>;
         
    end; TLastParty = class 
    public
        class procedure DeleteProductAtPlace( param1: Integer) ;
        class function Party( ) : TParty;
        class function ProductAtPlace( param1: Integer) : TProduct;
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
        class function Calculate( param1: Int64) : TProductFirmwareInfo;
        class function CalculateTempPoints( Values: TArray< string> ) : TTempPoints;
        class function Stored( param1: Int64) : TProductFirmwareInfo;
         
    end; TSettingsSvc = class 
    public
        class function ChangePredefined( param1: string) : string;
        class function Predefined( ) : string;
        class function Sections( ) : TConfigSections;
        class function SetDefaultPredefined( ) : string;
        class procedure SetValue( param1: string; param2: string; param3: string) ;
         
    end; TRunnerSvc = class 
    public
        class procedure RunReadCurrent( param1: Boolean; param2: Boolean; param3: Boolean; param4: Boolean; param5: Boolean; param6: Boolean; param7: Boolean; param8: Boolean; param9: Boolean; param10: Boolean; param11: Boolean; param12: Boolean) ;
        class procedure StopHardware( ) ;
         
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

  
class function TProductFirmware.Calculate( param1: Int64) : TProductFirmwareInfo;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.Calculate', req);
    
        
             
                Result := TJson.JsonToObject < TProductFirmwareInfo > (resp.AsJson);
            
        
    
end;

 
class function TProductFirmware.CalculateTempPoints( Values: TArray< string> ) : TTempPoints;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Values', Values);
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.CalculateTempPoints', req);
    
        
             
                Result := TJson.JsonToObject < TTempPoints > (resp.AsJson);
            
        
    
end;

 
class function TProductFirmware.Stored( param1: Int64) : TProductFirmwareInfo;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductFirmware.Stored', req);
    
        
             
                Result := TJson.JsonToObject < TProductFirmwareInfo > (resp.AsJson);
            
        
    
end;

  
class function TSettingsSvc.ChangePredefined( param1: string) : string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1) ;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.ChangePredefined', req);
    
        
            
                SuperObject_Get(resp, Result);
            
        
    
end;

 
class function TSettingsSvc.Predefined( ) : string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.Predefined', req);
    
        
            
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

 
class function TSettingsSvc.SetDefaultPredefined( ) : string;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'SettingsSvc.SetDefaultPredefined', req);
    
        
            
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

 
class procedure TRunnerSvc.StopHardware( ) ;
var    
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
        
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'RunnerSvc.StopHardware', req);
    
end;

 
end.