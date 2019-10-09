
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
        OKDNotMeasured : Boolean;
        ISPlus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        I13 : TNullFloat64;
        I24 : TNullFloat64;
        I35 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        OKMaxKSens20 : Boolean;
        NobleMetalContent : Double;
        LifetimeMonths : Int64;
        IFPlus20 : TNullFloat64;
        ISMinus20 : TNullFloat64;
        I17 : TNullFloat64;
        NotMeasured : TNullFloat64;
        OKMaxKSens50 : Boolean;
        IFPlus50 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKDFon20 : Boolean;
        AppliedProductTypeName : string;
        GasName : string;
        Serial : TNullInt64;
        CreatedAt : TDateTime;
        OKMinFon20 : Boolean;
        OKMinKSens50 : Boolean;
        Production : Boolean;
        PointsMethod : TNullInt64;
        PartyID : Int64;
        KSens50 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKDFon50 : Boolean;
        I26 : TNullFloat64;
        Ok : Boolean;
        NoteProduct : TNullString;
        UnitsCode : Byte;
        ProductID : Int64;
        Place : Integer;
        KSens20 : TNullFloat64;
        Variation : TNullFloat64;
        DFon20 : TNullFloat64;
        HasFirmware : Boolean;
        GasCode : Byte;
        UnitsName : string;
        Scale : Double;
        ProductTypeName : TNullString;
        NoteParty : TNullString;
        IFMinus20 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMinFon20r : Boolean;
        OKMaxFon20r : Boolean;
        OKMinKSens20 : Boolean;
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
        MaxKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        PointsMethod : Int64;
        Concentration1 : Double;
        Concentration2 : Double;
        Note : TNullString;
        MinFon : TNullFloat64;
        MaxDTemp : TNullFloat64;
        ProductTypeName : string;
        Concentration3 : Double;
        MaxDNotMeasured : TNullFloat64;
        MaxFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MinDTemp : TNullFloat64;
        
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
        Sens : TArray<Double>;
        Sensitivity : string;
        ScaleEnd : string;
        ProductType : string;
        ISPlus20 : string;
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Serial : string;
        ISPlus50 : string;
        CreatedAt : TGoDateTime;
        Gas : string;
        ISMinus20 : string;
        Place : Integer;
        Units : string;
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
        Message : string;
        WorkName : string;
        Tag : Integer;
        
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
    

implementation

end.