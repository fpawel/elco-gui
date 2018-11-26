program elcoui;

uses
  Vcl.Forms,
  UnitElcoMainForm in 'UnitElcoMainForm.pas' {ElcoMainForm},
  UnitDataModule1 in 'UnitDataModule1.pas' {DataModule1: TDataModule},
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
  UnitServerApp in 'UnitServerApp.pas' {ServerApp: TDataModule},
  server_data_types in 'data\server_data_types.pas',
  server_data_types_helpers in 'data\server_data_types_helpers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerApp, ServerApp);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TElcoMainForm, ElcoMainForm);
  Application.CreateForm(TFormParties, FormParties);
  Application.CreateForm(TFormLastParty, FormLastParty);
  Application.CreateForm(TFormParty, FormParty);
  Application.Run;
end.
