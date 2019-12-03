
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
          ProductTypeName  : string;
          Note  : TNullString;
          Last  : Boolean;
          PartyID  : Int64;
          Day  : Integer;
        
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
          HasFirmware  : Boolean;
          KSens20  : TNullFloat64;
          OKMaxD17  : Boolean;
          Place  : Integer;
          Production  : Boolean;
          OKDFon50  : Boolean;
          NoteProduct  : TNullString;
          KSens50  : TNullFloat64;
          OKMaxKSens50  : Boolean;
          OKMinFon20  : Boolean;
          OKMaxKSens20  : Boolean;
          PointsMethod  : TNullInt64;
          DFon20  : TNullFloat64;
          D24  : TNullFloat64;
          ISMinus20  : TNullFloat64;
          ISPlus50  : TNullFloat64;
          I35  : TNullFloat64;
          I17  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          OKMinKSens20  : Boolean;
          IFMinus20  : TNullFloat64;
          IFPlus20  : TNullFloat64;
          Scale  : Double;
          OKMaxD13  : Boolean;
          Ok  : Boolean;
          UnitsName  : string;
          DNotMeasured  : TNullFloat64;
          D13  : TNullFloat64;
          AppliedProductTypeName  : string;
          NobleMetalContent  : Double;
          I24  : TNullFloat64;
          OKDFon20  : Boolean;
          UnitsCode  : Byte;
          CreatedAt  : TDateTime;
          VariationConcentration  : TNullFloat64;
          GasName  : string;
          OKMinKSens50  : Boolean;
          OKMaxD24  : Boolean;
          D26  : TNullFloat64;
          D17  : TNullFloat64;
          GasCode  : Byte;
          Serial  : TNullInt64;
          ISPlus20  : TNullFloat64;
          PartyID  : Int64;
          I13  : TNullFloat64;
          OKMaxD35  : Boolean;
          AppliedPointsMethod  : Int64;
          NoteParty  : TNullString;
          D35  : TNullFloat64;
          OKDNotMeasured  : Boolean;
          DFon50  : TNullFloat64;
          OKMinFon20r  : Boolean;
          OKMaxD26  : Boolean;
          I26  : TNullFloat64;
          KSensMinus20  : TNullFloat64;
          OKMaxFon20  : Boolean;
          LifetimeMonths  : Int64;
          ProductID  : Int64;
          IFPlus50  : TNullFloat64;
          ProductTypeName  : TNullString;
          Variation  : TNullFloat64;
          OKMaxFon20r  : Boolean;
        
    end;
    
    TParty1 = record
    public
          CreatedAt  : TDateTime;
          Products  : TArray<TProductInfo>;
          PartyID  : Int64;
        
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
          MaxD2  : string;
          MinKSens50  : string;
          MinDTemp  : string;
          MaxDTemp  : string;
          PointsMethod  : Int64;
          MaxD1  : string;
          ProductTypeName  : string;
          MinKSens20  : string;
          MaxKSens20  : string;
          MaxD3  : string;
          MinFon  : string;
          MaxDFon  : string;
          MaxKSens50  : string;
          Note  : string;
          MaxFon  : string;
          MaxDNotMeasured  : string;
          Concentration1  : Double;
          Concentration2  : Double;
          Concentration3  : Double;
        
    end;
    
    TTempPoints = record
    public
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
          Temp  : TArray<Double>;
        
    end;
    
    TFirmwareInfo = record
    public
          Year  : Integer;
          Minute  : Integer;
          Second  : Integer;
          ProductType  : string;
          ProductTempPoints  : TTempPoints;
          TempValues  : TArray<string>;
          Month  : Integer;
          Day  : Integer;
          Hour  : Integer;
          SensitivityLab73  : string;
          Fon20  : string;
          Units  : string;
          ScaleBeg  : string;
          ScaleEnd  : string;
          SensitivityProduct  : string;
          Serial  : string;
          Gas  : string;
        
    end;
    
    TProductType2 = record
    public
          ProductTypeName  : string;
          NobleMetalContent  : Double;
          KSens20  : TNullFloat64;
          PointsMethod  : Int64;
          Scale  : Double;
          MaxDFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          TempPoints  : TTempPoints;
          MaxD3  : TNullFloat64;
          LifetimeMonths  : Int64;
          MinKSens50  : TNullFloat64;
          Fon20  : TNullFloat64;
          MaxD1  : TNullFloat64;
          MaxD2  : TNullFloat64;
          MaxKSens50  : TNullFloat64;
          MinDTemp  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          GasName  : string;
          UnitsName  : string;
          MinFon  : TNullFloat64;
          MaxFon  : TNullFloat64;
          MaxKSens20  : TNullFloat64;
          Currents  : TArray<TArray<string>>;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          LogComm  : Boolean;
          ChipType  : string;
          EndScaleGas2  : Boolean;
          BlowGasMinutes  : Integer;
          HoldTemperatureMinutes  : Integer;
          ComportName  : string;
          ComportGasName  : string;
          ComportName2  : string;
          AmbientTemperature  : Double;
        
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
          ElapsedSeconds  : Integer;
          What  : string;
          TotalSeconds  : Integer;
        
    end;
    
    TScriptLine = record
    public
          Lineno  : Integer;
          Line  : string;
        
    end;
    

implementation

end.