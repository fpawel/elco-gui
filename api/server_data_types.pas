
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
        Valid : Boolean;
        Float64 : Double;
        
    end;
    
    TNullString = record
    public
        [BsonElement('String')]Str  : string;
        Valid : Boolean;
        
    end;
    
    TProductInfo = record
    public
        I35 : TNullFloat64;
        NoteParty : TNullString;
        Production : Boolean;
        ProductID : Int64;
        ISMinus20 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMinKSens20 : Boolean;
        Scale : Double;
        NobleMetalContent : Double;
        AppliedPointsMethod : Int64;
        NoteProduct : TNullString;
        IFPlus20 : TNullFloat64;
        I24 : TNullFloat64;
        KSens50 : TNullFloat64;
        Variation : TNullFloat64;
        OKMaxKSens50 : Boolean;
        GasCode : Byte;
        UnitsName : string;
        ISPlus50 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        GasName : string;
        OKDFon50 : Boolean;
        Ok : Boolean;
        AppliedProductTypeName : string;
        UnitsCode : Byte;
        LifetimeMonths : Int64;
        Place : Integer;
        I13 : TNullFloat64;
        I17 : TNullFloat64;
        HasFirmware : Boolean;
        OKMinKSens50 : Boolean;
        Serial : TNullInt64;
        CreatedAt : TDateTime;
        IFMinus20 : TNullFloat64;
        IFPlus50 : TNullFloat64;
        KSens20 : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMaxFon20 : Boolean;
        OKDNotMeasured : Boolean;
        PointsMethod : TNullInt64;
        ProductTypeName : TNullString;
        PartyID : Int64;
        I26 : TNullFloat64;
        NotMeasured : TNullFloat64;
        DFon20 : TNullFloat64;
        OKMinFon20r : Boolean;
        OKDFon20 : Boolean;
        OKMaxKSens20 : Boolean;
        
    end;
    
    TParty1 = record
    public
        PartyID : Int64;
        CreatedAt : TDateTime;
        Products : TArray<TProductInfo>;
        
    end;
    
    TParty2 = record
    public
        Day : Integer;
        ProductTypeName : string;
        Note : TNullString;
        Last : Boolean;
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
        Concentration1 : Double;
        Concentration2 : Double;
        MaxFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        PointsMethod : Int64;
        Concentration3 : Double;
        Note : TNullString;
        MinFon : TNullFloat64;
        MinDTemp : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        ProductTypeName : string;
        MaxDFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        
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
        Units : string;
        Sens : TArray<Double>;
        CreatedAt : TGoDateTime;
        ProductType : string;
        Sensitivity : string;
        Serial : string;
        ScaleBeg : string;
        Fon : TArray<Double>;
        Place : Integer;
        ISPlus50 : string;
        ISMinus20 : string;
        ISPlus20 : string;
        Temp : TArray<Double>;
        Gas : string;
        ScaleEnd : string;
        
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
        Destination : Double;
        TemperatureOn : Boolean;
        CoolOn : Boolean;
        Temperature : Double;
        
    end;
    
    TDelayInfo = record
    public
        TotalSeconds : Integer;
        ElapsedSeconds : Integer;
        What : string;
        
    end;
    

implementation

end.