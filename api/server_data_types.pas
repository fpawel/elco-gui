 
unit server_data_types;

interface
    
type
     
    TNullString = class 
    public 
        FString : string;
        FValid : Boolean;
        
    end;
 
    TNullInt64 = class 
    public 
        FInt64 : Int64;
        FValid : Boolean;
        
    end;
 
    TNullFloat64 = class 
    public 
        FFloat64 : Double;
        FValid : Boolean;
        
    end;
 
    TNullBool = class 
    public 
        FBool : Boolean;
        FValid : Boolean;
        
    end;
 
    TProduct = class 
    public 
        FProductID : Int64;
        FPartyID : Int64;
        FSerial : TTNullInt64;
        FPlace : Integer;
        FCreatedAt : TDateTime;
        FIFMinus20 : TTNullFloat64;
        FIFPlus20 : TTNullFloat64;
        FIFPlus50 : TTNullFloat64;
        FISMinus20 : TTNullFloat64;
        FISPlus20 : TTNullFloat64;
        FISPlus50 : TTNullFloat64;
        FI13 : TTNullFloat64;
        FI24 : TTNullFloat64;
        FI35 : TTNullFloat64;
        FI26 : TTNullFloat64;
        FI17 : TTNullFloat64;
        FNotMeasured : TTNullFloat64;
        FKSensMinus20 : TTNullFloat64;
        FKSens20 : TTNullFloat64;
        FKSens50 : TTNullFloat64;
        FDFon20 : TTNullFloat64;
        FDFon50 : TTNullFloat64;
        FDNotMeasured : TTNullFloat64;
        FOKFon20 : TTNullBool;
        FOKDFon20 : TTNullBool;
        FOKKSens20 : TTNullBool;
        FOKDFon50 : TTNullBool;
        FOKKSens50 : TTNullBool;
        FOKDNotMeasured : TTNullBool;
        FNotOk : TTNullBool;
        FHasFirmware : Boolean;
        FProduction : Boolean;
        FAppliedProductTypeName : string;
        FGasCode : Byte;
        FUnitsCode : Byte;
        FGasName : string;
        FUnitsName : string;
        FScale : Double;
        FNobleMetalContent : Double;
        FLifetimeMonths : Int64;
        FLc64 : Boolean;
        FPointsMethod : Int64;
        FProductTypeName : TTNullString;
        FNote : TTNullString;
         
        constructor Create;
        destructor Destroy;
    end;
 
    TParty = class 
    public 
        FPartyID : Int64;
        FCreatedAt : TDateTime;
        FUpdatedAt : TDateTime;
        FProductTypeName : string;
        FConcentration1 : Double;
        FConcentration2 : Double;
        FConcentration3 : Double;
        FNote : TTNullString;
        FLast : Boolean;
        FProducts : TArray<TProduct>;
         
        constructor Create;
        destructor Destroy;
    end;
 
implementation 
    uses Rest.Json;   
      
//
//TProduct
//
 
constructor TProduct.Create;
begin
    FSerial := TNullInt64.Create;
    FIFMinus20 := TNullFloat64.Create;
    FIFPlus20 := TNullFloat64.Create;
    FIFPlus50 := TNullFloat64.Create;
    FISMinus20 := TNullFloat64.Create;
    FISPlus20 := TNullFloat64.Create;
    FISPlus50 := TNullFloat64.Create;
    FI13 := TNullFloat64.Create;
    FI24 := TNullFloat64.Create;
    FI35 := TNullFloat64.Create;
    FI26 := TNullFloat64.Create;
    FI17 := TNullFloat64.Create;
    FNotMeasured := TNullFloat64.Create;
    FKSensMinus20 := TNullFloat64.Create;
    FKSens20 := TNullFloat64.Create;
    FKSens50 := TNullFloat64.Create;
    FDFon20 := TNullFloat64.Create;
    FDFon50 := TNullFloat64.Create;
    FDNotMeasured := TNullFloat64.Create;
    FOKFon20 := TNullBool.Create;
    FOKDFon20 := TNullBool.Create;
    FOKKSens20 := TNullBool.Create;
    FOKDFon50 := TNullBool.Create;
    FOKKSens50 := TNullBool.Create;
    FOKDNotMeasured := TNullBool.Create;
    FNotOk := TNullBool.Create;
    FProductTypeName := TNullString.Create;
    FNote := TNullString.Create;
    
end;
 
destructor TProduct.Destroy;
begin
    if Assigned(FSerial) then 
        FSerial.Free;
    if Assigned(FIFMinus20) then 
        FIFMinus20.Free;
    if Assigned(FIFPlus20) then 
        FIFPlus20.Free;
    if Assigned(FIFPlus50) then 
        FIFPlus50.Free;
    if Assigned(FISMinus20) then 
        FISMinus20.Free;
    if Assigned(FISPlus20) then 
        FISPlus20.Free;
    if Assigned(FISPlus50) then 
        FISPlus50.Free;
    if Assigned(FI13) then 
        FI13.Free;
    if Assigned(FI24) then 
        FI24.Free;
    if Assigned(FI35) then 
        FI35.Free;
    if Assigned(FI26) then 
        FI26.Free;
    if Assigned(FI17) then 
        FI17.Free;
    if Assigned(FNotMeasured) then 
        FNotMeasured.Free;
    if Assigned(FKSensMinus20) then 
        FKSensMinus20.Free;
    if Assigned(FKSens20) then 
        FKSens20.Free;
    if Assigned(FKSens50) then 
        FKSens50.Free;
    if Assigned(FDFon20) then 
        FDFon20.Free;
    if Assigned(FDFon50) then 
        FDFon50.Free;
    if Assigned(FDNotMeasured) then 
        FDNotMeasured.Free;
    if Assigned(FOKFon20) then 
        FOKFon20.Free;
    if Assigned(FOKDFon20) then 
        FOKDFon20.Free;
    if Assigned(FOKKSens20) then 
        FOKKSens20.Free;
    if Assigned(FOKDFon50) then 
        FOKDFon50.Free;
    if Assigned(FOKKSens50) then 
        FOKKSens50.Free;
    if Assigned(FOKDNotMeasured) then 
        FOKDNotMeasured.Free;
    if Assigned(FNotOk) then 
        FNotOk.Free;
    if Assigned(FProductTypeName) then 
        FProductTypeName.Free;
    if Assigned(FNote) then 
        FNote.Free;
    
end;
  
//
//TParty
//
 
constructor TParty.Create;
begin
    FNote := TNullString.Create;
    
end;
 
destructor TParty.Destroy;
begin
    if Assigned(FNote) then 
        FNote.Free;
    
end;


end.