
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
          I26  : TNullFloat64;
          DFon50  : TNullFloat64;
          OKMinKSens20  : Boolean;
          IFPlus20  : TNullFloat64;
          OKDFon20  : Boolean;
          OKDNotMeasured  : Boolean;
          GasCode  : Byte;
          AppliedPointsMethod  : Int64;
          ProductID  : Int64;
          Serial  : TNullInt64;
          CreatedAt  : TDateTime;
          NoteProduct  : TNullString;
          NoteParty  : TNullString;
          Variation  : TNullFloat64;
          OKMaxD13  : Boolean;
          OKMaxD35  : Boolean;
          D35  : TNullFloat64;
          D17  : TNullFloat64;
          AppliedProductTypeName  : string;
          ISPlus20  : TNullFloat64;
          I24  : TNullFloat64;
          VariationConcentration  : TNullFloat64;
          OKMaxD26  : Boolean;
          NobleMetalContent  : Double;
          PartyID  : Int64;
          D24  : TNullFloat64;
          OKMinFon20  : Boolean;
          OKMinFon20r  : Boolean;
          OKMaxKSens50  : Boolean;
          LifetimeMonths  : Int64;
          IFPlus50  : TNullFloat64;
          I35  : TNullFloat64;
          KSens20  : TNullFloat64;
          Production  : Boolean;
          UnitsCode  : Byte;
          ISMinus20  : TNullFloat64;
          D13  : TNullFloat64;
          OKMaxFon20  : Boolean;
          Place  : Integer;
          KSensMinus20  : TNullFloat64;
          OKMaxFon20r  : Boolean;
          OKMaxD24  : Boolean;
          HasFirmware  : Boolean;
          ISPlus50  : TNullFloat64;
          OKDFon50  : Boolean;
          ProductTypeName  : TNullString;
          DNotMeasured  : TNullFloat64;
          UnitsName  : string;
          DFon20  : TNullFloat64;
          OKMaxKSens20  : Boolean;
          GasName  : string;
          I13  : TNullFloat64;
          D26  : TNullFloat64;
          OKMinKSens50  : Boolean;
          OKMaxD17  : Boolean;
          Scale  : Double;
          KSens50  : TNullFloat64;
          Ok  : Boolean;
          PointsMethod  : TNullInt64;
          IFMinus20  : TNullFloat64;
          I17  : TNullFloat64;
          NotMeasured  : TNullFloat64;
        
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
          MaxDFon  : string;
          MinKSens50  : string;
          MaxKSens50  : string;
          MaxD1  : string;
          Concentration2  : Double;
          Note  : string;
          MinDTemp  : string;
          MaxDTemp  : string;
          PointsMethod  : Int64;
          Concentration1  : Double;
          MinKSens20  : string;
          MinFon  : string;
          MaxFon  : string;
          MaxKSens20  : string;
          MaxDNotMeasured  : string;
          MaxD2  : string;
          MaxD3  : string;
          ProductTypeName  : string;
          Concentration3  : Double;
        
    end;
    
    TTempPoints = record
    public
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
        
    end;
    
    TFirmwareInfo = record
    public
          Month  : Integer;
          Minute  : Integer;
          Serial  : string;
          Units  : string;
          ScaleEnd  : string;
          ProductTempPoints  : TTempPoints;
          TempValues  : TArray<string>;
          Day  : Integer;
          Year  : Integer;
          Gas  : string;
          SensitivityProduct  : string;
          Fon20  : string;
          ProductType  : string;
          ScaleBeg  : string;
          Hour  : Integer;
          Second  : Integer;
          SensitivityLab73  : string;
        
    end;
    
    TProductType2 = record
    public
          LifetimeMonths  : Int64;
          MaxKSens20  : TNullFloat64;
          MinDTemp  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          MaxD1  : TNullFloat64;
          Scale  : Double;
          MinFon  : TNullFloat64;
          MaxFon  : TNullFloat64;
          MaxDFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          KSens20  : TNullFloat64;
          MaxD2  : TNullFloat64;
          TempPoints  : TTempPoints;
          NobleMetalContent  : Double;
          MaxKSens50  : TNullFloat64;
          MaxD3  : TNullFloat64;
          PointsMethod  : Int64;
          UnitsName  : string;
          GasName  : string;
          MinKSens50  : TNullFloat64;
          Fon20  : TNullFloat64;
          Currents  : TArray<TArray<string>>;
          ProductTypeName  : string;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          LogComm  : Boolean;
          ComportName  : string;
          ComportName2  : string;
          AmbientTemperature  : Double;
          BlowGasMinutes  : Integer;
          HoldTemperatureMinutes  : Integer;
          EndScaleGas2  : Boolean;
          ComportGasName  : string;
          ChipType  : string;
        
    end;
    
    TCell = record
    public
          Str  : string;
          Res  : Integer;
          TextAlignment  : Integer;
        
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