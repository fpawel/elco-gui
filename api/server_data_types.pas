
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
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
    
    TNullString = record
    public
        [BsonElement('String')]Str  : string;
        Valid : Boolean;
        
    end;
    
    TProductInfo = record
    public
        IFPlus20 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMinFon20 : Boolean;
        OKDFon20 : Boolean;
        OKDNotMeasured : Boolean;
        ProductTypeName : TNullString;
        PartyID : Int64;
        CreatedAt : TDateTime;
        IFPlus50 : TNullFloat64;
        I35 : TNullFloat64;
        NotMeasured : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKMinFon20r : Boolean;
        OKMaxKSens50 : Boolean;
        AppliedProductTypeName : string;
        UnitsCode : Byte;
        UnitsName : string;
        LifetimeMonths : Int64;
        ISMinus20 : TNullFloat64;
        I17 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKDFon50 : Boolean;
        NoteProduct : TNullString;
        IFMinus20 : TNullFloat64;
        I26 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        Scale : Double;
        Serial : TNullInt64;
        KSens20 : TNullFloat64;
        OKMaxFon20r : Boolean;
        Place : Integer;
        Variation : TNullFloat64;
        OKMinKSens50 : Boolean;
        Ok : Boolean;
        Production : Boolean;
        GasCode : Byte;
        PointsMethod : TNullInt64;
        ProductID : Int64;
        I13 : TNullFloat64;
        I24 : TNullFloat64;
        HasFirmware : Boolean;
        NobleMetalContent : Double;
        AppliedPointsMethod : Int64;
        NoteParty : TNullString;
        KSens50 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKMinKSens20 : Boolean;
        OKMaxKSens20 : Boolean;
        GasName : string;
        
    end;
    
    TParty1 = record
    public
        PartyID : Int64;
        CreatedAt : TDateTime;
        Products : TArray<TProductInfo>;
        
    end;
    
    TParty2 = record
    public
        PartyID : Int64;
        Day : Integer;
        ProductTypeName : string;
        Note : TNullString;
        Last : Boolean;
        
    end;
    
    TYearMonth = record
    public
        Month : Integer;
        Year : Integer;
        
    end;
    
    TGetCheckBlocksArg = record
    public
        Check : TArray<Boolean>;
        
    end;
    
    TParty3 = record
    public
        MaxDFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        PointsMethod : Int64;
        Concentration1 : Double;
        Concentration2 : Double;
        Concentration3 : Double;
        MaxFon : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        MinFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        ProductTypeName : string;
        Note : TNullString;
        MinDTemp : TNullFloat64;
        
    end;
    
    TGoDateTime = record
    public
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        Second : Integer;
        Millisecond : Integer;
        Year : Integer;
        Month : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
        CreatedAt : TGoDateTime;
        Serial : string;
        ISPlus50 : string;
        Temp : TArray<Double>;
        Place : Integer;
        ProductType : string;
        Gas : string;
        Units : string;
        Sens : TArray<Double>;
        Sensitivity : string;
        ScaleEnd : string;
        ISMinus20 : string;
        ISPlus20 : string;
        Fon : TArray<Double>;
        ScaleBeg : string;
        
    end;
    
    TTempPoints = record
    public
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        
    end;
    
    TGuiSettings = record
    public
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        EndScaleGas2 : Boolean;
        ComportMeasurer : string;
        ComportGas : string;
        ChipType : string;
        AmbientTemperature : Double;
        
    end;
    
    TCell = record
    public
        Res : Integer;
        TextAlignment : Integer;
        Str : string;
        
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
        TemperatureOn : Boolean;
        CoolOn : Boolean;
        Temperature : Double;
        Destination : Double;
        
    end;
    
    TDelayInfo = record
    public
        TotalSeconds : Integer;
        ElapsedSeconds : Integer;
        What : string;
        
    end;
    

implementation

end.