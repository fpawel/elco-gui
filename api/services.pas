
unit services;

interface

uses superobject, server_data_types;

type 
    TPartiesCatalogueSvc = class
    public
        class procedure DeletePartyID(param1:Int64);static;
        class function PartiesOfYearMonth(Year:Integer; Month:Integer):TArray<TParty2>;static;
        class function Party(param1:Int64):TParty1;static;
        class procedure SetProductsProduction(ProductIDs:TArray<Int64>; Production:Boolean);static;
        class procedure ToggleProductProduction(param1:Int64);static;
        class function YearsMonths:TArray<TYearMonth>;static;
         
    end;

    TLastPartySvc = class
    public
        class function CalculateFonMinus20:TParty1;static;
        class function CalculateSensMinus20(param1:Double):TParty1;static;
        class function CalculateSensPlus50(param1:Double):TParty1;static;
        class procedure DeleteProductAtPlace(param1:Integer);static;
        class function GetCheckBlocks:TGetCheckBlocksArg;static;
        class function GetValues:TParty3;static;
        class function Party:TParty1;static;
        class function PartyID:Int64;static;
        class function ProductAtPlace(param1:Integer):TProductInfo;static;
        class procedure SelectAll(param1:Boolean);static;
        class function SelectOnlyOkProductsProduction:TParty1;static;
        class function SetBlockChecked(param1:Integer; param2:Integer):Int64;static;
        class function SetPointsMethodInPlacesRange(Place1:Integer; Place2:Integer; Value:Integer):Int64;static;
        class function SetProductNoteAtPlace(Place:Integer; Note:string):Int64;static;
        class function SetProductSerialAtPlace(param1:Integer; param2:Integer):Int64;static;
        class procedure SetProductType(param1:string);static;
        class function SetProductTypeAtPlacesRange(Place1:Integer; Place2:Integer; ProductType:string):Int64;static;
        class procedure SetValues(P:TParty3);static;
        class function ToggleProductProductionAtPlace(param1:Integer):Int64;static;
         
    end;

    TProductTypesSvc = class
    public
        class function Gases:TArray<string>;static;
        class function Names:TArray<string>;static;
        class function Units:TArray<string>;static;
         
    end;

    TPlaceFirmware = class
    public
        class function CalculateFirmwareByProductType(ProductTypeName:string; Place:Integer; Serial:Integer):TFirmwareInfo;static;
        class function CalculateFirmwareInfo(param1:Int64):TFirmwareInfo;static;
        class procedure RunReadPlaceFirmware(param1:Integer);static;
        class procedure RunWritePlaceFirmware(X:TFirmwareInfo2);static;
        class procedure SaveProductType(X:TFirmwareInfo2);static;
        class function StoredFirmwareInfo(param1:Int64):TFirmwareInfo;static;
        class function TempPoints(Values:TArray<string>):TTempPoints;static;
         
    end;

    TRunnerSvc = class
    public
        class procedure CopyParty(param1:Int64);static;
        class procedure NewParty(Serials:TArray<Int64>);static;
        class procedure RunMain(param1:Boolean; param2:Boolean; param3:Boolean; param4:Boolean);static;
        class procedure RunReadAndSaveProductCurrents(Column:string; Gas:Integer; Temperature:Double);static;
        class procedure RunReadCurrent;static;
        class function RunScript(param1:string):TRunScriptResult;static;
        class procedure RunSwitchGas(param1:Integer);static;
        class procedure RunWritePartyFirmware;static;
        class procedure SkipDelay;static;
        class procedure StopHardware;static;
         
    end;

    TPdfSvc = class
    public
        class procedure RunPartyID(param1:Int64);static;
        class procedure RunProductID(param1:Int64);static;
         
    end;

    TConfigSvc = class
    public
        class function GetConfig:TPublicAppConfig;static;
        class function GetYAML:string;static;
        class procedure SetConfig(C:TPublicAppConfig);static;
        class function SetYAML(param1:string):string;static;
         
    end;

    TProductsCatalogueSvc = class
    public
        class function ListProductsByNote(param1:string):TArray<TArray<TCell>>;static;
        class function ListProductsByPartyID(param1:Integer):TArray<TArray<TCell>>;static;
        class function ListProductsBySerial(param1:Integer):TArray<TArray<TCell>>;static;
        class function ProductByID(param1:Int64):TArray<TArray<TCell>>;static;
        class function ProductByIDHasFirmware(param1:Int64):Boolean;static;
        class function ProductCurrents(param1:Int64):TArray<TProductCurrent>;static;
        class function ProductInfoByID(param1:Int64):TProductInfo;static;
         
    end;

    

