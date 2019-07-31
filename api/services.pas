 
unit services;

interface

uses server_data_types, superobject;

type 
     TPartiesCatalogueSvc = class 
    public
        class function Days( Year: Integer; Month: Integer) : TArray<Integer>;static;
        class procedure DeletePartyID( param1: Int64) ;static;
        class function Months( Year: Integer) : TArray<Integer>;static;
        class function NewParty: TParty;static;
        class function Parties( Year: Integer; Month: Integer; Day: Integer) : TArray<TParty>;static;
        class function PartiesOfYearMonth( Year: Integer; Month: Integer) : TArray<TParty2>;static;
        class function Party( param1: Int64) : TParty;static;
        class procedure SetProductsProduction( ProductIDs: TArray<Int64>; Production: Boolean) ;static;
        class procedure ToggleProductProduction( param1: Int64) ;static;
        class function Years: TArray<Integer>;static;
        class function YearsMonths: TArray<TYearMonth>;static;
         
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
        class function SetPointsMethodInPlacesRange( Place1: Integer; Place2: Integer; Value: Integer) : Int64;static;
        class function SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;static;
        class function SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;static;
        class function SetProductTypeAtPlacesRange( Place1: Integer; Place2: Integer; ProductType: string) : Int64;static;
        class procedure SetValues( Values: TLastPartyValues) ;static;
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
         
    end; TRunnerSvc = class 
    public
        class procedure CopyParty( param1: Int64) ;static;
        class procedure RunMain( param1: Boolean; param2: Boolean; param3: Boolean; param4: Boolean) ;static;
        class procedure RunReadAndSaveProductCurrents( param1: string) ;static;
        class procedure RunReadCurrent;static;
        class procedure RunSwitchGas( param1: Integer) ;static;
        class procedure RunWritePartyFirmware;static;
        class procedure SkipDelay;static;
        class procedure StopHardware;static;
         
    end; TPdfSvc = class 
    public
        class procedure RunPartyID( param1: Int64) ;static;
        class procedure RunProductID( param1: Int64) ;static;
         
    end; TPeerSvc = class 
    public
        class procedure Close;static;
        class procedure Init;static;
         
    end; TConfigSvc = class 
    public
        class function Dev: string;static;
        class function GetGui: TGuiSettings;static;
        class function SetDefaultDev: string;static;
        class function SetDev( param1: string) : string;static;
        class procedure SetGui( C: TGuiSettings) ;static;
         
    end;

implementation 

uses HttpRpcClient, SuperObjectHelp, Grijjy.Bson.Serialization;

  
class function TPartiesCatalogueSvc.Days( Year: Integer; Month: Integer) : TArray<Integer>;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    ThttpRpcClient.Call('PartiesCatalogueSvc.Days', req, Result); 
end;

 
class procedure TPartiesCatalogueSvc.DeletePartyID( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.DeletePartyID', req); 
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

 
class function TPartiesCatalogueSvc.PartiesOfYearMonth( Year: Integer; Month: Integer) : TArray<TParty2>;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Year', Year);
    SuperObject_SetField(req, 'Month', Month);
    ThttpRpcClient.Call('PartiesCatalogueSvc.PartiesOfYearMonth', req, Result); 
end;

 
class function TPartiesCatalogueSvc.Party( param1: Int64) : TParty;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.Call('PartiesCatalogueSvc.Party', req, Result); 
end;

 
class procedure TPartiesCatalogueSvc.SetProductsProduction( ProductIDs: TArray<Int64>; Production: Boolean) ;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'ProductIDs', ProductIDs);
    SuperObject_SetField(req, 'Production', Production);
    ThttpRpcClient.GetResponse('PartiesCatalogueSvc.SetProductsProduction', req); 
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

 
class function TPartiesCatalogueSvc.YearsMonths: TArray<TYearMonth>;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('PartiesCatalogueSvc.YearsMonths', req, Result); 
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
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.PartyID', req), Result); 
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
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.SetBlockChecked', req), Result); 
end;

 
class function TLastPartySvc.SetPointsMethodInPlacesRange( Place1: Integer; Place2: Integer; Value: Integer) : Int64;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place1', Place1);
    SuperObject_SetField(req, 'Place2', Place2);
    SuperObject_SetField(req, 'Value', Value);
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.SetPointsMethodInPlacesRange', req), Result); 
end;

 
class function TLastPartySvc.SetProductNoteAtPlace( Place: Integer; Note: string) : Int64;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place', Place);
    SuperObject_SetField(req, 'Note', Note);
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.SetProductNoteAtPlace', req), Result); 
end;

 
class function TLastPartySvc.SetProductSerialAtPlace( param1: Integer; param2: Integer) : Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.SetProductSerialAtPlace', req), Result); 
end;

 
class function TLastPartySvc.SetProductTypeAtPlacesRange( Place1: Integer; Place2: Integer; ProductType: string) : Int64;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_SetField(req, 'Place1', Place1);
    SuperObject_SetField(req, 'Place2', Place2);
    SuperObject_SetField(req, 'ProductType', ProductType);
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.SetProductTypeAtPlacesRange', req), Result); 
end;

 
class procedure TLastPartySvc.SetValues( Values: TLastPartyValues) ;
var
    req : ISuperobject;
    s:string;
