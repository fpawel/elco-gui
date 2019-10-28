
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
        Note : TNullString;
        Last : Boolean;
        PartyID : Int64;
        Day : Integer;
        ProductTypeName : string;
        
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
        HasFirmware : Boolean;
        UnitsCode : Byte;
        LifetimeMonths : Int64;
        ISMinus20 : TNullFloat64;
        I17 : TNullFloat64;
        NotMeasured : TNullFloat64;
        OKMinKSens20 : Boolean;
        AppliedProductTypeName : string;
        IFMinus20 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMinFon20 : Boolean;
        OKDFon50 : Boolean;
        ProductID : Int64;
        Place : Integer;
        ISPlus50 : TNullFloat64;
        I13 : TNullFloat64;
        OKMaxKSens20 : Boolean;
        OKDNotMeasured : Boolean;
        ProductTypeName : TNullString;
        CreatedAt : TDateTime;
        IFPlus20 : TNullFloat64;
        I24 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        KSens20 : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMinKSens50 : Boolean;
        AppliedPointsMethod : Int64;
        OKDFon20 : Boolean;
        PointsMethod : TNullInt64;
        NoteProduct : TNullString;
        PartyID : Int64;
        I26 : TNullFloat64;
        Variation : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKMaxKSens50 : Boolean;
        Ok : Boolean;
        Production : Boolean;
        GasName : string;
        Serial : TNullInt64;
        I35 : TNullFloat64;
        KSens50 : TNullFloat64;
        OKMinFon20r : Boolean;
        UnitsName : string;
        NoteParty : TNullString;
        Scale : Double;
        NobleMetalContent : Double;
        IFPlus50 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        DFon20 : TNullFloat64;
        GasCode : Byte;
        
    end;
    
    TParty1 = record
    public
        CreatedAt : TDateTime;
        Products : TArray<TProductInfo>;
        PartyID : Int64;
        
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
        MaxKSens50 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        Concentration2 : Double;
        MinFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        Concentration1 : Double;
        PointsMethod : Int64;
        MinKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        ProductTypeName : string;
        Concentration3 : Double;
        MaxFon : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        Note : TNullString;
        MaxKSens20 : TNullFloat64;
        MinDTemp : TNullFloat64;
        
    end;
    
    TGoDateTime = record
    public
        Millisecond : Integer;
        Year : Integer;
        Month : Integer;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        Second : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
        Sensitivity : string;
        Serial : string;
        ISMinus20 : string;
        ProductType : string;
        Gas : string;
        ScaleBeg : string;
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        Place : Integer;
        CreatedAt : TGoDateTime;
        Sensitivity1 : string;
        Units : string;
        ScaleEnd : string;
        IFPlus20 : string;
        ISPlus20 : string;
        ISPlus50 : string;
        
    end;
    
    TTempPoints = record
    public
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        
    end;
    
    TRunScriptResult = record
    public
        ErrorLine : string;
        ErrorLineno : Integer;
        
    end;
    
    TGuiSettings = record
    public
        HoldTemperatureMinutes : Integer;
        EndScaleGas2 : Boolean;
        ComportMeasurer : string;
        ComportGas : string;
        ChipType : string;
        AmbientTemperature : Double;
        BlowGasMinutes : Integer;
        
    end;
    
    TCell = record
    public
        Res : Integer;
        TextAlignment : Integer;
        Str : string;
        
    end;
    
    TProductCurrent = record
    public
        ProductCurrentID : Int64;
        StoredAt : TDateTime;
        ProductID : Int64;
        Temperature : Double;
        Gas : Integer;
        CurrentValue : Double;
        Note : string;
        
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