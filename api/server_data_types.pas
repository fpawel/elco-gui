
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
          Day  : Integer;
          ProductTypeName  : string;
          Note  : TNullString;
          Last  : Boolean;
          PartyID  : Int64;
        
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
          Ok  : Boolean;
          Production  : Boolean;
          ProductID  : Int64;
          ISPlus50  : TNullFloat64;
          I13  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          OKMinKSens50  : Boolean;
          OKMaxKSens20  : Boolean;
          OKMaxD24  : Boolean;
          OKMaxD26  : Boolean;
          UnitsName  : string;
          PointsMethod  : TNullInt64;
          DFon50  : TNullFloat64;
          OKMaxD13  : Boolean;
          NobleMetalContent  : Double;
          LifetimeMonths  : Int64;
          I26  : TNullFloat64;
          OKMinFon20r  : Boolean;
          HasFirmware  : Boolean;
          I24  : TNullFloat64;
          DFon20  : TNullFloat64;
          D17  : TNullFloat64;
          OKMaxD35  : Boolean;
          Variation  : TNullFloat64;
          D13  : TNullFloat64;
          D26  : TNullFloat64;
          ISPlus20  : TNullFloat64;
          KSens20  : TNullFloat64;
          OKDFon50  : Boolean;
          ProductTypeName  : TNullString;
          NoteProduct  : TNullString;
          I17  : TNullFloat64;
          OKMaxFon20  : Boolean;
          OKMaxFon20r  : Boolean;
          OKDNotMeasured  : Boolean;
          AppliedPointsMethod  : Int64;
          PartyID  : Int64;
          D24  : TNullFloat64;
          Scale  : Double;
          Place  : Integer;
          CreatedAt  : TDateTime;
          ISMinus20  : TNullFloat64;
          VariationConcentration  : TNullFloat64;
          NoteParty  : TNullString;
          GasCode  : Byte;
          UnitsCode  : Byte;
          I35  : TNullFloat64;
          KSens50  : TNullFloat64;
          D35  : TNullFloat64;
          OKMinKSens20  : Boolean;
          OKMaxKSens50  : Boolean;
          OKDFon20  : Boolean;
          AppliedProductTypeName  : string;
          Serial  : TNullInt64;
          DNotMeasured  : TNullFloat64;
          OKMinFon20  : Boolean;
          IFMinus20  : TNullFloat64;
          OKMaxD17  : Boolean;
          IFPlus20  : TNullFloat64;
          IFPlus50  : TNullFloat64;
          KSensMinus20  : TNullFloat64;
          GasName  : string;
        
    end;
    
    TParty1 = record
    public
          Products  : TArray<TProductInfo>;
          PartyID  : Int64;
          CreatedAt  : TDateTime;
        
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
          MaxD1  : string;
          Concentration2  : Double;
          MaxKSens20  : string;
          MaxKSens50  : string;
          MinDTemp  : string;
          MaxDTemp  : string;
          MinKSens50  : string;
          PointsMethod  : Int64;
          ProductTypeName  : string;
          Concentration1  : Double;
          Concentration3  : Double;
          MinFon  : string;
          MaxFon  : string;
          MaxD3  : string;
          Note  : string;
          MaxDFon  : string;
          MinKSens20  : string;
          MaxDNotMeasured  : string;
          MaxD2  : string;
        
    end;
    
    TTempPoints = record
    public
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
          Temp  : TArray<Double>;
        
    end;
    
    TFirmwareInfo = record
    public
          ScaleBeg  : string;
          Year  : Integer;
          Units  : string;
          ProductType  : string;
          Gas  : string;
          Month  : Integer;
          SensitivityProduct  : string;
          Minute  : Integer;
          ScaleEnd  : string;
          TempValues  : TArray<string>;
          Day  : Integer;
          Second  : Integer;
          SensitivityLab73  : string;
          Fon20  : string;
          Serial  : string;
          ProductTempPoints  : TTempPoints;
          Hour  : Integer;
        
    end;
    
    TProductType2 = record
    public
          ProductTypeName  : string;
          GasName  : string;
          Scale  : Double;
          MinKSens50  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          KSens20  : TNullFloat64;
          Fon20  : TNullFloat64;
          TempPoints  : TTempPoints;
          MaxFon  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          MaxD1  : TNullFloat64;
          NobleMetalContent  : Double;
          MinDTemp  : TNullFloat64;
          MaxD3  : TNullFloat64;
          PointsMethod  : Int64;
          UnitsName  : string;
          LifetimeMonths  : Int64;
          MinFon  : TNullFloat64;
          MaxDFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          MaxKSens20  : TNullFloat64;
          MaxKSens50  : TNullFloat64;
          MaxD2  : TNullFloat64;
          Currents  : TArray<TArray<string>>;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          ChipType  : string;
          BlowGasMinutes  : Integer;
          EndScaleGas2  : Boolean;
          ComportName  : string;
          ComportName2  : string;
          LogComm  : Boolean;
          ComportGasName  : string;
          AmbientTemperature  : Double;
          HoldTemperatureMinutes  : Integer;
        
    end;
    
    TCell = record
    public
          Res  : Integer;
          TextAlignment  : Integer;
          Str  : string;
        
    end;
    
    TProductCurrent = record
    public
          StoredAt  : TDateTime;
          ProductID  : Int64;
          Temperature  : Double;
          Gas  : Integer;
          CurrentValue  : Double;
          Note  : string;
          ProductCurrentID  : Int64;
        
    end;
    
    TReadCurrent = record
    public
          Values  : TArray<Double>;
          Block  : Integer;
        
    end;
    
    TWorkResult = record
    public
          Tag  : Integer;
          Message  : string;
          WorkName  : string;
        
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
          Line  : string;
          Lineno  : Integer;
        
    end;
    

implementation

end.