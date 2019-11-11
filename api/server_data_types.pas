
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
          IFPlus50  : TNullFloat64;
          DFon20  : TNullFloat64;
          OKMaxKSens20  : Boolean;
          OKDNotMeasured  : Boolean;
          ProductID  : Int64;
          Place  : Integer;
          CreatedAt  : TDateTime;
          IFPlus20  : TNullFloat64;
          AppliedProductTypeName  : string;
          NoteProduct  : TNullString;
          UnitsName  : string;
          I26  : TNullFloat64;
          OKMinKSens20  : Boolean;
          Production  : Boolean;
          GasCode  : Byte;
          OKMaxFon20r  : Boolean;
          Ok  : Boolean;
          I17  : TNullFloat64;
          KSens20  : TNullFloat64;
          DFon50  : TNullFloat64;
          OKMinFon20r  : Boolean;
          Variation  : TNullFloat64;
          OKMinKSens50  : Boolean;
          UnitsCode  : Byte;
          PointsMethod  : TNullInt64;
          Serial  : TNullInt64;
          IFMinus20  : TNullFloat64;
          I24  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          AppliedPointsMethod  : Int64;
          ProductTypeName  : TNullString;
          NoteParty  : TNullString;
          NobleMetalContent  : Double;
          KSensMinus20  : TNullFloat64;
          DNotMeasured  : TNullFloat64;
          OKMinFon20  : Boolean;
          OKMaxKSens50  : Boolean;
          OKDFon20  : Boolean;
          ISMinus20  : TNullFloat64;
          GasName  : string;
          Scale  : Double;
          I35  : TNullFloat64;
          KSens50  : TNullFloat64;
          OKMaxFon20  : Boolean;
          OKDFon50  : Boolean;
          PartyID  : Int64;
          ISPlus20  : TNullFloat64;
          ISPlus50  : TNullFloat64;
          I13  : TNullFloat64;
          HasFirmware  : Boolean;
          LifetimeMonths  : Int64;
        
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
          MaxDNotMeasured  : string;
          ProductTypeName  : string;
          MaxFon  : string;
          MinKSens20  : string;
          MinDTemp  : string;
          PointsMethod  : Int64;
          Concentration1  : Double;
          Concentration2  : Double;
          MinFon  : string;
          MaxKSens20  : string;
          MaxKSens50  : string;
          MaxDTemp  : string;
          Concentration3  : Double;
          Note  : string;
        
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
          Temp  : TArray<Double>;
          CreatedAt  : TGoDateTime;
          Units  : string;
          ISMinus20  : string;
          ISPlus20  : string;
          Fon  : TArray<Double>;
          ProductType  : string;
          ScaleEnd  : string;
          IFPlus20  : string;
          Place  : Integer;
          Sensitivity1  : string;
          Serial  : string;
          ScaleBeg  : string;
          Sens  : TArray<Double>;
          Sensitivity  : string;
          Gas  : string;
          ISPlus50  : string;
        
    end;
    
    TFirmwareInfo2 = record
    public
          Second  : Integer;
          Gas  : string;
          Values  : TArray<string>;
          Month  : Integer;
          Day  : Integer;
          Year  : Integer;
          ProductType  : string;
          Minute  : Integer;
          ScaleBegin  : string;
          Sensitivity  : string;
          Serial  : string;
          Units  : string;
          ScaleEnd  : string;
          Place  : Integer;
          Hour  : Integer;
        
    end;
    
    TTempPoints = record
    public
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
          Temp  : TArray<Double>;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLineno  : Integer;
          ErrorLine  : string;
        
    end;
    
    TPublicAppConfig = record
    public
          HoldTemperatureMinutes  : Integer;
          EndScaleGas2  : Boolean;
          BlowGasMinutes  : Integer;
          ComportName  : string;
          ComportGasName  : string;
          ComportName2  : string;
          LogComm  : Boolean;
          ChipType  : string;
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