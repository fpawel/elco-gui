
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
        OKMaxKSens50 : Boolean;
        NobleMetalContent : Double;
        ProductTypeName : TNullString;
        Place : Integer;
        I17 : TNullFloat64;
        OKMinFon20 : Boolean;
        OKMinFon20r : Boolean;
        OKMaxFon20r : Boolean;
        OKMaxKSens20 : Boolean;
        KSens20 : TNullFloat64;
        KSens50 : TNullFloat64;
        I35 : TNullFloat64;
        OKMinKSens50 : Boolean;
        Scale : Double;
        Note : TNullString;
        CreatedAt : TDateTime;
        I13 : TNullFloat64;
        DFon20 : TNullFloat64;
        OKDFon50 : Boolean;
        GasCode : Byte;
        PointsMethod : TNullInt64;
        NotMeasured : TNullFloat64;
        Variation : TNullFloat64;
        DFon50 : TNullFloat64;
        OKDNotMeasured : Boolean;
        AppliedProductTypeName : string;
        UnitsName : string;
        IFPlus50 : TNullFloat64;
        KSensMinus20 : TNullFloat64;
        HasFirmware : Boolean;
        LifetimeMonths : Int64;
        ISMinus20 : TNullFloat64;
        ISPlus20 : TNullFloat64;
        IFMinus20 : TNullFloat64;
        IFPlus20 : TNullFloat64;
        ISPlus50 : TNullFloat64;
        I26 : TNullFloat64;
        OKMaxFon20 : Boolean;
        OKDFon20 : Boolean;
        ProductID : Int64;
        Serial : TNullInt64;
        Ok : Boolean;
        Production : Boolean;
        DNotMeasured : TNullFloat64;
        OKMinKSens20 : Boolean;
        UnitsCode : Byte;
        GasName : string;
        AppliedPointsMethod : Int64;
        PartyID : Int64;
        I24 : TNullFloat64;
        
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
        Concentration1 : Double;
        Concentration2 : Double;
        Concentration3 : Double;
        Note : TNullString;
        MinDTemp : TNullFloat64;
        MaxDFon : TNullFloat64;
        MaxKSens20 : TNullFloat64;
        MaxKSens50 : TNullFloat64;
        MinFon : TNullFloat64;
        MaxFon : TNullFloat64;
        MinKSens20 : TNullFloat64;
        MaxDTemp : TNullFloat64;
        MaxDNotMeasured : TNullFloat64;
        PointsMethod : Int64;
        MinKSens50 : TNullFloat64;
        
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
        Sens : TArray<Double>;
        CreatedAt : TGoDateTime;
        ISPlus50 : string;
        Gas : string;
        ScaleBeg : string;
        ScaleEnd : string;
        ISPlus20 : string;
        Temp : TArray<Double>;
        Place : Integer;
        Serial : string;
        ISMinus20 : string;
        Fon : TArray<Double>;
        Sensitivity : string;
        ProductType : string;
        Units : string;
        
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
        Res : Integer;
        Str : string;
        
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