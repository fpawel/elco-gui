 
unit services;

interface

uses server_data_types, superobject;

type 
     TPartiesCatalogueSvc = class 
    public
        class function CopyParty( param1: Int64) : TParty;static;
        class function Days( Year: Integer; Month: Integer) : TArray<Integer>;static;
        class procedure DeleteDay( param1: Integer; param2: Integer; param3: Integer) ;static;
        class procedure DeleteMonth( param1: Integer; param2: Integer) ;static;
        class procedure DeletePartyID( param1: Int64) ;static;
        class procedure DeleteYear( param1: Integer) ;static;
        class function Months( Year: Integer) : TArray<Integer>;static;
        class function NewParty: TParty;static;
        class function Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;static;
        class function Party( param1: Int64) : TParty;static;
        class procedure SetProductProduction( ProductID: Int64; Production: Boolean) ;static;
        class procedure ToggleProductProduction( param1: Int64) ;static;
        class function Years: TArray<Integer>;static;
         
    end; TLastPartySvc = class 
    public
        class function CalculateFonMinus20: TParty;static;
        class function CalculateSensMinus20( param1: Double) : TParty;static;
        class function CalculateSensPlus50( param1: Double) : TParty;static;
        class procedure DeleteProductAtPlace( param1: Integer) ;static;
        class procedure Export;static;
        class function GetCheckBlocks: TGetCheckBlocksArg;static;
        class function Import: TParty;static;
        class function Party: TParty;static;
        class function PartyID: Int64;static;
        class function ProductAtPlace( param1: Integer) : TProduct;static;
        class procedure SelectAll( param1: Boolean) ;static;
        class function SelectOnlyOkProductsProduction: TParty;static;
        class function SetBlockChecked( param1: Integer; param2: Integer) : Int64;static;
        class function SetPointsMethodAtPlace( Place: Integer; PointsMethod: Int64; Valid: Boolean) : Int64;static;
        class function SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;static;
        class function SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;static;
        class function SetProductTypeAtPlace( Place: Integer; ProductType: string) : Int64;static;
        class function ToggleProductProductionAtPlace( param1: Integer) : Int64;static;
         
    end; TProductTypesSvc = class 
    public
        class function Gases: TArray<string>;static;
        class function Names: TArray<string>;static;
        class function Units: TArray<string>;static;
         
    end; TPlaceFirmware = class 
    public
        class function CalculateFirmwareInfo( param1: Int64) : TFirmwareInfo;static;
        class procedure RunReadPlaceFirmware( param1: Integer) ;static;
        class procedure RunWritePlaceFirmware( Place: Integer; Year: Integer; Month: Integer; Day: Integer; Hour: Integer; Minute: Integer; Second: Integer; Sensitivity: string; Serial: string; ProductType: string; Gas: string; Units: string; ScaleBegin: string; ScaleEnd: string; Values: TArray<string>) ;static;
        class function StoredFirmwareInfo( param1: Int64) : TFirmwareInfo;static;
        class function TempPoints( Values: TArray<string>) : TTempPoints;static;
         
    end; TSettingsSvc = class 
    public
        class function ChangePredefinedConfig( param1: string) : string;static;
        class function PredefinedConfig: string;static;
        class function Sections: TConfigSections;static;
        class function SetDefaultPredefinedConfig: string;static;
        class procedure SetValue( param1: string; param2: string; param3: string) ;static;
         
    end; TRunnerSvc = class 
    public
        class procedure RunMainError;static;
        class procedure RunReadAndSaveProductCurrents( param1: string) ;static;
        class procedure RunReadCurrent;static;
        class procedure RunTemperature( param1: Boolean; param2: Boolean; param3: Boolean) ;static;
        class procedure RunWritePartyFirmware;static;
        class procedure SkipDelay;static;
        class procedure StopHardware;static;
         
    end; TPdfSvc = class 
    public
        class procedure Run( param1: Int64) ;static;
         
    end;

implementation 