function GetHttpServerAddr: string;

implementation 

uses System.SysUtils,  winapi.windows, HttpRpcClient, SuperObjectHelp, Grijjy.Bson.Serialization;

function GetHttpServerAddr: string;
begin
    result := 'http://127.0.0.1:' + GetEnvironmentVariable('ELCO_API_PORT');
end;

 
class procedure TPartiesCatalogueSvc.DeletePartyID(param1:Int64);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PartiesCatalogueSvc.DeletePartyID', req);  
end;


class function TPartiesCatalogueSvc.PartiesOfYearMonth(Year:Integer; Month:Integer):TArray<TParty2>;
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Year', Year);   SuperObject_SetField(req, 'Month', Month); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesCatalogueSvc.PartiesOfYearMonth', req, Result);   
end;


class function TPartiesCatalogueSvc.Party(param1:Int64):TParty1;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesCatalogueSvc.Party', req, Result);   
end;


class procedure TPartiesCatalogueSvc.SetProductsProduction(ProductIDs:TArray<Int64>; Production:Boolean);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'ProductIDs', ProductIDs);   SuperObject_SetField(req, 'Production', Production); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PartiesCatalogueSvc.SetProductsProduction', req);  
end;


class procedure TPartiesCatalogueSvc.ToggleProductProduction(param1:Int64);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PartiesCatalogueSvc.ToggleProductProduction', req);  
end;


class function TPartiesCatalogueSvc.YearsMonths:TArray<TYearMonth>;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PartiesCatalogueSvc.YearsMonths', req, Result);   
end;

 
class function TLastPartySvc.CalculateFonMinus20:TParty1;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.CalculateFonMinus20', req, Result);   
end;


class function TLastPartySvc.CalculateSensMinus20(param1:Double):TParty1;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.CalculateSensMinus20', req, Result);   
end;


class function TLastPartySvc.CalculateSensPlus50(param1:Double):TParty1;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.CalculateSensPlus50', req, Result);   
end;


class procedure TLastPartySvc.DeleteProductAtPlace(param1:Integer);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.DeleteProductAtPlace', req);  
end;


class function TLastPartySvc.GetCheckBlocks:TGetCheckBlocksArg;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.GetCheckBlocks', req, Result);   
end;


class function TLastPartySvc.GetValues:TParty3;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.GetValues', req, Result);   
end;


class function TLastPartySvc.Party:TParty1;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.Party', req, Result);   
end;


class function TLastPartySvc.PartyID:Int64;
var
    req : ISuperobject;
begin
    req := SO;
    
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.PartyID', req), Result);   
end;


class function TLastPartySvc.ProductAtPlace(param1:Integer):TProductInfo;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.ProductAtPlace', req, Result);   
end;


class procedure TLastPartySvc.SelectAll(param1:Boolean);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SelectAll', req);  
end;


class function TLastPartySvc.SelectOnlyOkProductsProduction:TParty1;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'LastPartySvc.SelectOnlyOkProductsProduction', req, Result);   
end;


class function TLastPartySvc.SetBlockChecked(param1:Integer; param2:Integer):Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1);   req.AsArray.Add(param2); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetBlockChecked', req), Result);   
end;


