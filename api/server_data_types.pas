
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
    TNullString = record
    public
        [BsonElement('String')]Str  : string;
        Valid : Boolean;
        
    end;
    
    TParty2 = record
    public
        PartyID : Int64;
        Day : Integer;
        ProductTypeName : string;
        Note : TNullString;
        Last : Boolean;
        
    end;
    
    TNullInt64 = record
    public
        Int64 : Int64;
        Valid : Boolean;
        
    end;
    
    TNullFloat64 = record
    public
        Float64 : Double;
        Valid : Boolean;
        
    end;
    
    TProductInfo = record
    public
        ISMinus20 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        GasCode : Byte;
        UnitsName : string;
        Scale : Double;
        KSensMinus20 : TNullFloat64;
        OKDFon20 : Boolean;
        OKMaxKSens50 : Boolean;
        VariationConcentration : TNullFloat64;
        OKMaxD35 : Boolean;
        Ok : Boolean;
        GasName : string;
        LifetimeMonths : Int64;
        PointsMethod : TNullInt64;
        IFPlus20 : TNullFloat64;
        OKMaxKSens20 : Boolean;
        AppliedProductTypeName : string;
        NobleMetalContent : Double;
        D35 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKMaxD26 : Boolean;
        Place : Integer;
        OKMaxFon20r : Boolean;
        Production : Boolean;
        D24 : TNullFloat64;
        OKMinKSens50 : Boolean;
        HasFirmware : Boolean;
        NoteProduct : TNullString;
        I13 : TNullFloat64;
        I24 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMaxD13 : Boolean;
        KSens50 : TNullFloat64;
        D26 : TNullFloat64;
        OKMinFon20r : Boolean;
        NotMeasured : TNullFloat64;
        KSens20 : TNullFloat64;
        D13 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKDFon50 : Boolean;
        I35 : TNullFloat64;
        I26 : TNullFloat64;
        PartyID : Int64;
        Serial : TNullInt64;
        ISPlus50 : TNullFloat64;
        I17 : TNullFloat64;
        UnitsCode : Byte;
        ProductID : Int64;
        OKMaxD24 : Boolean;
        ProductTypeName : TNullString;
        CreatedAt : TDateTime;
        OKDNotMeasured : Boolean;
        OKMinFon20 : Boolean;
        OKMaxD17 : Boolean;
        AppliedPointsMethod : Int64;
        NoteParty : TNullString;
        IFPlus50 : TNullFloat64;
        Variation : TNullFloat64;
        D17 : TNullFloat64;
        IFMinus20 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKMinKSens20 : Boolean;
        
    end;
    
    TParty1 = record
    public
        PartyID : Int64;
        CreatedAt : TDateTime;
        Products : TArray<TProductInfo>;
        
    end;
    
    TYearMonth = record
    public
        Year : Integer;
        Month : Integer;
        
    end;
    
    TGetCheckBlocksArg = record
    public
        Check : TArray<Boolean>;
        
    end;
    
    TParty3 = record
    public
        MinKSens50 : string;
        MaxD1 : string;
        MaxD2 : string;
        MaxKSens20 : string;
        MinFon : string;
        MaxFon : string;
        MaxD3 : string;
        Concentration3 : Double;
        Concentration1 : Double;
        Concentration2 : Double;
        MaxKSens50 : string;
        MinDTemp : string;
        ProductTypeName : string;
        MaxDFon : string;
        MinKSens20 : string;
        MaxDTemp : string;
        MaxDNotMeasured : string;
        PointsMethod : Int64;
        Note : string;
        
    end;
    
    TTempPoints = record
    public
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        
    end;
    
    TFirmwareInfo = record
    public
        Second : Integer;
        SensitivityLab73 : string;
        Units : string;
        ScaleEnd : string;
        Hour : Integer;
        Gas : string;
        ScaleBeg : string;
        TempValues : TArray<string>;
        Serial : string;
        Year : Integer;
        Month : Integer;
        Day : Integer;
        Minute : Integer;
        SensitivityProduct : string;
        Fon20 : string;
        ProductType : string;
        ProductTempPoints : TTempPoints;
        
    end;
    
    TProductType2 = record
    public
        MinDTemp : TNullFloat64;
        KSens20 : TNullFloat64;
        MaxD2 : TNullFloat64;
        PointsMethod : Int64;
        ProductTypeName : string;
        UnitsName : string;
        MaxFon : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        GasName : string;
        NobleMetalContent : Double;
        MinFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MaxDTemp : TNullFloat64;
        MaxD3 : TNullFloat64;
        Currents : TArray<TArray<string>>;
        TempPoints : TTempPoints;
        Scale : Double;
        LifetimeMonths : Int64;
        Fon20 : TNullFloat64;
        MaxD1 : TNullFloat64;
        
    end;
    
    TRunScriptResult = record
    public
        ErrorLine : string;
        ErrorLineno : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
        ComportGasName : string;
        LogComm : Boolean;
        HoldTemperatureMinutes : Integer;
        BlowGasMinutes : Integer;
        EndScaleGas2 : Boolean;
        ComportName : string;
        ComportName2 : string;
        ChipType : string;
        AmbientTemperature : Double;
        
    end;
    
    TCell = record
    public
        Str : string;
        Res : Integer;
        TextAlignment : Integer;
        
    end;
    
    TProductCurrent = record
    public
        Note : string;
        ProductCurrentID : Int64;
        StoredAt : TDateTime;
        ProductID : Int64;
        Temperature : Double;
        Gas : Integer;
        CurrentValue : Double;
        
    end;
    
    TReadCurrent = record
    public
        Values : TArray<Double>;
        Block : Integer;
        
    end;
    
    TWorkResult = record
    public
        WorkName : string;
        Tag : Integer;
        Message : string;
        
    end;
    
    TKtx500Info = record
    public
        CoolOn : Boolean;
        Temperature : Double;
        Destination : Double;
        TemperatureOn : Boolean;
        
    end;
    
    TDelayInfo = record
    public
        TotalSeconds : Integer;
        ElapsedSeconds : Integer;
        What : string;
        
    end;
    
    TScriptLine = record
    public
        Lineno : Integer;
        Line : string;
        
    end;
    

implementation

end.