uses HttpRpcClient, SuperObjectHelp;

  
class function TPartiesCatalogueSvc.CopyParty( param1: Int64) : TParty;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('PartiesCatalogueSvc.CopyParty', req, Result); 
end;

 
class function TPartiesCatalogueSvc.Days( Year: Integer; Month: Integer) : TArray<Integer>;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    ThttpRpcClient.Call('PartiesCatalogueSvc.Days', req, Result); 
end;

 
class procedure TPartiesCatalogueSvc.DeleteDay( param1: Integer; param2: Integer; param3: Integer) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.DeleteDay', req); 
end;

 
class procedure TPartiesCatalogueSvc.DeleteMonth( param1: Integer; param2: Integer) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.DeleteMonth', req); 
end;

 
class procedure TPartiesCatalogueSvc.DeletePartyID( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.DeletePartyID', req); 
end;

 
class procedure TPartiesCatalogueSvc.DeleteYear( param1: Integer) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.DeleteYear', req); 
end;

 
class function TPartiesCatalogueSvc.Months( Year: Integer) : TArray<Integer>;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    ThttpRpcClient.Call('PartiesCatalogueSvc.Months', req, Result); 
end;

 
class function TPartiesCatalogueSvc.NewParty: TParty;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('PartiesCatalogueSvc.NewParty', req, Result); 
end;

 
class function TPartiesCatalogueSvc.Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
    ThttpRpcClient.Call('PartiesCatalogueSvc.Parties', req, Result); 
end;

 
class function TPartiesCatalogueSvc.Party( param1: Int64) : TParty;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('PartiesCatalogueSvc.Party', req, Result); 
end;

 
class procedure TPartiesCatalogueSvc.SetProductProduction( ProductID: Int64; Production: Boolean) ;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'ProductID', ProductID);
    SuperObject_SetField(req, 'Production', Production);
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.SetProductProduction', req); 
end;

 
class procedure TPartiesCatalogueSvc.ToggleProductProduction( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.ToggleProductProduction', req); 
end;

 
class function TPartiesCatalogueSvc.Years: TArray<Integer>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('PartiesCatalogueSvc.Years', req, Result); 
end;

  
class function TLastPartySvc.CalculateFonMinus20: TParty;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.CalculateFonMinus20', req, Result); 
end;

 
class function TLastPartySvc.CalculateSensMinus20( param1: Double) : TParty;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('LastPartySvc.CalculateSensMinus20', req, Result); 
end;

 
class function TLastPartySvc.CalculateSensPlus50( param1: Double) : TParty;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('LastPartySvc.CalculateSensPlus50', req, Result); 
end;

 
class procedure TLastPartySvc.DeleteProductAtPlace( param1: Integer) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('LastPartySvc.DeleteProductAtPlace', req); 
end;

 
class procedure TLastPartySvc.Export;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('LastPartySvc.Export', req); 
end;

 
class function TLastPartySvc.GetCheckBlocks: TGetCheckBlocksArg;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.GetCheckBlocks', req, Result); 
end;

 
class function TLastPartySvc.Import: TParty;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.Import', req, Result); 
end;

 
class function TLastPartySvc.Party: TParty;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.Party', req, Result); 
end;

 
class function TLastPartySvc.PartyID: Int64;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.PartyID', req, Result); 
end;

 
class function TLastPartySvc.ProductAtPlace( param1: Integer) : TProduct;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('LastPartySvc.ProductAtPlace', req, Result); 
end;

 
class procedure TLastPartySvc.SelectAll( param1: Boolean) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('LastPartySvc.SelectAll', req); 
end;

 
class function TLastPartySvc.SelectOnlyOkProductsProduction: TParty;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('LastPartySvc.SelectOnlyOkProductsProduction', req, Result); 
end;

 
class function TLastPartySvc.SetBlockChecked( param1: Integer; param2: Integer) : Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    ThttpRpcClient.Call('LastPartySvc.SetBlockChecked', req, Result); 
end;

 
class function TLastPartySvc.SetPointsMethodAtPlace( Place: Integer; PointsMethod: Int64; Valid: Boolean) : Int64;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'PointsMethod', PointsMethod);
    SuperObject_SetField(req, 'Valid', Valid);
    ThttpRpcClient.Call('LastPartySvc.SetPointsMethodAtPlace', req, Result); 
end;

 
class function TLastPartySvc.SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Note', Note);
    ThttpRpcClient.Call('LastPartySvc.SetProductNoteAtPlace', req, Result); 
end;

 
class function TLastPartySvc.SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    ThttpRpcClient.Call('LastPartySvc.SetProductSerialAtPlace', req, Result); 
end;

 
class function TLastPartySvc.SetProductTypeAtPlace( Place: Integer; ProductType: string) : Int64;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'ProductType', ProductType);
    ThttpRpcClient.Call('LastPartySvc.SetProductTypeAtPlace', req, Result); 