class function TLastPartySvc.SetPointsMethodInPlacesRange(Place1:Integer; Place2:Integer; Value:Integer):Int64;
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Place1', Place1);   SuperObject_SetField(req, 'Place2', Place2);   SuperObject_SetField(req, 'Value', Value); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetPointsMethodInPlacesRange', req), Result);   
end;


class function TLastPartySvc.SetProductNoteAtPlace(Place:Integer; Note:string):Int64;
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Place', Place);   SuperObject_SetField(req, 'Note', Note); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetProductNoteAtPlace', req), Result);   
end;


class function TLastPartySvc.SetProductSerialAtPlace(param1:Integer; param2:Integer):Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1);   req.AsArray.Add(param2); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetProductSerialAtPlace', req), Result);   
end;


class procedure TLastPartySvc.SetProductType(param1:string);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetProductType', req);  
end;


class function TLastPartySvc.SetProductTypeAtPlacesRange(Place1:Integer; Place2:Integer; ProductType:string):Int64;
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Place1', Place1);   SuperObject_SetField(req, 'Place2', Place2);   SuperObject_SetField(req, 'ProductType', ProductType); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetProductTypeAtPlacesRange', req), Result);   
end;


class procedure TLastPartySvc.SetValues(P:TParty3);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      TgoBsonSerializer.serialize(P, s); req['P'] := SO(s); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.SetValues', req);  
end;


class function TLastPartySvc.ToggleProductProductionAtPlace(param1:Integer):Int64;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'LastPartySvc.ToggleProductProductionAtPlace', req), Result);   
end;

 
class function TProductTypesSvc.Gases:TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductTypesSvc.Gases', req, Result);   
end;


class function TProductTypesSvc.Names:TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductTypesSvc.Names', req, Result);   
end;


class function TProductTypesSvc.Units:TArray<string>;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductTypesSvc.Units', req, Result);   
end;

 
class function TPlaceFirmware.CalculateFirmwareByProductType(ProductTypeName:string; Place:Integer; Serial:Integer):TFirmwareInfo;
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'ProductTypeName', ProductTypeName);   SuperObject_SetField(req, 'Place', Place);   SuperObject_SetField(req, 'Serial', Serial); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PlaceFirmware.CalculateFirmwareByProductType', req, Result);   
end;


class function TPlaceFirmware.CalculateFirmwareInfo(param1:Int64):TFirmwareInfo;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PlaceFirmware.CalculateFirmwareInfo', req, Result);   
end;


class procedure TPlaceFirmware.RunReadPlaceFirmware(param1:Integer);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PlaceFirmware.RunReadPlaceFirmware', req);  
end;


class procedure TPlaceFirmware.RunWritePlaceFirmware(X:TFirmwareInfo2);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      TgoBsonSerializer.serialize(X, s); req['X'] := SO(s); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PlaceFirmware.RunWritePlaceFirmware', req);  
end;


class procedure TPlaceFirmware.SaveProductType(X:TFirmwareInfo2);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      TgoBsonSerializer.serialize(X, s); req['X'] := SO(s); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PlaceFirmware.SaveProductType', req);  
end;


class function TPlaceFirmware.StoredFirmwareInfo(param1:Int64):TFirmwareInfo;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PlaceFirmware.StoredFirmwareInfo', req, Result);   
end;


class function TPlaceFirmware.TempPoints(Values:TArray<string>):TTempPoints;
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Values', Values); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'PlaceFirmware.TempPoints', req, Result);   
end;

 
class procedure TRunnerSvc.CopyParty(param1:Int64);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.CopyParty', req);  
end;


class procedure TRunnerSvc.NewParty(Serials:TArray<Int64>);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Serials', Serials); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.NewParty', req);  
end;


