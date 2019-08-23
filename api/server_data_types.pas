
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
    TNullInt64 = record
    public
        Valid : Boolean;
        Int64 : Int64;
        
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
        I17 : TNullFloat64;
        DFon50 : TNullFloat64;
        OKMinFon20r : Boolean;
        OKDFon20 : Boolean;
        OKMinKSens20 : Boolean;
        AppliedPointsMethod : Int64;
        I35 : TNullFloat64;
        NotMeasured : TNullFloat64;
        DNotMeasured : TNullFloat64;
        OKDFon50 : Boolean;
        GasCode : Byte;
        Scale : Double;
        NoteParty : TNullString;
        ISPlus20 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        KSens20 : TNullFloat64;
        Ok : Boolean;
        UnitsCode : Byte;
        NobleMetalContent : Double;
        I24 : TNullFloat64;
        Place : Integer;
        I13 : TNullFloat64;
        I26 : TNullFloat64;
        KSens50 : TNullFloat64;
        OKMaxKSens20 : Boolean;
        OKDNotMeasured : Boolean;
        Serial : TNullInt64;
        PartyID : Int64;
        IFPlus50 : TNullFloat64;
        ISMinus20 : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMaxKSens50 : Boolean;
        ProductID : Int64;
        OKMaxFon20r : Boolean;
        GasName : string;
        DFon20 : TNullFloat64;
        IFMinus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKMinKSens50 : Boolean;
        LifetimeMonths : Int64;
        ProductTypeName : TNullString;
        NoteProduct : TNullString;
        CreatedAt : TDateTime;
        Variation : TNullFloat64;
        HasFirmware : Boolean;
        Production : Boolean;
        AppliedProductTypeName : string;
        UnitsName : string;
        PointsMethod : TNullInt64;
        IFPlus20 : TNullFloat64;
        
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
        MaxDNotMeasured : TNullFloat64;
        ProductTypeName : string;
        Concentration2 : Double;
        MinKSens20 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        PointsMethod : Int64;
        Concentration1 : Double;
        Concentration3 : Double;
        Note : TNullString;
        MaxFon : TNullFloat64;
        MaxDFon : TNullFloat64;
        MinDTemp : TNullFloat64;
        MinFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MinKSens50 : TNullFloat64;
        
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
        ISPlus20 : string;
        ScaleEnd : string;
        ProductType : string;
        Units : string;
        ScaleBeg : string;
        ISPlus50 : string;
        Temp : TArray<Double>;
        Serial : string;
        ISMinus20 : string;
        Sensitivity : string;
        Gas : string;
        Fon : TArray<Double>;
        Place : Integer;
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