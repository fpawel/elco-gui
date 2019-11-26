
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
          Valid  : Boolean;
          Int64  : Int64;
        
    end;
    
    TNullFloat64 = record
    public
          Float64  : Double;
          Valid  : Boolean;
        
    end;
    
    TProductInfo = record
    public
          ISMinus20  : TNullFloat64;
          OKDFon50  : Boolean;
          OKMaxD17  : Boolean;
          KSensMinus20  : TNullFloat64;
          OKMinKSens50  : Boolean;
          Production  : Boolean;
          I26  : TNullFloat64;
          OKMaxD24  : Boolean;
          Serial  : TNullInt64;
          OKMaxFon20r  : Boolean;
          OKDNotMeasured  : Boolean;
          OKMaxD26  : Boolean;
          GasCode  : Byte;
          PointsMethod  : TNullInt64;
          NoteProduct  : TNullString;
          IFMinus20  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          VariationConcentration  : TNullFloat64;
          DFon50  : TNullFloat64;
          AppliedProductTypeName  : string;
          UnitsName  : string;
          CreatedAt  : TDateTime;
          IFPlus50  : TNullFloat64;
          D26  : TNullFloat64;
          GasName  : string;
          NobleMetalContent  : Double;
          ProductID  : Int64;
          ISPlus20  : TNullFloat64;
          I35  : TNullFloat64;
          OKMaxD13  : Boolean;
          LifetimeMonths  : Int64;
          ProductTypeName  : TNullString;
          Place  : Integer;
          OKMinKSens20  : Boolean;
          Ok  : Boolean;
          AppliedPointsMethod  : Int64;
          D17  : TNullFloat64;
          OKMinFon20  : Boolean;
          NoteParty  : TNullString;
          OKMaxKSens20  : Boolean;
          ISPlus50  : TNullFloat64;
          IFPlus20  : TNullFloat64;
          OKMaxKSens50  : Boolean;
          I24  : TNullFloat64;
          KSens50  : TNullFloat64;
          Variation  : TNullFloat64;
          DFon20  : TNullFloat64;
          D13  : TNullFloat64;
          OKDFon20  : Boolean;
          OKMaxD35  : Boolean;
          HasFirmware  : Boolean;
          Scale  : Double;
          PartyID  : Int64;
          I13  : TNullFloat64;
          D24  : TNullFloat64;
          OKMinFon20r  : Boolean;
          DNotMeasured  : TNullFloat64;
          D35  : TNullFloat64;
          I17  : TNullFloat64;
          KSens20  : TNullFloat64;
          OKMaxFon20  : Boolean;
          UnitsCode  : Byte;
        
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
          MinKSens20  : string;
          MaxD1  : string;
          MaxD3  : string;
          MaxFon  : string;
          Concentration2  : Double;
          MinKSens50  : string;
          MaxKSens50  : string;
          PointsMethod  : Int64;
          ProductTypeName  : string;
          MinFon  : string;
          MaxKSens20  : string;
          Note  : string;
          Concentration3  : Double;
          MaxDFon  : string;
          MinDTemp  : string;
          MaxDTemp  : string;
          MaxDNotMeasured  : string;
          MaxD2  : string;
          Concentration1  : Double;
        
    end;
    
    TTempPoints = record
    public
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
        
    end;
    
    TFirmwareInfo = record
    public
          ProductTempPoints  : TTempPoints;
          Hour  : Integer;
          SensitivityLab73  : string;
          Serial  : string;
          ProductType  : string;
          ScaleBeg  : string;
          Fon20  : string;
          Units  : string;
          TempValues  : TArray<string>;
          Place  : Integer;
          Year  : Integer;
          Minute  : Integer;
          Second  : Integer;
          Month  : Integer;
          Day  : Integer;
          SensitivityProduct  : string;
          Gas  : string;
          ScaleEnd  : string;
        
    end;
    
    TFirmware = record
    public
          FirmwareInfo  : TFirmwareInfo;
          Bytes  : TArray<string>;
        
    end;
    
    TProductType2 = record
    public
          NobleMetalContent  : Double;
          MinFon  : TNullFloat64;
          MaxKSens50  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          Fon20  : TNullFloat64;
          MaxD2  : TNullFloat64;
          MaxD3  : TNullFloat64;
          PointsMethod  : Int64;
          MaxKSens20  : TNullFloat64;
          MinKSens50  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          MaxD1  : TNullFloat64;
          TempPoints  : TTempPoints;
          GasName  : string;
          LifetimeMonths  : Int64;
          MaxDFon  : TNullFloat64;
          KSens20  : TNullFloat64;
          ProductTypeName  : string;
          UnitsName  : string;
          Scale  : Double;
          MaxFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          MinDTemp  : TNullFloat64;
          Currents  : TArray<TArray<string>>;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          ComportGasName  : string;
          ComportName2  : string;
          ChipType  : string;
          AmbientTemperature  : Double;
          HoldTemperatureMinutes  : Integer;
          EndScaleGas2  : Boolean;
          ComportName  : string;
          LogComm  : Boolean;
          BlowGasMinutes  : Integer;
        
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