class procedure TRunnerSvc.RunMain(param1:Boolean; param2:Boolean; param3:Boolean; param4:Boolean);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1);   req.AsArray.Add(param2);   req.AsArray.Add(param3);   req.AsArray.Add(param4); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunMain', req);  
end;


class procedure TRunnerSvc.RunReadAndSaveProductCurrents(Column:string; Gas:Integer; Temperature:Double);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      SuperObject_SetField(req, 'Column', Column);   SuperObject_SetField(req, 'Gas', Gas);   SuperObject_SetField(req, 'Temperature', Temperature); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunReadAndSaveProductCurrents', req);  
end;


class procedure TRunnerSvc.RunReadCurrent;
var
    req : ISuperobject;
begin
    req := SO;
    
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunReadCurrent', req);  
end;


class function TRunnerSvc.RunScript(param1:string):TRunScriptResult;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunScript', req, Result);   
end;


class procedure TRunnerSvc.RunSwitchGas(param1:Integer);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunSwitchGas', req);  
end;


class procedure TRunnerSvc.RunWritePartyFirmware;
var
    req : ISuperobject;
begin
    req := SO;
    
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.RunWritePartyFirmware', req);  
end;


class procedure TRunnerSvc.SkipDelay;
var
    req : ISuperobject;
begin
    req := SO;
    
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.SkipDelay', req);  
end;


class procedure TRunnerSvc.StopHardware;
var
    req : ISuperobject;
begin
    req := SO;
    
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'RunnerSvc.StopHardware', req);  
end;

 
class procedure TPdfSvc.RunPartyID(param1:Int64);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PdfSvc.RunPartyID', req);  
end;


class procedure TPdfSvc.RunProductID(param1:Int64);
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'PdfSvc.RunProductID', req);  
end;

 
class function TConfigSvc.GetConfig:TPublicAppConfig;
var
    req : ISuperobject;
begin
    req := SO;
    
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ConfigSvc.GetConfig', req, Result);   
end;


class function TConfigSvc.GetYAML:string;
var
    req : ISuperobject;
begin
    req := SO;
    
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ConfigSvc.GetYAML', req), Result);   
end;


class procedure TConfigSvc.SetConfig(C:TPublicAppConfig);
var
    req : ISuperobject;s:string;
begin
    req := SO;
      TgoBsonSerializer.serialize(C, s); req['C'] := SO(s); 
      ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ConfigSvc.SetConfig', req);  
end;


class function TConfigSvc.SetYAML(param1:string):string;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ConfigSvc.SetYAML', req), Result);   
end;

 
class function TProductsCatalogueSvc.ListProductsByNote(param1:string):TArray<TArray<TCell>>;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ListProductsByNote', req, Result);   
end;


class function TProductsCatalogueSvc.ListProductsByPartyID(param1:Integer):TArray<TArray<TCell>>;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ListProductsByPartyID', req, Result);   
end;


class function TProductsCatalogueSvc.ListProductsBySerial(param1:Integer):TArray<TArray<TCell>>;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ListProductsBySerial', req, Result);   
end;


class function TProductsCatalogueSvc.ProductByID(param1:Int64):TArray<TArray<TCell>>;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ProductByID', req, Result);   
end;


class function TProductsCatalogueSvc.ProductByIDHasFirmware(param1:Int64):Boolean;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       SuperObject_Get(ThttpRpcClient.GetResponse(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ProductByIDHasFirmware', req), Result);   
end;


class function TProductsCatalogueSvc.ProductCurrents(param1:Int64):TArray<TProductCurrent>;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ProductCurrents', req, Result);   
end;


class function TProductsCatalogueSvc.ProductInfoByID(param1:Int64):TProductInfo;
var
    req : ISuperobject;
begin
    req := SA([]);
      req.AsArray.Add(param1); 
       ThttpRpcClient.Call(GetHttpServerAddr + '/rpc', 'ProductsCatalogueSvc.ProductInfoByID', req, Result);   
end;

 
end.