end;

 
class function TLastPartySvc.ToggleProductProductionAtPlace( param1: Integer) : Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('LastPartySvc.ToggleProductProductionAtPlace', req, Result); 
end;

  
class function TProductTypesSvc.Gases: TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ProductTypesSvc.Gases', req, Result); 
end;

 
class function TProductTypesSvc.Names: TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ProductTypesSvc.Names', req, Result); 
end;

 
class function TProductTypesSvc.Units: TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ProductTypesSvc.Units', req, Result); 
end;

  
class function TPlaceFirmware.CalculateFirmwareInfo( param1: Int64) : TFirmwareInfo;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('PlaceFirmware.CalculateFirmwareInfo', req, Result); 
end;

 
class procedure TPlaceFirmware.RunReadPlaceFirmware( param1: Integer) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PlaceFirmware.RunReadPlaceFirmware', req); 
end;

 
class procedure TPlaceFirmware.RunWritePlaceFirmware( Place: Integer; Year: Integer; Month: Integer; Day: Integer; Hour: Integer; Minute: Integer; Second: Integer; Sensitivity: string; Serial: string; ProductType: string; Gas: string; Units: string; ScaleBegin: string; ScaleEnd: string; Values: TArray<string>) ;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    SuperObject_SetField(req, 'Day', Day);
    SuperObject_SetField(req, 'Hour', Hour);
    SuperObject_SetField(req, 'Minute', Minute);
    SuperObject_SetField(req, 'Second', Second);
    SuperObject_SetField(req, 'Sensitivity', Sensitivity);
    SuperObject_SetField(req, 'Serial', Serial);
    SuperObject_SetField(req, 'ProductType', ProductType);
    SuperObject_SetField(req, 'Gas', Gas);
    SuperObject_SetField(req, 'Units', Units);
    SuperObject_SetField(req, 'ScaleBegin', ScaleBegin);
    SuperObject_SetField(req, 'ScaleEnd', ScaleEnd);
    SuperObject_SetField(req, 'Values', Values);
    ThttpRpcClient.GetResponse('PlaceFirmware.RunWritePlaceFirmware', req); 
end;

 
class function TPlaceFirmware.StoredFirmwareInfo( param1: Int64) : TFirmwareInfo;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('PlaceFirmware.StoredFirmwareInfo', req, Result); 
end;

 
class function TPlaceFirmware.TempPoints( Values: TArray<string>) : TTempPoints;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Values', Values);
    ThttpRpcClient.Call('PlaceFirmware.TempPoints', req, Result); 
end;

  
class function TSettingsSvc.ChangePredefinedConfig( param1: string) : string;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    Result := ThttpRpcClient.GetResponse('SettingsSvc.ChangePredefinedConfig', req).AsString; 
end;

 
class function TSettingsSvc.PredefinedConfig: string;
var
    req : ISuperobject;
begin
    req := SO;
    Result := ThttpRpcClient.GetResponse('SettingsSvc.PredefinedConfig', req).AsString; 
end;

 
class function TSettingsSvc.Sections: TConfigSections;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('SettingsSvc.Sections', req, Result); 
end;

 
class function TSettingsSvc.SetDefaultPredefinedConfig: string;
var
    req : ISuperobject;
begin
    req := SO;
    Result := ThttpRpcClient.GetResponse('SettingsSvc.SetDefaultPredefinedConfig', req).AsString; 
end;

 
class procedure TSettingsSvc.SetValue( param1: string; param2: string; param3: string) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
    ThttpRpcClient.GetResponse('SettingsSvc.SetValue', req); 
end;

  
class procedure TRunnerSvc.RunMainError;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('RunnerSvc.RunMainError', req); 
end;

 
class procedure TRunnerSvc.RunReadAndSaveProductCurrents( param1: string) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('RunnerSvc.RunReadAndSaveProductCurrents', req); 
end;

 
class procedure TRunnerSvc.RunReadCurrent;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('RunnerSvc.RunReadCurrent', req); 
end;

 
class procedure TRunnerSvc.RunTemperature( param1: Boolean; param2: Boolean; param3: Boolean) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
    ThttpRpcClient.GetResponse('RunnerSvc.RunTemperature', req); 
end;

 
class procedure TRunnerSvc.RunWritePartyFirmware;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('RunnerSvc.RunWritePartyFirmware', req); 
end;

 
class procedure TRunnerSvc.SkipDelay;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('RunnerSvc.SkipDelay', req); 
end;

 
class procedure TRunnerSvc.StopHardware;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('RunnerSvc.StopHardware', req); 
end;

  
class procedure TPdfSvc.Run( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PdfSvc.Run', req); 
end;

 
end.