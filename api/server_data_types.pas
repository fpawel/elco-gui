
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
        ISPlus20 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        NobleMetalContent : Double;
        ProductTypeName : TNullString;
        NoteProduct : TNullString;
        PartyID : Int64;
        IFMinus20 : TNullFloat64;
        IFPlus20 : TNullFloat64;
        IFPlus50 : TNullFloat64;
        I35 : TNullFloat64;
        I26 : TNullFloat64;
        KSens20 : TNullFloat64;
        DFon20 : TNullFloat64;
        Scale : Double;
        Serial : TNullInt64;
        Place : Integer;
        KSens50 : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMinKSens20 : Boolean;
        Ok : Boolean;
        I17 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMinKSens50 : Boolean;
        OKMaxKSens50 : Boolean;
        UnitsCode : Byte;
        AppliedPointsMethod : Int64;
        I13 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKDFon50 : Boolean;
        Production : Boolean;
        AppliedProductTypeName : string;
        ISMinus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        OKDFon20 : Boolean;
        OKDNotMeasured : Boolean;
        GasName : string;
        CreatedAt : TDateTime;
        I24 : TNullFloat64;
        Variation : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMinFon20r : Boolean;
        OKMaxKSens20 : Boolean;
        GasCode : Byte;
        UnitsName : string;
        LifetimeMonths : Int64;
        PointsMethod : TNullInt64;
        NoteParty : TNullString;
        ProductID : Int64;
        NotMeasured : TNullFloat64;
        HasFirmware : Boolean;
        
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
        PointsMethod : Int64;
        MaxKSens50 : string;
        MinDTemp : string;
        MaxDNotMeasured : string;
        ProductTypeName : string;
        Note : string;
        MaxFon : string;
        MaxDFon : string;
        MaxKSens20 : string;
        MinKSens50 : string;
        MaxDTemp : string;
        Concentration2 : Double;
        Concentration3 : Double;
        MinFon : string;
        Concentration1 : Double;
        MinKSens20 : string;
        
    end;
    
    TGoDateTime = record
    public
        Second : Integer;
        Millisecond : Integer;
        Year : Integer;
        Month : Integer;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
        ISMinus20 : string;
        ISPlus20 : string;
        Place : Integer;
        Sensitivity : string;
        Serial : string;
        Gas : string;
        ScaleEnd : string;
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        ProductType : string;
        ScaleBeg : string;
        Sens : TArray<Double>;
        CreatedAt : TGoDateTime;
        Sensitivity1 : string;
        Units : string;
        IFPlus20 : string;
        ISPlus50 : string;
        
    end;
    
    TFirmwareInfo2 = record
    public
        Values : TArray<string>;
        Day : Integer;
        Minute : Integer;
        Second : Integer;
        Sensitivity : string;
        Serial : string;
        ProductType : string;
        ScaleBegin : string;
        Month : Integer;
        Place : Integer;
        Units : string;
        ScaleEnd : string;
        Year : Integer;
        Hour : Integer;
        Gas : string;
        
    end;
    
    TTempPoints = record
    public
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        
    end;
    
    TRunScriptResult = record
    public
        ErrorLineno : Integer;
        ErrorLine : string;
        
    end;
    
    TPublicAppConfig = record
    public
        ComportGasName : string;
        ComportName2 : string;
        LogComm : Boolean;
        AmbientTemperature : Double;
        ComportName : string;
        ChipType : string;
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        EndScaleGas2 : Boolean;
        
    end;
    
    TCell = record
    public
        TextAlignment : Integer;
        Str : string;
        Res : Integer;
        
    end;
    
    TProductCurrent = record
    public
        StoredAt : TDateTime;
        ProductID : Int64;
        Temperature : Double;
        Gas : Integer;
        CurrentValue : Double;
        Note : string;
        ProductCurrentID : Int64;
        
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
        Temperature : Double;
        Destination : Double;
        TemperatureOn : Boolean;
        CoolOn : Boolean;
        
    end;
    
    TDelayInfo = record
    public
        ElapsedSeconds : Integer;
        What : string;
        TotalSeconds : Integer;
        
    end;
    
    TScriptLine = record
    public
        Lineno : Integer;
        Line : string;
        
    end;
    

implementation

end.