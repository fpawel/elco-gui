
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
        OKMinFon20 : Boolean;
        OKMinKSens20 : Boolean;
        UnitsName : string;
        NoteParty : TNullString;
        AppliedProductTypeName : string;
        IFPlus50 : TNullFloat64;
        KSens20 : TNullFloat64;
        KSens50 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMaxKSens20 : Boolean;
        PointsMethod : TNullInt64;
        IFPlus20 : TNullFloat64;
        ISMinus20 : TNullFloat64;
        NotMeasured : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        AppliedPointsMethod : Int64;
        ProductTypeName : TNullString;
        PartyID : Int64;
        Serial : TNullInt64;
        I26 : TNullFloat64;
        Scale : Double;
        OKDNotMeasured : Boolean;
        LifetimeMonths : Int64;
        I24 : TNullFloat64;
        I35 : TNullFloat64;
        OKMinFon20r : Boolean;
        OKDFon50 : Boolean;
        Production : Boolean;
        ProductID : Int64;
        Variation : TNullFloat64;
        Ok : Boolean;
        HasFirmware : Boolean;
        OKDFon20 : Boolean;
        UnitsCode : Byte;
        NobleMetalContent : Double;
        NoteProduct : TNullString;
        IFMinus20 : TNullFloat64;
        I17 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMaxFon20 : Boolean;
        I13 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKMinKSens50 : Boolean;
        OKMaxKSens50 : Boolean;
        Place : Integer;
        CreatedAt : TDateTime;
        ISPlus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        GasCode : Byte;
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
        Last : Boolean;
        PartyID : Int64;
        Day : Integer;
        ProductTypeName : string;
        Note : TNullString;
        
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
        MinDTemp : TNullFloat64;
        MaxDTemp : TNullFloat64;
        ProductTypeName : string;
        Note : TNullString;
        MaxDFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        PointsMethod : Int64;
        MinFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxFon : TNullFloat64;
        Concentration1 : Double;
        Concentration2 : Double;
        Concentration3 : Double;
        
    end;
    
    TGoDateTime = record
    public
        Hour : Integer;
        Minute : Integer;
        Second : Integer;
        Millisecond : Integer;
        Year : Integer;
        Month : Integer;
        Day : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
        ScaleBeg : string;
        Fon : TArray<Double>;
        Place : Integer;
        Serial : string;
        ProductType : string;
        Temp : TArray<Double>;
        CreatedAt : TGoDateTime;
        Units : string;
        ISPlus20 : string;
        Sens : TArray<Double>;
        Sensitivity : string;
        ScaleEnd : string;
        ISPlus50 : string;
        Gas : string;
        ISMinus20 : string;
        
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
    
    TCell = record
    public
        Str : string;
        Res : Integer;
        TextAlignment : Integer;
        
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
        CoolOn : Boolean;
        Temperature : Double;
        Destination : Double;
        TemperatureOn : Boolean;
        
    end;
    
    TDelayInfo = record
    public
        What : string;
        TotalSeconds : Integer;
        ElapsedSeconds : Integer;
        
    end;
    

implementation

end.