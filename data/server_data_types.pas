unit server_data_types;

interface

uses Generics.Collections, Rest.Json;

type

    TSQLFloat = class
    public
        FFloat64: Extended;
        FValid: Boolean;
        //function Str: string;
    end;

    TSQLString = class
    public
        FString: String;
        FValid: Boolean;
        //function Str: string;
    end;

    TSQLBool = class
    public
        FBool: Boolean;
        FValid: Boolean;
    end;

    TSQLInt64 = class
    public
        FInt64: int64;
        FValid: Boolean;
        //function Str: string;
    end;

    TProduct = class
    public
        FProductID, FPartyID: int64;

        FPlace: integer;

        FSerial: TSQLInt64;
        FProductTypeName: TSQLString;

        FHasFirmware: Boolean;
        FProduction: Boolean;

        FDFon20: TSQLFloat;
        FDFon50: TSQLFloat;
        FDNotMeasured: TSQLFloat;
        FI13: TSQLFloat;
        FI17: TSQLFloat;
        FI24: TSQLFloat;
        FI26: TSQLFloat;
        FI35: TSQLFloat;
        FIFMinus20: TSQLFloat;
        FIFPlus20: TSQLFloat;
        FIFPlus50: TSQLFloat;
        FISMinus20: TSQLFloat;
        FISPlus20: TSQLFloat;
        FISPlus50: TSQLFloat;
        FKSens20: TSQLFloat;
        FKSens50: TSQLFloat;
        FNotMeasured: TSQLFloat;
        FNotOk: TSQLBool;
        FOKDFon20: TSQLBool;
        FOKDFon50: TSQLBool;
        FOKDNotMeasured: TSQLBool;
        FOKFon20: TSQLBool;
        FOKKSens20: TSQLBool;
        FOKKSens50: TSQLBool;
        FNote: TSQLString;

        constructor Create;
        destructor Destroy;
        function ToJsonString: string;
        class function FromJsonString(AJsonString: string): TProduct;
    end;

    TProducts = TArray<TProduct>;

    TParty = class
    public
        FPartyID: int64;
        FCreatedAt: TDateTime;
        // FUpdatedAt: TDateTime;
        FConcentration1: Extended;
        FConcentration2: Extended;
        FConcentration3: Extended;
        FNote: TSQLString;
        FProductTypeName: String;
        FLast: Boolean;
        FProducts: TProducts;
        destructor Destroy; override;
        function ToJsonString: string;
        class function FromJsonString(AJsonString: string): TParty;
    end;

implementation

uses sysutils;

{ TProduct }

constructor TProduct.Create;
begin
    FSerial := TSQLInt64.Create;;
    FProductTypeName := TSQLString.Create;

    FDFon20 := TSQLFloat.Create;
    FDFon50 := TSQLFloat.Create;
    FDNotMeasured := TSQLFloat.Create;
    FI13 := TSQLFloat.Create;
    FI17 := TSQLFloat.Create;
    FI24 := TSQLFloat.Create;
    FI26 := TSQLFloat.Create;
    FI35 := TSQLFloat.Create;
    FIFMinus20 := TSQLFloat.Create;
    FIFPlus20 := TSQLFloat.Create;
    FIFPlus50 := TSQLFloat.Create;
    FISMinus20 := TSQLFloat.Create;
    FISPlus20 := TSQLFloat.Create;
    FISPlus50 := TSQLFloat.Create;
    FKSens20 := TSQLFloat.Create;
    FKSens50 := TSQLFloat.Create;
    FNotMeasured := TSQLFloat.Create;
    FNotOk := TSQLBool.Create;
    FOKDFon20 := TSQLBool.Create;
    FOKDFon50 := TSQLBool.Create;
    FOKDNotMeasured := TSQLBool.Create;
    FOKFon20 := TSQLBool.Create;
    FOKKSens20 := TSQLBool.Create;
    FOKKSens50 := TSQLBool.Create;

    FNote := TSQLString.Create;
end;

destructor TProduct.Destroy;
begin
    FI35.Free;
    FI26.Free;
    FI24.Free;
    FI17.Free;
    FI13.Free;
    FNotMeasured.Free;
    FOKDFon50.Free;
    FOKDFon20.Free;
    FDFon50.Free;
    FDFon20.Free;
    FProductTypeName.Free;
    FNotOk.Free;
    FDNotMeasured.Free;
    FSerial.Free;
    FIFMinus20.Free;
    FOKKSens50.Free;
    FOKKSens20.Free;
    FISPlus50.Free;
    FISPlus20.Free;
    FOKFon20.Free;
    FOKDNotMeasured.Free;
    FISMinus20.Free;
    FIFPlus50.Free;
    FIFPlus20.Free;
    FKSens50.Free;
    FKSens20.Free;
    FNote.Create;
    inherited;
end;

function TProduct.ToJsonString: string;
begin
    result := TJson.ObjectToJsonString(self);
end;

class function TProduct.FromJsonString(AJsonString: string): TProduct;
begin
    result := TJson.JsonToObject<TProduct>(AJsonString)
end;

{ TParty }

destructor TParty.Destroy;
var
    LProductsItem: TProduct;
begin
    for LProductsItem in FProducts do
        LProductsItem.Free;
    FNote.Free;
    inherited;
end;

function TParty.ToJsonString: string;
begin
    result := TJson.ObjectToJsonString(self);
end;

class function TParty.FromJsonString(AJsonString: string): TParty;
begin
    result := TJson.JsonToObject<TParty>(AJsonString)
end;

//function TSQLFloat.Str: string;
//begin
//    if FValid then
//        result := floattostr(FFloat64)
//    else
//        result := '';
//end;
//
//function TSQLInt64.Str: string;
//begin
//    if FValid then
//        result := inttostr(FInt64)
//    else
//        result := '';
//end;
//
//function TSQLString.Str: string;
//begin
//    if FValid then
//        result := FString
//    else
//        result := '';
//end;



end.
