
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
        I24 : TNullFloat64;
        I26 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKMinKSens50 : Boolean;
        Ok : Boolean;
        LifetimeMonths : Int64;
        ProductTypeName : TNullString;
        IFPlus20 : TNullFloat64;
        OKMinFon20 : Boolean;
        AppliedProductTypeName : string;
        Serial : TNullInt64;
        ISMinus20 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        OKMaxKSens20 : Boolean;
        OKMaxKSens50 : Boolean;
        HasFirmware : Boolean;
        Scale : Double;
        ProductID : Int64;
        CreatedAt : TDateTime;
        I13 : TNullFloat64;
        I17 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        Variation : TNullFloat64;
        OKDFon20 : Boolean;
        NobleMetalContent : Double;
        AppliedPointsMethod : Int64;
        NoteParty : TNullString;
        PartyID : Int64;
        I35 : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMinKSens20 : Boolean;
        OKDFon50 : Boolean;
        Production : Boolean;
        NoteProduct : TNullString;
        UnitsCode : Byte;
        Place : Integer;
        IFMinus20 : TNullFloat64;
        IFPlus50 : TNullFloat64;
        NotMeasured : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMinFon20r : Boolean;
        GasCode : Byte;
        GasName : string;
        PointsMethod : TNullInt64;
        DNotMeasured : TNullFloat64;
        OKDNotMeasured : Boolean;
        UnitsName : string;
        ISPlus50 : TNullFloat64;
        KSens20 : TNullFloat64;
        KSens50 : TNullFloat64;
        OKMaxFon20 : Boolean;
        
    end;
    
    TParty1 = record
    public
        Products : TArray<TProductInfo>;
        PartyID : Int64;
        CreatedAt : TDateTime;
        
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
        MaxDFon : TNullFloat64;
        PointsMethod : Int64;
        MaxKSens50 : TNullFloat64;
        MinDTemp : TNullFloat64;
        MaxDTemp : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        Concentration3 : Double;
        Note : TNullString;
        MinFon : TNullFloat64;
        MinKSens50 : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        Concentration1 : Double;
        Concentration2 : Double;
        MaxFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        
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
        Place : Integer;
        CreatedAt : TGoDateTime;
        Sensitivity : string;
        ScaleEnd : string;
        Serial : string;
        ProductType : string;
        ISPlus20 : string;
        Temp : TArray<Double>;
        Fon : TArray<Double>;
        Units : string;
        ISMinus20 : string;
        Sens : TArray<Double>;
        Gas : string;
        ScaleBeg : string;
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
        TextAlignment : Integer;
        Str : string;
        Res : Integer;
        
    end;
    
    TReadCurrent = record
    public
        Block : Integer;
        Values : TArray<Double>;
        
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
    

implementation

end.