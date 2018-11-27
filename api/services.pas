unit services;

interface

uses server_data_types, pipe, superobject;

type
    TPartiesCatalogue = class
    public
        class function Days(Year: Integer; Month: Integer): TArray<Integer>;
        class function Months(Year: Integer): TArray<Integer>;
        class function Parties(Year: Integer; Month: Integer; Day: Integer)
          : TArray<TParty>;
        class function Party(param1: Int64): TParty;
        class function Years(): TArray<Integer>;

    end;

    TLastParty = class
    public
        class procedure DeleteProductAtPlace(param1: Integer);
        class function Party(): TParty;
        class function ProductAtPlace(param1: Integer): TProduct;
        class function SetProductNoteAtPlace(Place: Integer;
          Note: string): Int64;
        class function SetProductSerialAtPlace(param1: Integer;
          param2: Integer): Int64;
        class function SetProductTypeAtPlace(Place: Integer;
          ProductType: string): Int64;
        class function ToggleProductProductionAtPlace(param1: Integer): Int64;

    end;

    TProductTypes = class
    public
        class function Names(): TArray<string>;

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

class function TPartiesCatalogue.Days(Year: Integer; Month: Integer)
  : TArray<Integer>;
var
    req, resp: ISuperobject;
    i: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Days', req);

    for i in resp do
    begin
        SetLength(Result, Length(Result) + 1);

        SuperObject_Get(i, Result[Length(Result) - 1]);

    end;

end;

class function TPartiesCatalogue.Months(Year: Integer): TArray<Integer>;
var
    req, resp: ISuperobject;
    i: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Months', req);

    for i in resp do
    begin
        SetLength(Result, Length(Result) + 1);

        SuperObject_Get(i, Result[Length(Result) - 1]);

    end;

end;

class function TPartiesCatalogue.Parties(Year: Integer; Month: Integer;
  Day: Integer): TArray<TParty>;
var
    req, resp: ISuperobject;
    i: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Parties', req);

    for i in resp do
    begin
        SetLength(Result, Length(Result) + 1);

        Result[Length(Result) - 1] := TJson.JsonToObject<TParty>(i.AsJson);

    end;

end;

class function TPartiesCatalogue.Party(param1: Int64): TParty;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1);

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Party', req);

    Result := TJson.JsonToObject<TParty>(resp.AsJson);

end;

class function TPartiesCatalogue.Years(): TArray<Integer>;
var
    req, resp: ISuperobject;
    i: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'PartiesCatalogue.Years', req);

    for i in resp do
    begin
        SetLength(Result, Length(Result) + 1);

        SuperObject_Get(i, Result[Length(Result) - 1]);

    end;

end;

class procedure TLastParty.DeleteProductAtPlace(param1: Integer);
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1);

    resp := Pipe_GetJsonrpcResult(pipe_conn,
      'LastParty.DeleteProductAtPlace', req);

end;

class function TLastParty.Party(): TParty;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.Party', req);

    Result := TJson.JsonToObject<TParty>(resp.AsJson);

end;

class function TLastParty.ProductAtPlace(param1: Integer): TProduct;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1);

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.ProductAtPlace', req);

    Result := TJson.JsonToObject<TProduct>(resp.AsJson);

end;

class function TLastParty.SetProductNoteAtPlace(Place: Integer;
  Note: string): Int64;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Note', Note);

    resp := Pipe_GetJsonrpcResult(pipe_conn,
      'LastParty.SetProductNoteAtPlace', req);

    SuperObject_Get(resp, Result);

end;

class function TLastParty.SetProductSerialAtPlace(param1: Integer;
  param2: Integer): Int64;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1);
    req.AsArray.Add(param2);

    resp := Pipe_GetJsonrpcResult(pipe_conn,
      'LastParty.SetProductSerialAtPlace', req);

    SuperObject_Get(resp, Result);

end;

class function TLastParty.SetProductTypeAtPlace(Place: Integer;
  ProductType: string): Int64;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'ProductType', ProductType);

    resp := Pipe_GetJsonrpcResult(pipe_conn,
      'LastParty.SetProductTypeAtPlace', req);

    SuperObject_Get(resp, Result);

end;

class function TLastParty.ToggleProductProductionAtPlace
  (param1: Integer): Int64;
var
    req, resp: ISuperobject;
begin
    ensure_pipe_connected;
    req := SA([]);
    req.AsArray.Add(param1);

    resp := Pipe_GetJsonrpcResult(pipe_conn,
      'LastParty.ToggleProductProductionAtPlace', req);

    SuperObject_Get(resp, Result);

end;

class function TProductTypes.Names(): TArray<string>;
var
    req, resp: ISuperobject;
    i: ISuperobject;
begin
    ensure_pipe_connected;
    req := SO;

    resp := Pipe_GetJsonrpcResult(pipe_conn, 'ProductTypes.Names', req);

    for i in resp do
    begin
        SetLength(Result, Length(Result) + 1);

        SuperObject_Get(i, Result[Length(Result) - 1]);

    end;

end;

end.
