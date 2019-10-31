
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
          KSens20  : TNullFloat64;
          DNotMeasured  : TNullFloat64;
          OKMaxFon20  : Boolean;
          OKMaxFon20r  : Boolean;
          OKMinKSens20  : Boolean;
          HasFirmware  : Boolean;
          Place  : Integer;
          NotMeasured  : TNullFloat64;
          UnitsCode  : Byte;
          Scale  : Double;
          I17  : TNullFloat64;
          KSens50  : TNullFloat64;
          GasCode  : Byte;
          Serial  : TNullInt64;
          I26  : TNullFloat64;
          OKMinKSens50  : Boolean;
          OKMaxKSens50  : Boolean;
          UnitsName  : string;
          IFPlus50  : TNullFloat64;
          KSensMinus20  : TNullFloat64;
          IFMinus20  : TNullFloat64;
          ISMinus20  : TNullFloat64;
          ISPlus20  : TNullFloat64;
          I35  : TNullFloat64;
          DFon50  : TNullFloat64;
          OKMinFon20r  : Boolean;
          PartyID  : Int64;
          CreatedAt  : TDateTime;
          LifetimeMonths  : Int64;
          OKDFon20  : Boolean;
          AppliedProductTypeName  : string;
          NoteParty  : TNullString;
          OKDFon50  : Boolean;
          NoteProduct  : TNullString;
          I13  : TNullFloat64;
          OKMinFon20  : Boolean;
          OKMaxKSens20  : Boolean;
          OKDNotMeasured  : Boolean;
          Ok  : Boolean;
          NobleMetalContent  : Double;
          ProductID  : Int64;
          ISPlus50  : TNullFloat64;
          PointsMethod  : TNullInt64;
          AppliedPointsMethod  : Int64;
          I24  : TNullFloat64;
          Variation  : TNullFloat64;
          Production  : Boolean;
          GasName  : string;
          ProductTypeName  : TNullString;
          IFPlus20  : TNullFloat64;
          DFon20  : TNullFloat64;
        
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
          MaxDFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          MaxDNotMeasured  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          Concentration1  : Double;
          Concentration2  : Double;
          Concentration3  : Double;
          Note  : TNullString;
          MaxFon  : TNullFloat64;
          PointsMethod  : Int64;
          ProductTypeName  : string;
          MinFon  : TNullFloat64;
          MaxKSens20  : TNullFloat64;
          MinKSens50  : TNullFloat64;
          MaxKSens50  : TNullFloat64;
          MinDTemp  : TNullFloat64;
        
    end;
    
    TGoDateTime = record
    public
          Millisecond  : Integer;
          Year  : Integer;
          Month  : Integer;
          Day  : Integer;
          Hour  : Integer;
          Minute  : Integer;
          Second  : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
          Fon  : TArray<Double>;
          CreatedAt  : TGoDateTime;
          Serial  : string;
          Gas  : string;
          ISMinus20  : string;
          ISPlus50  : string;
          Place  : Integer;
          Sensitivity  : string;
          ISPlus20  : string;
          Temp  : TArray<Double>;
          Sens  : TArray<Double>;
          Sensitivity1  : string;
          ProductType  : string;
          Units  : string;
          ScaleBeg  : string;
          ScaleEnd  : string;
          IFPlus20  : string;
        
    end;
    
    TTempPoints = record
    public
          Temp  : TArray<Double>;
          Fon  : TArray<Double>;
          Sens  : TArray<Double>;
        
    end;
    
    TRunScriptResult = record
    public
          ErrorLine  : string;
          ErrorLineno  : Integer;
        
    end;
    
    TFinsSettings = record
    public
          FinsUnit  : Byte;
          IP  : string;
          Port  : Integer;
          Network  : Byte;
          Node  : Byte;
        
    end;
    
    TFinsNetwork = record
    public
          Server  : TFinsSettings;
          Client  : TFinsSettings;
          MaxAttemptsRead  : Integer;
          TimeoutMS  : Integer;
          PollSec  : Int64;
        
    end;
    
    TConfig = record
    public
          ReadByteTimeoutMillis  : Integer;
          MaxAttemptsRead  : Integer;
          PauseMillis  : Integer;
          ReadTimeoutMillis  : Integer;
        
    end;
    
    TAppConfig = record
    public
          ComportName  : string;
          ChipType  : string;
          AmbientTemperature  : Double;
          Comport  : TConfig;
          ReadBlockPauseSeconds  : Integer;
          ComportGasName  : string;
          ComportGas  : TConfig;
          WaitFlashStatusDelay  : Integer;
          LogComm  : Boolean;
          BlowGasMinutes  : Integer;
          EndScaleGas2  : Boolean;
          ReadRangeDelayMillis  : Integer;
          HoldTemperatureMinutes  : Integer;
          FinsNetwork  : TFinsNetwork;
          StatusTimeoutSeconds  : Integer;
        
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
          Destination  : Double;
          TemperatureOn  : Boolean;
          CoolOn  : Boolean;
          Temperature  : Double;
        
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