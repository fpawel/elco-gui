
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
        Place : Integer;
        I24 : TNullFloat64;
        I17 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKMinFon20r : Boolean;
        OKDFon20 : Boolean;
        OKMaxKSens50 : Boolean;
        OKDNotMeasured : Boolean;
        PartyID : Int64;
        Serial : TNullInt64;
        I13 : TNullFloat64;
        NotMeasured : TNullFloat64;
        OKMaxFon20r : Boolean;
        OKMinKSens50 : Boolean;
        AppliedPointsMethod : Int64;
        HasFirmware : Boolean;
        GasCode : Byte;
        IFPlus20 : TNullFloat64;
        IFPlus50 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKMinKSens20 : Boolean;
        OKDFon50 : Boolean;
        AppliedProductTypeName : string;
        IFMinus20 : TNullFloat64;
        ISMinus20 : TNullFloat64;
        KSens20 : TNullFloat64;
        KSens50 : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMaxKSens20 : Boolean;
        LifetimeMonths : Int64;
        PointsMethod : TNullInt64;
        NoteParty : TNullString;
        ProductTypeName : TNullString;
        ProductID : Int64;
        ISPlus20 : TNullFloat64;
        I35 : TNullFloat64;
        I26 : TNullFloat64;
        Scale : Double;
        NoteProduct : TNullString;
        CreatedAt : TDateTime;
        UnitsCode : Byte;
        UnitsName : string;
        NobleMetalContent : Double;
        Variation : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMaxFon20 : Boolean;
        Ok : Boolean;
        Production : Boolean;
        GasName : string;
        
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
        MaxKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        Concentration1 : Double;
        Concentration2 : Double;
        Concentration3 : Double;
        Note : TNullString;
        MaxFon : TNullFloat64;
        MaxDTemp : TNullFloat64;
        ProductTypeName : string;
        MaxDFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        MinFon : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MinDTemp : TNullFloat64;
        PointsMethod : Int64;
        
    end;
    
    TGoDateTime = record
    public
        Month : Integer;
        Day : Integer;
        Hour : Integer;
        Minute : Integer;
        Second : Integer;
        Millisecond : Integer;
        Year : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
        Units : string;
        ScaleEnd : string;
        Fon : TArray<Double>;
        Serial : string;
        Gas : string;
        ISMinus20 : string;
        ISPlus20 : string;
        ISPlus50 : string;
        ProductType : string;
        ScaleBeg : string;
        Temp : TArray<Double>;
        Place : Integer;
        Sensitivity : string;
        Sens : TArray<Double>;
        CreatedAt : TGoDateTime;
        
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
        TextAlignment : Integer;
        Str : string;
        Res : Integer;
        
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
        ElapsedSeconds : Integer;
        What : string;
        TotalSeconds : Integer;
        
    end;
    

implementation

end.