// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program elcoui;

uses
  JclDebug,
  Vcl.Forms,
  winapi.windows,
  UnitElcoMainForm in 'UnitElcoMainForm.pas' {ElcoMainForm},
  dbutils in 'utils\dbutils.pas',
  stringutils in 'utils\stringutils.pas',
  product_column in 'product_column.pas',
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
  listports in 'utils\listports.pas',
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
  Grijjy.BinaryCoding in 'grijjy\Grijjy.BinaryCoding.pas',
  Grijjy.Bson in 'grijjy\Grijjy.Bson.pas',
  Grijjy.Bson.Serialization in 'grijjy\Grijjy.Bson.Serialization.pas',
  Grijjy.Console in 'grijjy\Grijjy.Console.pas',
  Grijjy.DateUtils in 'grijjy\Grijjy.DateUtils.pas',
  Grijjy.Hash in 'grijjy\Grijjy.Hash.pas',
  Grijjy.Hooking in 'grijjy\Grijjy.Hooking.pas',
  Grijjy.Http in 'grijjy\Grijjy.Http.pas',
  Grijjy.JWT in 'grijjy\Grijjy.JWT.pas',
  Grijjy.MemoryPool in 'grijjy\Grijjy.MemoryPool.pas',
  Grijjy.PropertyBag in 'grijjy\Grijjy.PropertyBag.pas',
  Grijjy.SocketPool.Win in 'grijjy\Grijjy.SocketPool.Win.pas',
  Grijjy.System in 'grijjy\Grijjy.System.pas',
  Grijjy.SysUtils in 'grijjy\Grijjy.SysUtils.pas',
  Grijjy.Uri in 'grijjy\Grijjy.Uri.pas',
  Grijjy.Winsock2 in 'grijjy\Grijjy.Winsock2.pas',
  Grijjy.OpenSSL.API in 'grijjy\Grijjy.OpenSSL.API.pas',
  SuperObjectHelp in 'utils\SuperObjectHelp.pas',
  UnitFormProductTypeDialog in 'UnitFormProductTypeDialog.pas' {FormProductTypeDialog},
  Grijjy.Bson.IO in 'grijjy\Grijjy.Bson.IO.pas',
  Grijjy.Collections in 'grijjy\Grijjy.Collections.pas',
  Grijjy.OpenSSL in 'grijjy\Grijjy.OpenSSL.pas',
  UnitFormAppConfig in 'UnitFormAppConfig.pas' {FormAppConfig},
  UnitFormJournalParties in 'UnitFormJournalParties.pas' {FormJournalParties},
  UnitFormModalMessage in 'UnitFormModalMessage.pas' {FormModalMessage},
  UnitFormJournalProducts in 'UnitFormJournalProducts.pas' {FormJournalProducts},
  HttpClient in 'api\HttpClient.pas',
  HttpExceptions in 'api\HttpExceptions.pas',
  HttpRpcClient in 'api\HttpRpcClient.pas',
  UnitFormProductCurrents in 'UnitFormProductCurrents.pas' {FormProductCurrents},
  UnitFormFirmwareChart in 'UnitFormFirmwareChart.pas' {FormFirmwareChart};

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
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormParty, FormParty);
  Application.CreateForm(TFormFirmware, FormFirmware);
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
  Application.CreateForm(TFormAppConfig, FormAppConfig);
  Application.CreateForm(TFormJournalParties, FormJournalParties);
  Application.CreateForm(TFormModalMessage, FormModalMessage);
  Application.CreateForm(TFormJournalProducts, FormJournalProducts);
  Application.CreateForm(TFormProductCurrents, FormProductCurrents);
  Application.CreateForm(TFormFirmwareChart, FormFirmwareChart);
  Application.Run;

end.
