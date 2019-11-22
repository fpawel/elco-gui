
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
          PartyID  : Int64;
          Day  : Integer;
          ProductTypeName  : string;
          Note  : TNullString;
          Last  : Boolean;
        
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
          OKMinKSens20  : Boolean;
          AppliedPointsMethod  : Int64;
          KSensMinus20  : TNullFloat64;
          DNotMeasured  : TNullFloat64;
          OKDFon50  : Boolean;
          AppliedProductTypeName  : string;
          UnitsCode  : Byte;
          Scale  : Double;
          ISMinus20  : TNullFloat64;
          VariationConcentration  : TNullFloat64;
          OKMaxD26  : Boolean;
          Production  : Boolean;
          OKMinFon20  : Boolean;
          OKMaxD35  : Boolean;
          OKMaxD17  : Boolean;
          I17  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          OKMaxFon20  : Boolean;
          OKDFon20  : Boolean;
          OKMaxKSens20  : Boolean;
          OKMinKSens50  : Boolean;
          NobleMetalContent  : Double;
          PointsMethod  : TNullInt64;
          ProductID  : Int64;
          Variation  : TNullFloat64;
          D26  : TNullFloat64;
          LifetimeMonths  : Int64;
          Place  : Integer;
          KSens20  : TNullFloat64;
          GasName  : string;
          IFMinus20  : TNullFloat64;
          OKMinFon20r  : Boolean;
          OKMaxD24  : Boolean;
          OKMaxKSens50  : Boolean;
          UnitsName  : string;
          Serial  : TNullInt64;
          KSens50  : TNullFloat64;
          DFon20  : TNullFloat64;
          I13  : TNullFloat64;
          I26  : TNullFloat64;
          OKMaxFon20r  : Boolean;
          IFPlus50  : TNullFloat64;
          D13  : TNullFloat64;
          D35  : TNullFloat64;
          D17  : TNullFloat64;
          IFPlus20  : TNullFloat64;
          D24  : TNullFloat64;
          DFon50  : TNullFloat64;
          ProductTypeName  : TNullString;
          NoteParty  : TNullString;
          ISPlus20  : TNullFloat64;
          ISPlus50  : TNullFloat64;
          I35  : TNullFloat64;
          OKMaxD13  : Boolean;
          Ok  : Boolean;
          NoteProduct  : TNullString;
          PartyID  : Int64;
          I24  : TNullFloat64;
          HasFirmware  : Boolean;
          GasCode  : Byte;
          CreatedAt  : TDateTime;
          OKDNotMeasured  : Boolean;
        
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
          Concentration1  : Double;
          MinKSens20  : string;
          Concentration2  : Double;
          Concentration3  : Double;
          MaxDFon  : string;
          MaxKSens20  : string;
          MinDTemp  : string;
          MaxDTemp  : string;
          MaxKSens50  : string;
          PointsMethod  : Int64;
          MaxD1  : string;
          MaxD3  : string;
          Note  : string;
          MinFon  : string;
          MaxFon  : string;
          MinKSens50  : string;
          MaxDNotMeasured  : string;
          MaxD2  : string;
        
    end;
    
    TTempPoints = record
    public
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
        
    end;
    
    TGoDateTime = record
    public
          Year  : Integer;
          Month  : Integer;
          Day  : Integer;
          Hour  : Integer;
          Minute  : Integer;
          Second  : Integer;
          Millisecond  : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
          SensitivityLab73  : string;
          SensitivityProduct  : string;
          Fon20  : string;
          Serial  : string;
          Gas  : string;
          Units  : string;
          ProductTempPoints  : TTempPoints;
          CreatedAt  : TGoDateTime;
          ScaleBeg  : string;
          ScaleEnd  : string;
          Place  : Integer;
          ProductType  : string;
        
    end;
    
    TProductType2 = record
    public
          MinKSens20  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          MaxD1  : TNullFloat64;
          GasName  : string;
          LifetimeMonths  : Int64;
          MaxDFon  : TNullFloat64;
          MinDTemp  : TNullFloat64;
          KSens20  : TNullFloat64;
          Fon20  : TNullFloat64;
          ChipType  : string;
          MaxD3  : TNullFloat64;
          Scale  : Double;
          MinFon  : TNullFloat64;
          MaxFon  : TNullFloat64;
          TempPoints  : TTempPoints;
          MaxDNotMeasured  : TNullFloat64;
          Currents  : TArray<TArray<string>>;
          UnitsName  : string;
          MaxKSens20  : TNullFloat64;
          MaxKSens50  : TNullFloat64;
          MaxD2  : TNullFloat64;
          PointsMethod  : Int64;
          ProductTypeName  : string;
          NobleMetalContent  : Double;
          MinKSens50  : TNullFloat64;
        
    end;
    
    TFirmwareInfo2 = record
    public
          SensitivityProduct  : string;
          Gas  : string;
          Place  : Integer;
          Year  : Integer;
          Minute  : Integer;
          Month  : Integer;
          Second  : Integer;
          SensitivityLab73  : string;
          Fon20  : string;
          Units  : string;
          ProductType  : string;
          ScaleBegin  : string;
          ScaleEnd  : string;
          Values  : TArray<string>;
          Day  : Integer;
          Hour  : Integer;
          Serial  : string;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          AmbientTemperature  : Double;
          BlowGasMinutes  : Integer;
          HoldTemperatureMinutes  : Integer;
          ComportName  : string;
          ComportName2  : string;
          ChipType  : string;
          ComportGasName  : string;
          LogComm  : Boolean;
          EndScaleGas2  : Boolean;
        
    end;
    
    TCell = record
    public
          Str  : string;
          Res  : Integer;
          TextAlignment  : Integer;
        
    end;
    
    TProductCurrent = record
    public
          ProductCurrentID  : Int64;
          StoredAt  : TDateTime;
          ProductID  : Int64;
          Temperature  : Double;
          Gas  : Integer;
          CurrentValue  : Double;
          Note  : string;
        
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