
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
          I13  : TNullFloat64;
          I35  : TNullFloat64;
          OKMinFon20r  : Boolean;
          AppliedProductTypeName  : string;
          GasName  : string;
          UnitsName  : string;
          LifetimeMonths  : Int64;
          AppliedPointsMethod  : Int64;
          IFPlus20  : TNullFloat64;
          ISPlus20  : TNullFloat64;
          DFon50  : TNullFloat64;
          D13  : TNullFloat64;
          D17  : TNullFloat64;
          NoteProduct  : TNullString;
          NoteParty  : TNullString;
          OKMaxKSens20  : Boolean;
          PartyID  : Int64;
          OKMaxFon20  : Boolean;
          OKMaxD17  : Boolean;
          CreatedAt  : TDateTime;
          D35  : TNullFloat64;
          OKMaxKSens50  : Boolean;
          PointsMethod  : TNullInt64;
          IFPlus50  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          DFon20  : TNullFloat64;
          OKMinFon20  : Boolean;
          ProductTypeName  : TNullString;
          Serial  : TNullInt64;
          I17  : TNullFloat64;
          KSensMinus20  : TNullFloat64;
          KSens20  : TNullFloat64;
          OKDFon20  : Boolean;
          I24  : TNullFloat64;
          I26  : TNullFloat64;
          KSens50  : TNullFloat64;
          D26  : TNullFloat64;
          HasFirmware  : Boolean;
          ProductID  : Int64;
          DNotMeasured  : TNullFloat64;
          OKMaxFon20r  : Boolean;
          OKMinKSens50  : Boolean;
          OKDFon50  : Boolean;
          Place  : Integer;
          D24  : TNullFloat64;
          OKDNotMeasured  : Boolean;
          OKMaxD24  : Boolean;
          ISMinus20  : TNullFloat64;
          Production  : Boolean;
          Scale  : Double;
          Variation  : TNullFloat64;
          OKMaxD26  : Boolean;
          UnitsCode  : Byte;
          ISPlus50  : TNullFloat64;
          OKMinKSens20  : Boolean;
          OKMaxD35  : Boolean;
          IFMinus20  : TNullFloat64;
          Ok  : Boolean;
          GasCode  : Byte;
          OKMaxD13  : Boolean;
          NobleMetalContent  : Double;
        
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
          MaxKSens20  : string;
          MaxKSens50  : string;
          MaxDNotMeasured  : string;
          ProductTypeName  : string;
          Concentration1  : Double;
          Concentration3  : Double;
          MinKSens20  : string;
          Concentration2  : Double;
          MinKSens50  : string;
          MinDTemp  : string;
          PointsMethod  : Int64;
          MaxDTemp  : string;
          MaxD1  : string;
          MaxD2  : string;
          MaxD3  : string;
          Note  : string;
          MinFon  : string;
          MaxFon  : string;
          MaxDFon  : string;
        
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
          Sens  : TArray<Double>;
          Serial  : string;
          ProductType  : string;
          ISPlus20  : string;
          ISPlus50  : string;
          Place  : Integer;
          CreatedAt  : TGoDateTime;
          Sensitivity  : string;
          Units  : string;
          ScaleEnd  : string;
          Temp  : TArray<Double>;
          Sensitivity1  : string;
          Gas  : string;
          ScaleBeg  : string;
          ISMinus20  : string;
          Fon  : TArray<Double>;
          IFPlus20  : string;
        
    end;
    
    TFirmwareInfo2 = record
    public
          Month  : Integer;
          Minute  : Integer;
          ProductType  : string;
          Year  : Integer;
          Values  : TArray<string>;
          Sensitivity  : string;
          Units  : string;
          ScaleEnd  : string;
          Gas  : string;
          Day  : Integer;
          Hour  : Integer;
          Second  : Integer;
          Serial  : string;
          ScaleBegin  : string;
          Place  : Integer;
        
    end;
    
    TTempPoints = record
    public
          Sens  : TArray<Double>;
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TPublicAppConfig = record
    public
          ChipType  : string;
          AmbientTemperature  : Double;
          EndScaleGas2  : Boolean;
          ComportName  : string;
          ComportGasName  : string;
          LogComm  : Boolean;
          ComportName2  : string;
          BlowGasMinutes  : Integer;
          HoldTemperatureMinutes  : Integer;
        
    end;
    
    TCell = record
    public
          Str  : string;
          Res  : Integer;
          TextAlignment  : Integer;
        
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
          TemperatureOn  : Boolean;
          CoolOn  : Boolean;
          Temperature  : Double;
          Destination  : Double;
        
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