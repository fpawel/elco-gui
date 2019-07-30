
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
     
    TNullString = record
    public 
         [BsonElement('String')]Str : string;
        Valid : Boolean;
        
    end;
 
    TNullFloat64 = record
    public 
        Float64 : Double;
        Valid : Boolean;
        
    end;
 
    TNullInt64 = record
    public 
        Int64 : Int64;
        Valid : Boolean;
        
    end;
 
    TProduct = record
    public 
        ProductID : Int64;
        PartyID : Int64;
        Serial : TNullInt64;
        Place : Integer;
        CreatedAt : TDateTime;
        IFMinus20 : TNullFloat64;
        IFPlus20 : TNullFloat64;
        IFPlus50 : TNullFloat64;
        ISMinus20 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        I13 : TNullFloat64;
        I24 : TNullFloat64;
        I35 : TNullFloat64;
        I26 : TNullFloat64;
        I17 : TNullFloat64;
        NotMeasured : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        KSens20 : TNullFloat64;
        KSens50 : TNullFloat64;
        Variation : TNullFloat64;
        DFon20 : TNullFloat64;
        DFon50 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMaxFon20 : Boolean;
        OKMinFon20r : Boolean;
        OKMaxFon20r : Boolean;
        OKDFon20 : Boolean;
        OKMinKSens20 : Boolean;
        OKMaxKSens20 : Boolean;
        OKMinKSens50 : Boolean;
        OKMaxKSens50 : Boolean;
        OKDFon50 : Boolean;
        OKDNotMeasured : Boolean;
        Ok : Boolean;
        HasFirmware : Boolean;
        Production : Boolean;
        AppliedProductTypeName : string;
        GasCode : Byte;
        UnitsCode : Byte;
        GasName : string;
        UnitsName : string;
        Scale : Double;
        NobleMetalContent : Double;
        LifetimeMonths : Int64;
        PointsMethod : TNullInt64;
        AppliedPointsMethod : Int64;
        ProductTypeName : TNullString;
        Note : TNullString;
        
    end;
 
    TParty = record
    public 
        PartyID : Int64;
        OldPartyID : TNullString;
        CreatedAt : TDateTime;
        UpdatedAt : TDateTime;
        ProductTypeName : string;
        Concentration1 : Double;
        Concentration2 : Double;
        Concentration3 : Double;
        Note : TNullString;
        MinFon : TNullFloat64;
        MaxFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MinDTemp : TNullFloat64;
        MaxDTemp : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        PointsMethod : Int64;
        Products : TArray<TProduct>;
        Last : Boolean;
        
    end;
 
    TGetCheckBlocksArg = record
    public 
        Check : TArray<Boolean>;
        
    end;
 
    TLastPartyValues = record
    public 
        ProductTypeName : string;
        Concentration1 : Double;
        Concentration2 : Double;
        Concentration3 : Double;
        Note : TNullString;
        MinFon : TNullFloat64;
        MaxFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MinDTemp : TNullFloat64;
        MaxDTemp : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        PointsMethod : Int64;
        
    end;
 
    TGoDateTime = record
    public 
        Year : Integer;
        Month : Integer;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        Second : Integer;
        Millisecond : Integer;
        
    end;
 
    TFirmwareInfo = record
    public 
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        Place : Integer;
        CreatedAt : TGoDateTime;
        Sensitivity : string;
        Serial : string;
        ProductType : string;
        Gas : string;
        Units : string;
        ScaleBeg : string;
        ScaleEnd : string;
        ISMinus20 : string;
        ISPlus20 : string;
        ISPlus50 : string;
        
    end;
 
    TTempPoints = record
    public 
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        
    end;
 
    TGuiSettings = record
    public 
        ComportMeasurer : string;
        ComportGas : string;
        ChipType : string;
        AmbientTemperature : Double;
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        EndScaleGas2 : Boolean;
        
    end;
 
    TReadCurrent = record
    public 
        Values : TArray<Double>;
        Block : Integer;
        
    end;
 
    TKtx500Info = record
    public 
        Temperature : Double;
        Destination : Double;
        TemperatureOn : Boolean;
        CoolOn : Boolean;
        
    end;
 
    TDelayInfo = record
    public 
        TotalSeconds : Integer;
        ElapsedSeconds : Integer;
        What : string;
        
    end;


implementation 



end.