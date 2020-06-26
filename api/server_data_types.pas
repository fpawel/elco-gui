
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
          Valid  : Boolean;
          Float64  : Double;
        
    end;
    
    TProductInfo = record
    public
          DNotMeasured  : TNullFloat64;
          D17  : TNullFloat64;
          LifetimeMonths  : Int64;
          DFon50  : TNullFloat64;
          ISMinus20  : TNullFloat64;
          I13  : TNullFloat64;
          KSens50  : TNullFloat64;
          VariationConcentration  : TNullFloat64;
          DFon20  : TNullFloat64;
          OKMinFon20  : Boolean;
          OKDNotMeasured  : Boolean;
          CreatedAt  : TDateTime;
          OKMaxD17  : Boolean;
          D26  : TNullFloat64;
          OKMaxD26  : Boolean;
          PointsMethod  : TNullInt64;
          NoteProduct  : TNullString;
          IFMinus20  : TNullFloat64;
          I35  : TNullFloat64;
          IFPlus50  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          Variation  : TNullFloat64;
          Place  : Integer;
          HasFirmware  : Boolean;
          KSensMinus20  : TNullFloat64;
          OKDFon20  : Boolean;
          OKMaxKSens20  : Boolean;
          Ok  : Boolean;
          NobleMetalContent  : Double;
          AppliedPointsMethod  : Int64;
          I17  : TNullFloat64;
          GasCode  : Byte;
          Scale  : Double;
          NoteParty  : TNullString;
          AppliedProductTypeName  : string;
          D35  : TNullFloat64;
          OKMinFon20r  : Boolean;
          OKMinKSens50  : Boolean;
          I26  : TNullFloat64;
          ISPlus20  : TNullFloat64;
          D13  : TNullFloat64;
          D24  : TNullFloat64;
          PartyID  : Int64;
          OKMaxFon20  : Boolean;
          UnitsCode  : Byte;
          ProductID  : Int64;
          OKMaxFon20r  : Boolean;
          OKMinKSens20  : Boolean;
          OKDFon50  : Boolean;
          OKMaxD13  : Boolean;
          Production  : Boolean;
          IFPlus20  : TNullFloat64;
          OKMaxKSens50  : Boolean;
          KSens20  : TNullFloat64;
          ISPlus50  : TNullFloat64;
          OKMaxD24  : Boolean;
          OKMaxD35  : Boolean;
          GasName  : string;
          ProductTypeName  : TNullString;
          Serial  : TNullInt64;
          UnitsName  : string;
          I24  : TNullFloat64;
        
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
          MaxDNotMeasured  : string;
          MaxD3  : string;
          ProductTypeName  : string;
          Concentration2  : Double;
          MinFon  : string;
          MaxDTemp  : string;
          Note  : string;
          MinDTemp  : string;
          Concentration1  : Double;
          MinKSens20  : string;
          MaxKSens20  : string;
          MaxD2  : string;
          MaxKSens50  : string;
          PointsMethod  : Int64;
          MaxD1  : string;
          Concentration3  : Double;
          MaxFon  : string;
          MaxDFon  : string;
          MinKSens50  : string;
        
    end;
    
    TTempPoints = record
    public
          Sens  : TArray<Double>;
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
        
    end;
    
    TFirmwareInfo = record
    public
          SensitivityProduct  : string;
          Units  : string;
          ScaleEnd  : string;
          Second  : Integer;
          Year  : Integer;
          TempValues  : TArray<string>;
          Day  : Integer;
          SensitivityLab73  : string;
          Serial  : string;
          ProductType  : string;
          ScaleBeg  : string;
          ProductTempPoints  : TTempPoints;
          Hour  : Integer;
          Minute  : Integer;
          Fon20  : string;
          Gas  : string;
          Month  : Integer;
        
    end;
    
    TProductType2 = record
    public
          MinKSens50  : TNullFloat64;
          MaxKSens50  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          KSens20  : TNullFloat64;
          MaxD1  : TNullFloat64;
          GasName  : string;
          UnitsName  : string;
          MaxKSens20  : TNullFloat64;
          TempPoints  : TTempPoints;
          MaxFon  : TNullFloat64;
          MaxDFon  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          Fon20  : TNullFloat64;
          MaxD3  : TNullFloat64;
          ProductTypeName  : string;
          LifetimeMonths  : Int64;
          MinFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          PointsMethod  : Int64;
          MaxD2  : TNullFloat64;
          Currents  : TArray<TArray<string>>;
          Scale  : Double;
          NobleMetalContent  : Double;
          MinDTemp  : TNullFloat64;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          EndScaleGas2  : Boolean;
          ComportGasName  : string;
          AmbientTemperature  : Double;
          BlowGasMinutes  : Integer;
          HoldTemperatureMinutes  : Integer;
          ComportName  : string;
          ComportName2  : string;
          LogComm  : Boolean;
          ChipType  : string;
        
    end;
    
    TCell = record
    public
          Res  : Integer;
          TextAlignment  : Integer;
          Str  : string;
        
    end;
    
    TProductCurrent = record
    public
          Gas  : Integer;
          CurrentValue  : Double;
          Note  : string;
          ProductCurrentID  : Int64;
          StoredAt  : TDateTime;
          ProductID  : Int64;
          Temperature  : Double;
        
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