
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
          OKMaxKSens20  : Boolean;
          NoteParty  : TNullString;
          CreatedAt  : TDateTime;
          IFMinus20  : TNullFloat64;
          DFon20  : TNullFloat64;
          OKDFon20  : Boolean;
          OKMinKSens20  : Boolean;
          OKDFon50  : Boolean;
          AppliedProductTypeName  : string;
          UnitsName  : string;
          ProductID  : Int64;
          LifetimeMonths  : Int64;
          PointsMethod  : TNullInt64;
          AppliedPointsMethod  : Int64;
          NobleMetalContent  : Double;
          Variation  : TNullFloat64;
          OKMinFon20  : Boolean;
          OKMaxFon20r  : Boolean;
          OKMinKSens50  : Boolean;
          Production  : Boolean;
          PartyID  : Int64;
          NoteProduct  : TNullString;
          ISPlus50  : TNullFloat64;
          KSensMinus20  : TNullFloat64;
          GasCode  : Byte;
          ISPlus20  : TNullFloat64;
          I17  : TNullFloat64;
          HasFirmware  : Boolean;
          Scale  : Double;
          I24  : TNullFloat64;
          IFPlus20  : TNullFloat64;
          ISMinus20  : TNullFloat64;
          I13  : TNullFloat64;
          I35  : TNullFloat64;
          NotMeasured  : TNullFloat64;
          KSens50  : TNullFloat64;
          OKMaxFon20  : Boolean;
          Serial  : TNullInt64;
          OKMaxKSens50  : Boolean;
          Ok  : Boolean;
          UnitsCode  : Byte;
          GasName  : string;
          ProductTypeName  : TNullString;
          OKMinFon20r  : Boolean;
          I26  : TNullFloat64;
          KSens20  : TNullFloat64;
          DFon50  : TNullFloat64;
          DNotMeasured  : TNullFloat64;
          OKDNotMeasured  : Boolean;
          Place  : Integer;
        
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
          MaxKSens50  : TNullFloat64;
          MinDTemp  : TNullFloat64;
          MaxDTemp  : TNullFloat64;
          ProductTypeName  : string;
          Concentration1  : Double;
          Note  : TNullString;
          MinFon  : TNullFloat64;
          MaxKSens20  : TNullFloat64;
          PointsMethod  : Int64;
          MaxDNotMeasured  : TNullFloat64;
          Concentration3  : Double;
          MaxFon  : TNullFloat64;
          MinKSens20  : TNullFloat64;
          Concentration2  : Double;
          MaxDFon  : TNullFloat64;
          MinKSens50  : TNullFloat64;
        
    end;
    
    TGoDateTime = record
    public
          Minute  : Integer;
          Second  : Integer;
          Millisecond  : Integer;
          Year  : Integer;
          Month  : Integer;
          Day  : Integer;
          Hour  : Integer;
        
    end;
    
    TFirmwareInfo = record
    public
          Sensitivity1  : string;
          IFPlus20  : string;
          ISPlus50  : string;
          Place  : Integer;
          CreatedAt  : TGoDateTime;
          Units  : string;
          ScaleBeg  : string;
          ISMinus20  : string;
          Temp  : TArray<Double>;
          Sens  : TArray<Double>;
          Gas  : string;
          ScaleEnd  : string;
          Sensitivity  : string;
          Serial  : string;
          ISPlus20  : string;
          Fon  : TArray<Double>;
          ProductType  : string;
        
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
    
    TPublicAppConfig = record
    public
          BlowGasMinutes  : Integer;
          HoldTemperatureMinutes  : Integer;
          EndScaleGas2  : Boolean;
          ComportName  : string;
          ComportGasName  : string;
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
          What  : string;
          TotalSeconds  : Integer;
          ElapsedSeconds  : Integer;
        
    end;
    
    TScriptLine = record
    public
          Line  : string;
          Lineno  : Integer;
        
    end;
    

implementation

end.