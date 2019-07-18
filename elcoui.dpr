program elcoui;

uses
  Vcl.Forms,
  winapi.windows,
  UnitElcoMainForm in 'UnitElcoMainForm.pas' {ElcoMainForm},
  dbutils in 'utils\dbutils.pas',
  stringutils in 'utils\stringutils.pas',
  product_column in 'product_column.pas',
  UnitFormParties in 'UnitFormParties.pas' {FormParties},
  UnitFormLastParty in 'UnitFormLastParty.pas' {FormLastParty},
  UnitFormParty in 'UnitFormParty.pas' {FormParty},
  vclutils in 'utils\vclutils.pas',
  ujsonrpc in 'utils\jsonrpc\ujsonrpc.pas',
  superdate in 'utils\superobject\superdate.pas',
  superobject in 'utils\superobject\superobject.pas',
  supertimezone in 'utils\superobject\supertimezone.pas',
  supertypes in 'utils\superobject\supertypes.pas',
  superxmlparser in 'utils\superobject\superxmlparser.pas',
  server_data_types in 'api\server_data_types.pas',
  server_data_types_helpers in 'api\server_data_types_helpers.pas',
  services in 'api\services.pas',
  UnitFormFirmware in 'UnitFormFirmware.pas' {FormFirmware},
  config_helpers in 'api\config_helpers.pas',
  PropertyValueEditors in 'PropertyValueEditors.pas',
  listports in 'utils\listports.pas',
  UnitFormProperties in 'UnitFormProperties.pas' {FormProperties},
  notify_services in 'api\notify_services.pas',
  ComponentBaloonHintU in 'utils\ComponentBaloonHintU.pas',
  UnitFormEditText in 'UnitFormEditText.pas' {FormEditText},
  UnitFormSelectTemperaturesDialog in 'UnitFormSelectTemperaturesDialog.pas' {FormSelectTemperaturesDialog},
  UnitFormSelectStendPlacesDialog in 'UnitFormSelectStendPlacesDialog.pas' {FormSelectStendPlacesDialog},
  richeditutils in 'utils\richeditutils.pas',
  exn in 'exn.pas',
  stringgridutils in 'utils\stringgridutils.pas',
  parproc in 'utils\parproc.pas',
  UnitFormSelectBlock in 'UnitFormSelectBlock.pas' {FormSelectBlock},
  UnitFormSelectProducts in 'UnitFormSelectProducts.pas' {FormSelectProducts},
  UnitFormInterrogate in 'UnitFormInterrogate.pas' {FormInterrogate},
  UnitFormConsole in 'UnitFormConsole.pas' {FormConsole},
  UnitFormPopup in 'UnitFormPopup.pas' {FormPopup},
  UnitFormKtx500 in 'UnitFormKtx500.pas' {FormKtx500},
  Grijjy.BinaryCoding in '..\..\grijjy\GrijjyFoundation\Grijjy.BinaryCoding.pas',
  Grijjy.Bson.IO in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.IO.pas',
  Grijjy.Bson in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.pas',
  Grijjy.Bson.Path in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.Path.pas',
  Grijjy.Bson.Serialization in '..\..\grijjy\GrijjyFoundation\Grijjy.Bson.Serialization.pas',
  Grijjy.Collections in '..\..\grijjy\GrijjyFoundation\Grijjy.Collections.pas',
  Grijjy.Console in '..\..\grijjy\GrijjyFoundation\Grijjy.Console.pas',
  Grijjy.DateUtils in '..\..\grijjy\GrijjyFoundation\Grijjy.DateUtils.pas',
  Grijjy.Hash in '..\..\grijjy\GrijjyFoundation\Grijjy.Hash.pas',
  Grijjy.Hooking in '..\..\grijjy\GrijjyFoundation\Grijjy.Hooking.pas',
  Grijjy.Http in '..\..\grijjy\GrijjyFoundation\Grijjy.Http.pas',
  Grijjy.JWT in '..\..\grijjy\GrijjyFoundation\Grijjy.JWT.pas',
  Grijjy.MemoryPool in '..\..\grijjy\GrijjyFoundation\Grijjy.MemoryPool.pas',
  Grijjy.PropertyBag in '..\..\grijjy\GrijjyFoundation\Grijjy.PropertyBag.pas',
  Grijjy.SocketPool.Win in '..\..\grijjy\GrijjyFoundation\Grijjy.SocketPool.Win.pas',
  Grijjy.System in '..\..\grijjy\GrijjyFoundation\Grijjy.System.pas',
  Grijjy.SysUtils in '..\..\grijjy\GrijjyFoundation\Grijjy.SysUtils.pas',
  Grijjy.Uri in '..\..\grijjy\GrijjyFoundation\Grijjy.Uri.pas',
  Grijjy.Winsock2 in '..\..\grijjy\GrijjyFoundation\Grijjy.Winsock2.pas',
  Grijjy.OpenSSL in '..\..\grijjy\GrijjyFoundation\Grijjy.OpenSSL.pas',
  Grijjy.OpenSSL.API in '..\..\grijjy\GrijjyFoundation\Grijjy.OpenSSL.API.pas',
  HttpRpcClient in 'utils\HttpRpcClient.pas',
  SuperObjectHelp in 'utils\SuperObjectHelp.pas',
  UnitFormProductTypeDialog in 'UnitFormProductTypeDialog.pas' {FormProductTypeDialog};

{$R *.res}

var
    hWnd: THandle;

begin
    hWnd := FindWindow('TElcoMainForm', nil);
    if hWnd <> 0 then // prevent application from running twice
    begin
        ShowWindow(hWnd, SW_RESTORE);
        SetForegroundWindow(hWnd);
        exit;
    end;
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TElcoMainForm, ElcoMainForm);
  Application.CreateForm(TFormParties, FormParties);
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormParty, FormParty);
  Application.CreateForm(TFormFirmware, FormFirmware);
  Application.CreateForm(TFormProperties, FormProperties);
  Application.CreateForm(TFormEditText, FormEditText);
  Application.CreateForm(TFormSelectTemperaturesDialog, FormSelectTemperaturesDialog);
  Application.CreateForm(TFormSelectStendPlacesDialog, FormSelectStendPlacesDialog);
  Application.CreateForm(TFormSelectBlock, FormSelectBlock);
  Application.CreateForm(TFormSelectBlock, FormSelectBlock);
  Application.CreateForm(TFormSelectProducts, FormSelectProducts);
  Application.CreateForm(TFormInterrogate, FormInterrogate);
  Application.CreateForm(TFormConsole, FormConsole);
  Application.CreateForm(TFormPopup, FormPopup);
  Application.CreateForm(TFormKtx500, FormKtx500);
  Application.CreateForm(TFormProductTypeDialog, FormProductTypeDialog);
  Application.Run;

end.
