program elcoui;

uses
  Vcl.Forms,
  UnitElcoMainForm in 'UnitElcoMainForm.pas' {ElcoMainForm},
  dbutils in 'utils\dbutils.pas',
  stringgridutils in 'utils\stringgridutils.pas',
  stringutils in 'utils\stringutils.pas',
  product_column in 'ViewModels\product_column.pas',
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
  pipe in 'utils\pipe.pas',
  server_data_types in 'api\server_data_types.pas',
  server_data_types_helpers in 'api\server_data_types_helpers.pas',
  services in 'api\services.pas',
  UnitFormFirmware in 'UnitFormFirmware.pas' {FormFirmware},
  config_helpers in 'api\config_helpers.pas',
  PropertyValueEditors in 'PropertyValueEditors.pas',
  listports in 'utils\listports.pas',
  PropertiesFormUnit in 'PropertiesFormUnit.pas' {PropertiesForm},
  notify_services in 'api\notify_services.pas',
  ComponentBaloonHintU in 'utils\ComponentBaloonHintU.pas',
  UnitFormEditText in 'UnitFormEditText.pas' {FormEditText},
  UnitFormSelectTemperaturesDialog in 'UnitFormSelectTemperaturesDialog.pas' {FormSelectTemperaturesDialog},
  UnitFormSelectStendPlacesDialog in 'UnitFormSelectStendPlacesDialog.pas' {FormSelectStendPlacesDialog},
  richeditutils in 'utils\richeditutils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TElcoMainForm, ElcoMainForm);
  Application.CreateForm(TFormParties, FormParties);
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormParty, FormParty);
  Application.CreateForm(TFormFirmware, FormFirmware);
  Application.CreateForm(TPropertiesForm, PropertiesForm);
  Application.CreateForm(TFormEditText, FormEditText);
  Application.CreateForm(TFormSelectTemperaturesDialog, FormSelectTemperaturesDialog);
  Application.CreateForm(TFormSelectStendPlacesDialog, FormSelectStendPlacesDialog);
  Application.Run;
end.
