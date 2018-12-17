 
unit server_data_types;

interface
    
type
     
    TNullString = class 
    public 
        FString : string;
        FValid : Boolean;
        
    end;
 
    TNullFloat64 = class 
    public 
        FFloat64 : Double;
        FValid : Boolean;
        
    end;
 
    TNullInt64 = class 
    public 
        FInt64 : Int64;
        FValid : Boolean;
        
    end;
 
    TProduct = class 
    public 
        FProductID : Int64;
        FPartyID : Int64;
        FSerial : TNullInt64;
        FPlace : Integer;
        FCreatedAt : TDateTime;
        FIFMinus20 : TNullFloat64;
        FIFPlus20 : TNullFloat64;
        FIFPlus50 : TNullFloat64;
        FISMinus20 : TNullFloat64;
        FISPlus20 : TNullFloat64;
        FISPlus50 : TNullFloat64;
        FI13 : TNullFloat64;
        FI24 : TNullFloat64;
        FI35 : TNullFloat64;
        FI26 : TNullFloat64;
        FI17 : TNullFloat64;
        FNotMeasured : TNullFloat64;
        FKSensMinus20 : TNullFloat64;
        FKSens20 : TNullFloat64;
        FKSens50 : TNullFloat64;
        FDFon20 : TNullFloat64;
        FDFon50 : TNullFloat64;
        FDNotMeasured : TNullFloat64;
        FOKMinFon20 : Boolean;
        FOKMaxFon20 : Boolean;
        FOKMinFon20r : Boolean;
        FOKMaxFon20r : Boolean;
        FOKDFon20 : Boolean;
        FOKMinKSens20 : Boolean;
        FOKMaxKSens20 : Boolean;
        FOKMinKSens50 : Boolean;
        FOKMaxKSens50 : Boolean;
        FOKDFon50 : Boolean;
        FOKDNotMeasured : Boolean;
        FOk : Boolean;
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
        FProductTypeName : TNullString;
        FNote : TNullString;
         
        constructor Create;
        destructor Destroy;
    end;
 
    TParty = class 
    public 
        FPartyID : Int64;
        FOldPartyID : TNullString;
        FCreatedAt : TDateTime;
        FUpdatedAt : TDateTime;
        FProductTypeName : string;
        FConcentration1 : Double;
        FConcentration2 : Double;
        FConcentration3 : Double;
        FNote : TNullString;
        FMinFon : TNullFloat64;
        FMaxFon : TNullFloat64;
        FMaxDFon : TNullFloat64;
        FMinKSens20 : TNullFloat64;
        FMaxKSens20 : TNullFloat64;
        FMinKSens50 : TNullFloat64;
        FMaxKSens50 : TNullFloat64;
        FMinDTemp : TNullFloat64;
        FMaxDTemp : TNullFloat64;
        FMaxDNotMeasured : TNullFloat64;
        FProducts : TArray<TProduct>;
        FLast : Boolean;
         
        constructor Create;
        destructor Destroy;
    end;
 
    TProductFirmwareInfo = class 
    public 
        FTemp : TArray<Double>;
        FFon : TArray<Double>;
        FSens : TArray<Double>;
        FTime : TDateTime;
        FSensitivity : string;
        FSerial : string;
        FProductType : string;
        FGas : string;
        FUnits : string;
        FScale : string;
        
    end;
 
    TTempPoints = class 
    public 
        FTemp : TArray<Double>;
        FFon : TArray<Double>;
        FSens : TArray<Double>;
        
    end;
 
    TConfigProperty = class 
    public 
        FHint : string;
        FName : string;
        FValue : string;
        FError : string;
        FMin : TNullFloat64;
        FMax : TNullFloat64;
        FValueType : Integer;
        FList : TArray<string>;
         
        constructor Create;
        destructor Destroy;
    end;
 
    TConfigSection = class 
    public 
        FName : string;
        FHint : string;
        FProperties : TArray<TConfigProperty>;
        
    end;
 
    TConfigSections = class 
    public 
        FSections : TArray<TConfigSection>;
        
    end;
 
    TReadCurrent = class 
    public 
        FValues : TArray<Double>;
        FPlace : Integer;
        
    end;
 
    TDelayInfo = class 
    public 
        FRun : Boolean;
        FTimeSeconds : Integer;
        FWhat : string;
        
    end;
 
implementation 
    uses Rest.Json;   
     

{ TProduct }

 
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
    if Assigned(FProductTypeName) then 
        FProductTypeName.Free;
    if Assigned(FNote) then 
        FNote.Free;
    
end;
  

{ TParty }

 
constructor TParty.Create;
begin
    FOldPartyID := TNullString.Create;
    FNote := TNullString.Create;
    FMinFon := TNullFloat64.Create;
    FMaxFon := TNullFloat64.Create;
    FMaxDFon := TNullFloat64.Create;
    FMinKSens20 := TNullFloat64.Create;
    FMaxKSens20 := TNullFloat64.Create;
    FMinKSens50 := TNullFloat64.Create;
    FMaxKSens50 := TNullFloat64.Create;
    FMinDTemp := TNullFloat64.Create;
    FMaxDTemp := TNullFloat64.Create;
    FMaxDNotMeasured := TNullFloat64.Create;
    
end;
 
destructor TParty.Destroy;
begin
    if Assigned(FOldPartyID) then 
        FOldPartyID.Free;
    if Assigned(FNote) then 
        FNote.Free;
    if Assigned(FMinFon) then 
        FMinFon.Free;
    if Assigned(FMaxFon) then 
        FMaxFon.Free;
    if Assigned(FMaxDFon) then 
        FMaxDFon.Free;
    if Assigned(FMinKSens20) then 
        FMinKSens20.Free;
    if Assigned(FMaxKSens20) then 
        FMaxKSens20.Free;
    if Assigned(FMinKSens50) then 
        FMinKSens50.Free;
    if Assigned(FMaxKSens50) then 
        FMaxKSens50.Free;
    if Assigned(FMinDTemp) then 
        FMinDTemp.Free;
    if Assigned(FMaxDTemp) then 
        FMaxDTemp.Free;
    if Assigned(FMaxDNotMeasured) then 
        FMaxDNotMeasured.Free;
    
end;
    

{ TConfigProperty }

 
constructor TConfigProperty.Create;
begin
    FMin := TNullFloat64.Create;
    FMax := TNullFloat64.Create;
    
end;
 
destructor TConfigProperty.Destroy;
begin
    if Assigned(FMin) then 
        FMin.Free;
    if Assigned(FMax) then 
        FMax.Free;
    
end;
    

end.