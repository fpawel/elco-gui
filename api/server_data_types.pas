
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
        Valid : Boolean;
        Float64 : Double;
        
    end;
    
    TProductInfo = record
    public
        I24 : TNullFloat64;
        I26 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKDFon20 : Boolean;
        PointsMethod : TNullInt64;
        NoteParty : TNullString;
        UnitsCode : Byte;
        Scale : Double;
        Serial : TNullInt64;
        IFPlus50 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        NotMeasured : TNullFloat64;
        OKMinFon20r : Boolean;
        OKMaxKSens20 : Boolean;
        LifetimeMonths : Int64;
        IFMinus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMaxKSens50 : Boolean;
        UnitsName : string;
        NobleMetalContent : Double;
        ProductID : Int64;
        I35 : TNullFloat64;
        KSens20 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKMaxFon20r : Boolean;
        AppliedProductTypeName : string;
        PartyID : Int64;
        Place : Integer;
        I13 : TNullFloat64;
        Variation : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMinKSens50 : Boolean;
        NoteProduct : TNullString;
        IFPlus20 : TNullFloat64;
        I17 : TNullFloat64;
        OKDNotMeasured : Boolean;
        HasFirmware : Boolean;
        GasCode : Byte;
        GasName : string;
        ISMinus20 : TNullFloat64;
        OKMinKSens20 : Boolean;
        Ok : Boolean;
        Production : Boolean;
        ProductTypeName : TNullString;
        CreatedAt : TDateTime;
        KSensMinus20 : TNullFloat64;
        KSens50 : TNullFloat64;
        OKDFon50 : Boolean;
        AppliedPointsMethod : Int64;
        
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
        ProductTypeName : string;
        Note : TNullString;
        MaxKSens50 : TNullFloat64;
        MinDTemp : TNullFloat64;
        Concentration3 : Double;
        MinFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        MinKSens50 : TNullFloat64;
        Concentration1 : Double;
        Concentration2 : Double;
        MaxFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        PointsMethod : Int64;
        
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
        ScaleEnd : string;
        ISMinus20 : string;
        ISPlus20 : string;
        ProductType : string;
        Units : string;
        Serial : string;
        Gas : string;
        ISPlus50 : string;
        Fon : TArray<Double>;
        Sensitivity : string;
        Place : Integer;
        CreatedAt : TGoDateTime;
        ScaleBeg : string;
        Temp : TArray<Double>;
        Sens : TArray<Double>;
        
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
        ComportGas : string;
        ChipType : string;
        AmbientTemperature : Double;
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        EndScaleGas2 : Boolean;
        ComportMeasurer : string;
        
    end;
    
    TCell = record
    public
        Str : string;
        Res : Integer;
        TextAlignment : Integer;
        
    end;
    
    TProductCurrent = record
    public
        Gas : Integer;
        CurrentValue : Double;
        Note : string;
        ProductCurrentID : Int64;
        StoredAt : TDateTime;
        ProductID : Int64;
        Temperature : Double;
        
    end;
    
    TReadCurrent = record
    public
        Values : TArray<Double>;
        Block : Integer;
        
    end;
    
    TWorkResult = record
    public
        Tag : Integer;
        Message : string;
        WorkName : string;
        
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