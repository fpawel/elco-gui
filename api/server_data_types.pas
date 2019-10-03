
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
        HasFirmware : Boolean;
        NobleMetalContent : Double;
        LifetimeMonths : Int64;
        PartyID : Int64;
        IFPlus20 : TNullFloat64;
        I13 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKMinKSens20 : Boolean;
        Ok : Boolean;
        Production : Boolean;
        ProductTypeName : TNullString;
        IFPlus50 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        OKMinFon20 : Boolean;
        DFon50 : TNullFloat64;
        OKMinFon20r : Boolean;
        PointsMethod : TNullInt64;
        ISPlus20 : TNullFloat64;
        I24 : TNullFloat64;
        I26 : TNullFloat64;
        OKMinKSens50 : Boolean;
        OKDFon50 : Boolean;
        AppliedPointsMethod : Int64;
        I17 : TNullFloat64;
        KSens20 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        UnitsCode : Byte;
        NoteProduct : TNullString;
        Serial : TNullInt64;
        ISMinus20 : TNullFloat64;
        AppliedProductTypeName : string;
        KSensMinus20 : TNullFloat64;
        KSens50 : TNullFloat64;
        Variation : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMaxKSens20 : Boolean;
        ProductID : Int64;
        Place : Integer;
        NotMeasured : TNullFloat64;
        NoteParty : TNullString;
        OKMaxKSens50 : Boolean;
        GasName : string;
        UnitsName : string;
        CreatedAt : TDateTime;
        IFMinus20 : TNullFloat64;
        GasCode : Byte;
        OKDNotMeasured : Boolean;
        Scale : Double;
        I35 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKDFon20 : Boolean;
        
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
        MinDTemp : TNullFloat64;
        PointsMethod : Int64;
        ProductTypeName : string;
        Note : TNullString;
        MinKSens50 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        Concentration2 : Double;
        Concentration3 : Double;
        MaxFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        Concentration1 : Double;
        MinFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        
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
        ISMinus20 : string;
        Temp : TArray<Double>;
        Place : Integer;
        Sensitivity : string;
        Gas : string;
        Units : string;
        ScaleEnd : string;
        ISPlus50 : string;
        Fon : TArray<Double>;
        Sens : TArray<Double>;
        CreatedAt : TGoDateTime;
        ISPlus20 : string;
        Serial : string;
        ProductType : string;
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
        AmbientTemperature : Double;
        BlowGasMinutes : Integer;
        HoldTemperatureMinutes : Integer;
        EndScaleGas2 : Boolean;
        ComportMeasurer : string;
        ComportGas : string;
        ChipType : string;
        
    end;
    
    TCell = record
    public
        Str : string;
        Res : Integer;
        TextAlignment : Integer;
        
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
    

implementation

end.