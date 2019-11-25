
unit server_data_types;

interface

uses Grijjy.Bson, Grijjy.Bson.Serialization;

type
    
    TNullString = record
    public
          [BsonElement('String')]Str  : string;
          Valid  : Boolean;
        
    end;
    
    TParty2 = record
    public
          Last  : Boolean;
          PartyID  : Int64;
          Day  : Integer;
          ProductTypeName  : string;
          Note  : TNullString;
        
    end;
    
    TNullInt64 = record
    public
          Int64  : Int64;
          Valid  : Boolean;
        
    end;
    
    TNullFloat64 = record
    public
          Float64  : Double;
          Valid  : Boolean;
        
    end;
    
    TProductInfo = record
    public
          DFon50  : TNullFloat64;
          OKMaxFon20r  : Boolean;
          OKMaxD24  : Boolean;
          Ok  : Boolean;
          UnitsName  : string;
          ProductTypeName  : TNullString;
          I26  : TNullFloat64;
          DFon20  : TNullFloat64;
          AppliedPointsMethod  : Int64;
          IFMinus20  : TNullFloat64;
          KSensMinus20  : TNullFloat64;
          GasName  : string;
          I24  : TNullFloat64;
          I35  : TNullFloat64;
          I13  : TNullFloat64;
          OKMaxD17  : Boolean;
          NoteProduct  : TNullString;
          Variation  : TNullFloat64;
          ISPlus20  : TNullFloat64;
          ISPlus50  : TNullFloat64;
          I17  : TNullFloat64;
          OKMaxKSens50  : Boolean;
          IFPlus20  : TNullFloat64;
          OKMinKSens20  : Boolean;
          OKMaxKSens20  : Boolean;
          OKMaxD26  : Boolean;
          VariationConcentration  : TNullFloat64;
          OKMinKSens50  : Boolean;
          OKDFon50  : Boolean;
          D17  : TNullFloat64;
          ISMinus20  : TNullFloat64;
          KSens50  : TNullFloat64;
          OKMaxD13  : Boolean;
          AppliedProductTypeName  : string;
          NobleMetalContent  : Double;
          PointsMethod  : TNullInt64;
          IFPlus50  : TNullFloat64;
          OKMinFon20  : Boolean;
          UnitsCode  : Byte;
          Place  : Integer;
          OKMinFon20r  : Boolean;
          HasFirmware  : Boolean;
          Production  : Boolean;
          Scale  : Double;
          LifetimeMonths  : Int64;
          OKMaxFon20  : Boolean;
          Serial  : TNullInt64;
          D26  : TNullFloat64;
          OKDNotMeasured  : Boolean;
          GasCode  : Byte;
          NoteParty  : TNullString;
          PartyID  : Int64;
          D24  : TNullFloat64;
          D35  : TNullFloat64;
          CreatedAt  : TDateTime;
          NotMeasured  : TNullFloat64;
          DNotMeasured  : TNullFloat64;
          OKDFon20  : Boolean;
          OKMaxD35  : Boolean;
          KSens20  : TNullFloat64;
          D13  : TNullFloat64;
          ProductID  : Int64;
        
    end;
    
    TParty1 = record
    public
          PartyID  : Int64;
          CreatedAt  : TDateTime;
          Products  : TArray<TProductInfo>;
        
    end;
    
    TYearMonth = record
    public
          Year  : Integer;
          Month  : Integer;
        
    end;
    
    TGetCheckBlocksArg = record
    public
          Check  : TArray<Boolean>;
        
    end;
    
    TParty3 = record
    public
          ProductTypeName  : string;
          Concentration3  : Double;
          Note  : string;
          MinFon  : string;
          MaxDTemp  : string;
          MaxD2  : string;
          MaxD3  : string;
          Concentration2  : Double;
          MinKSens50  : string;
          MinDTemp  : string;
          MaxDNotMeasured  : string;
          PointsMethod  : Int64;
          MaxKSens50  : string;
          MaxD1  : string;
          Concentration1  : Double;
          MaxFon  : string;
          MaxDFon  : string;
          MinKSens20  : string;
          MaxKSens20  : string;
        
    end;
    
    TTempPoints = record
    public
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
        
    end;
    
    TGoDateTime = record
    public
          Hour  : Integer;
          Minute  : Integer;
          Second  : Integer;
          Millisecond  : Integer;
          Year  : Integer;
          Month  : Integer;
          Day  : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
          Place  : Integer;
          CreatedAt  : TGoDateTime;
          Serial  : string;
          Gas  : string;
          Units  : string;
          ScaleBeg  : string;
          ProductTempPoints  : TTempPoints;
          SensitivityLab73  : string;
          SensitivityProduct  : string;
          Fon20  : string;
          ProductType  : string;
          ScaleEnd  : string;
        
    end;
    
    TProductType2 = record
    public
          TempPoints  : TTempPoints;
          Scale  : Double;
          MaxKSens50  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          Fon20  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          MinDTemp  : TNullFloat64;
          ProductTypeName  : string;
          GasName  : string;
          UnitsName  : string;
          NobleMetalContent  : Double;
          LifetimeMonths  : Int64;
          Currents  : TArray<TArray<string>>;
          MinFon  : TNullFloat64;
          MaxFon  : TNullFloat64;
          KSens20  : TNullFloat64;
          MaxD1  : TNullFloat64;
          MaxD3  : TNullFloat64;
          PointsMethod  : Int64;
          MaxDFon  : TNullFloat64;
          MaxKSens20  : TNullFloat64;
          MinKSens50  : TNullFloat64;
          ChipType  : string;
          MaxD2  : TNullFloat64;
        
    end;
    
    TFirmwareInfo2 = record
    public
          Gas  : string;
          Place  : Integer;
          Day  : Integer;
          Second  : Integer;
          Units  : string;
          ScaleEnd  : string;
          Values  : TArray<string>;
          Hour  : Integer;
          SensitivityLab73  : string;
          Fon20  : string;
          Serial  : string;
          ProductType  : string;
          Year  : Integer;
          Minute  : Integer;
          SensitivityProduct  : string;
          Month  : Integer;
          ScaleBegin  : string;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          LogComm  : Boolean;
          BlowGasMinutes  : Integer;
          ComportName2  : string;
          ComportGasName  : string;
          ChipType  : string;
          AmbientTemperature  : Double;
          HoldTemperatureMinutes  : Integer;
          EndScaleGas2  : Boolean;
          ComportName  : string;
        
    end;
    
    TCell = record
    public
          Str  : string;
          Res  : Integer;
          TextAlignment  : Integer;
        
    end;
    
    TProductCurrent = record
    public
          CurrentValue  : Double;
          Note  : string;
          ProductCurrentID  : Int64;
          StoredAt  : TDateTime;
          ProductID  : Int64;
          Temperature  : Double;
          Gas  : Integer;
        
    end;
    
    TReadCurrent = record
    public
          Values  : TArray<Double>;
          Block  : Integer;
        
    end;
    
    TWorkResult = record
    public
          WorkName  : string;
          Tag  : Integer;
          Message  : string;
        
    end;
    
    TKtx500Info = record
    public
          Temperature  : Double;
          Destination  : Double;
          TemperatureOn  : Boolean;
          CoolOn  : Boolean;
        
    end;
    
    TDelayInfo = record
    public
          TotalSeconds  : Integer;
          ElapsedSeconds  : Integer;
          What  : string;
        
    end;
    
    TScriptLine = record
    public
          Lineno  : Integer;
          Line  : string;
        
    end;
    

implementation

end.