begin
    req := SO;
    TgoBsonSerializer.serialize(Values, s); req['Values'] := SO(s);
    ThttpRpcClient.GetResponse('LastPartySvc.SetValues', req); 
end;

 
class function TLastPartySvc.ToggleProductProductionAtPlace( param1: Integer) : Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    SuperObject_Get(ThttpRpcClient.GetResponse('LastPartySvc.ToggleProductProductionAtPlace', req), Result); 
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

  
class procedure TRunnerSvc.CopyParty( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('RunnerSvc.CopyParty', req); 
end;

 
class procedure TRunnerSvc.RunMain( param1: Boolean; param2: Boolean; param3: Boolean; param4: Boolean) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    req.AsArray.Add(param2) ;
    req.AsArray.Add(param3) ;
    req.AsArray.Add(param4) ;
    ThttpRpcClient.GetResponse('RunnerSvc.RunMain', req); 
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

 
class procedure TRunnerSvc.RunSwitchGas( param1: Integer) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('RunnerSvc.RunSwitchGas', req); 
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

  
class procedure TPdfSvc.RunPartyID( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PdfSvc.RunPartyID', req); 
end;

 
class procedure TPdfSvc.RunProductID( param1: Int64) ;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    ThttpRpcClient.GetResponse('PdfSvc.RunProductID', req); 
end;

  
class procedure TPeerSvc.Close;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('PeerSvc.Close', req); 
end;

 
class procedure TPeerSvc.Init;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.GetResponse('PeerSvc.Init', req); 
end;

  
class function TConfigSvc.Dev: string;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_Get(ThttpRpcClient.GetResponse('ConfigSvc.Dev', req), Result); 
end;

 
class function TConfigSvc.GetGui: TGuiSettings;
var
    req : ISuperobject;
begin
    req := SO;
    ThttpRpcClient.Call('ConfigSvc.GetGui', req, Result); 
end;

 
class function TConfigSvc.SetDefaultDev: string;
var
    req : ISuperobject;
begin
    req := SO;
    SuperObject_Get(ThttpRpcClient.GetResponse('ConfigSvc.SetDefaultDev', req), Result); 
end;

 
class function TConfigSvc.SetDev( param1: string) : string;
var
    req : ISuperobject;
begin
    req := SA([]);
    req.AsArray.Add(param1) ;
    SuperObject_Get(ThttpRpcClient.GetResponse('ConfigSvc.SetDev', req), Result); 
end;

 
class procedure TConfigSvc.SetGui( C: TGuiSettings) ;
var
    req : ISuperobject;
    s:string;
begin
    req := SO;
    TgoBsonSerializer.serialize(C, s); req['C'] := SO(s);
    ThttpRpcClient.GetResponse('ConfigSvc.SetGui', req); 
end;

 
end.