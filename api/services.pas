 
unit services;

interface
    uses server_data_types, pipe, superobject;
type
     function PartiesCatalogue_Days(pipe_conn:TPipe; Year: Integer; Month: Integer) : TArray<Integer>;
     function PartiesCatalogue_Months(pipe_conn:TPipe; Year: Integer) : TArray<Integer>;
     function PartiesCatalogue_Parties(pipe_conn:TPipe; Year: Integer; Month: Integer; Day: Integer) : TArray<TPartyInfo>;
     function PartiesCatalogue_Party(pipe_conn:TPipe; param1: Int64) : TParty;
     function PartiesCatalogue_Years(pipe_conn:TPipe; ) : TArray<Integer>;
     procedure LastParty_DeleteProductAtPlace(pipe_conn:TPipe; param1: Integer) ;
     function LastParty_Party(pipe_conn:TPipe; ) : TParty;
     function LastParty_ProductAtPlace(pipe_conn:TPipe; param1: Integer) : TProduct;
     function LastParty_SetProductNoteAtPlace(pipe_conn:TPipe; Place: Integer; Note: string) : Int64;
     function LastParty_SetProductSerialAtPlace(pipe_conn:TPipe; param1: Integer; param2: Integer) : Int64;
     function LastParty_SetProductTypeAtPlace(pipe_conn:TPipe; Place: Integer; ProductType: string) : Int64;
     function LastParty_ToggleProductProductionAtPlace(pipe_conn:TPipe; param1: Integer) : Int64;
     function ProductTypes_Names(pipe_conn:TPipe; ) : TArray<string>;
     
implementation 
    uses Rest.Json;   
 
function PartiesCatalogue_Days(pipe_conn:TPipe; Year: Integer; Month: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Days', req);
     for i in resp do
    begin
        SetLength(Result, Length(Result)+1);
        SuperObject_Get(i, Reult[Length(Result)-1]);            
    end;    
end;
 
function PartiesCatalogue_Months(pipe_conn:TPipe; Year: Integer) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Months', req);
     for i in resp do
    begin
        SetLength(Result, Length(Result)+1);
        SuperObject_Get(i, Reult[Length(Result)-1]);            
    end;    
end;
 
function PartiesCatalogue_Parties(pipe_conn:TPipe; Year: Integer; Month: Integer; Day: Integer) : TArray<TPartyInfo>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Parties', req);
     for i in resp do
    begin
        SetLength(Result, Length(Result)+1);
        SuperObject_Get(i, Reult[Length(Result)-1]);            
    end;    
end;
 
function PartiesCatalogue_Party(pipe_conn:TPipe; param1: Int64) : TParty;
var    
    req, resp: ISuperobject;
begin
    req := SA;
    req.AsArray.Add(param1) ;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Party', req);
    Result := TJson.JsonToObject < TParty > (resp.AsJson);    
end;
 
function PartiesCatalogue_Years(pipe_conn:TPipe; ) : TArray<Integer>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    req := SO;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Years', req);
     for i in resp do
    begin
        SetLength(Result, Length(Result)+1);
        SuperObject_Get(i, Reult[Length(Result)-1]);            
    end;    
end;
 
procedure LastParty_DeleteProductAtPlace(pipe_conn:TPipe; param1: Integer) ;
var    
    req, resp: ISuperobject;
begin
    req := SA;
    req.AsArray.Add(param1) ;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.DeleteProductAtPlace', req);
    Result := TJson.JsonToObject <  > (resp.AsJson);    
end;
 
function LastParty_Party(pipe_conn:TPipe; ) : TParty;
var    
    req, resp: ISuperobject;
begin
    req := SO;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.Party', req);
    Result := TJson.JsonToObject < TParty > (resp.AsJson);    
end;
 
function LastParty_ProductAtPlace(pipe_conn:TPipe; param1: Integer) : TProduct;
var    
    req, resp: ISuperobject;
begin
    req := SA;
    req.AsArray.Add(param1) ;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.ProductAtPlace', req);
    Result := TJson.JsonToObject < TProduct > (resp.AsJson);    
end;
 
function LastParty_SetProductNoteAtPlace(pipe_conn:TPipe; Place: Integer; Note: string) : Int64;
var    
    req, resp: ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Note', Note);
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetProductNoteAtPlace', req);
    Result := TJson.JsonToObject < Int64 > (resp.AsJson);    
end;
 
function LastParty_SetProductSerialAtPlace(pipe_conn:TPipe; param1: Integer; param2: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    req := SA;
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetProductSerialAtPlace', req);
    Result := TJson.JsonToObject < Int64 > (resp.AsJson);    
end;
 
function LastParty_SetProductTypeAtPlace(pipe_conn:TPipe; Place: Integer; ProductType: string) : Int64;
var    
    req, resp: ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'ProductType', ProductType);
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.SetProductTypeAtPlace', req);
    Result := TJson.JsonToObject < Int64 > (resp.AsJson);    
end;
 
function LastParty_ToggleProductProductionAtPlace(pipe_conn:TPipe; param1: Integer) : Int64;
var    
    req, resp: ISuperobject;
begin
    req := SA;
    req.AsArray.Add(param1) ;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.ToggleProductProductionAtPlace', req);
    Result := TJson.JsonToObject < Int64 > (resp.AsJson);    
end;
 
function ProductTypes_Names(pipe_conn:TPipe; ) : TArray<string>;
var    
    req, resp: ISuperobject; i:ISuperobject;
begin
    req := SO;
    
    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypes.Names', req);
     for i in resp do
    begin
        SetLength(Result, Length(Result)+1);
        SuperObject_Get(i, Reult[Length(Result)-1]);            
    end;    
end;
 

end.