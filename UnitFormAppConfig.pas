unit UnitFormAppConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    ComponentBaloonHintU;

type
    EWrongInputExcpetion = class(Exception);

    TFormAppConfig = class(TForm)
    GroupBox3: TGroupBox;
    GridPanel3: TGridPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Edit7: TEdit;
    Edit10: TEdit;
    Label17: TLabel;
    Edit11: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Edit12: TEdit;
    Edit13: TEdit;
    Label20: TLabel;
    Edit14: TEdit;
    Edit15: TEdit;
    Label21: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GridPanel1: TGridPanel;
    Label15: TLabel;
    ComboBoxComportProducts: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label13: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label16: TLabel;
    Label2: TLabel;
    ComboBoxComportGas: TComboBox;
    Label9: TLabel;
    ComboBox3: TComboBox;
    GroupBox2: TGroupBox;
    GridPanel2: TGridPanel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    ComboBox2: TComboBox;
        procedure FormCreate(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ComboBoxComportProductsChange(Sender: TObject);
        procedure ComboBoxProductTypeNameChange(Sender: TObject);
    private
        { Private declarations }
        FhWndTip: THandle;
        FEnableOnEdit: boolean;
        procedure WMWindowPosChanged(var AMessage: TMessage);
          message WM_WINDOWPOSCHANGED;
        procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;

        procedure WMActivateApp(var AMessage: TMessage); message WM_ACTIVATEAPP;
        procedure ShowBalloonTip(c: TWinControl; Icon: TIconKind;
          Title, Text: string);

        function TryEditToInt(ed: TEdit): Integer;
        function TryEditToFloat(ed: TEdit): double;

    public
        { Public declarations }
    end;

var
    FormAppConfig: TFormAppConfig;

implementation

{$R *.dfm}

uses stringutils, services, server_data_types, comport;

procedure setupCB(cb: TComboBox; s: string);
begin
    cb.ItemIndex := cb.Items.IndexOf(s);
end;

procedure TFormAppConfig.FormCreate(Sender: TObject);
begin
    FEnableOnEdit := false;
end;

procedure TFormAppConfig.FormShow(Sender: TObject);
var
    s: string;
    v: TUserConfig;

    p: TParty;

begin
    FEnableOnEdit := false;
    ComboBoxProductTypeName.Items.Clear;
    for s in TConfigSvc.ProductTypesNames do
        ComboBoxProductTypeName.Items.Add(s);
    EnumComports(ComboBoxComportProducts.Items);
    EnumComports(ComboBoxComportTemp.Items);
    EnumComports(ComboBoxComportGas.Items);
    v := TConfigSvc.UserAppSetts;

    setupCB(ComboBoxComportProducts, v.ComportProducts);
    setupCB(ComboBoxComportTemp, v.ComportTemperature);
    setupCB(ComboBoxComportGas, v.ComportGas);

    EditDurMinutesBlowGas.Text := IntToStr(v.BlowGasMinutes);
    EditDurMinutesBlowAir.Text := IntToStr(v.BlowAirMinutes);
    EditDurMinutesHoldT.Text := IntToStr(v.HoldTemperatureMinutes);
    EditTempMinus.Text := FloatToStr(v.TemperatureMinus);
    EditTempPlus.Text := FloatToStr(v.TemperaturePlus);

    EditInterrogateInerval.Text := IntToStr(v.InterrogateProductVarIntervalMillis);

    p := TLastPartySvc.Party;
    setupCB(ComboBoxProductTypeName, p.ProductType);
    EditC1.Text := FloatToStr(p.C1);
    EditC2.Text := FloatToStr(p.C2);
    EditC3.Text := FloatToStr(p.C3);
    EditC4.Text := FloatToStr(p.C4);

    FEnableOnEdit := true;
end;

procedure TFormAppConfig.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormAppConfig.ComboBoxProductTypeNameChange(Sender: TObject);
var
    v: TPartySettings;
    x:TTempPlusMinus;
begin
    if not FEnableOnEdit then
        exit;
    CloseWindow(FhWndTip);
    try
        v.ProductType := ComboBoxProductTypeName.Text;
        v.C1 := TryEditToFloat(EditC1);
        v.C2 := TryEditToFloat(EditC2);
        v.C3 := TryEditToFloat(EditC3);
        v.C4 := TryEditToFloat(EditC4);

        CloseWindow(FhWndTip);
        TLastPartySvc.SetPartySettings(v);
        if Sender = ComboboxProductTypeName then
        with TConfigSvc.ProductTypeTemperatures(ComboboxProductTypeName.Text) do
        begin
            FEnableOnEdit := false;
            EditTempMinus.Text := floattostr(TempMinus);
            EditTempPlus.Text := floattostr(TempPlus);
            FEnableOnEdit := true;
            ComboBoxComportProductsChange(EditTempMinus);
        end;

        TLastPartySvc.SetPartySettings(v);

        (Sender as TWinControl).SetFocus;
    except
        on EWrongInputExcpetion do
            exit;
    end;

end;

procedure TFormAppConfig.ComboBoxComportProductsChange(Sender: TObject);
var
    v: TUserAppSettings;
begin
    if not FEnableOnEdit then
        exit;
    CloseWindow(FhWndTip);

    try
        v.ComportProducts := ComboBoxComportProducts.Text;
        v.ComportTemperature := ComboBoxComportTemp.Text;
        v.ComportGas := ComboBoxComportGas.Text;
        v.BlowGasMinutes := TryEditToInt(EditDurMinutesBlowGas);
        v.BlowAirMinutes := TryEditToInt(EditDurMinutesBlowAir);
        v.HoldTemperatureMinutes := TryEditToInt(EditDurMinutesHoldT);
        v.TemperatureMinus := TryEditToFloat(EditTempMinus);
        v.TemperaturePlus := TryEditToFloat(EditTempPlus);
        v.InterrogateProductVarIntervalMillis := TryEditToInt(EditInterrogateInerval);
        TConfigSvc.SetUserAppSetts(v);

        (Sender as TWinControl).SetFocus;
    except
        on EWrongInputExcpetion do
            exit;
    end;
end;

procedure TFormAppConfig.WMEnterSizeMove(var Msg: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormAppConfig.WMWindowPosChanged(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormAppConfig.WMActivateApp(var AMessage: TMessage);
begin
    CloseWindow(FhWndTip);
    inherited;
end;

procedure TFormAppConfig.ShowBalloonTip(c: TWinControl; Icon: TIconKind;
  Title, Text: string);
begin
    CloseWindow(FhWndTip);
    FhWndTip := ComponentBaloonHintU.ShowBalloonTip(c, Icon, Title, Text);
end;

function TFormAppConfig.TryEditToInt(ed: TEdit): Integer;
begin
    if TryStrToInt(ed.Text, result) then
        exit(result);
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось целое число');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');


end;

function TFormAppConfig.TryEditToFloat(ed: TEdit): double;
begin
    if try_str_to_float(ed.Text, result) then
        exit(result);
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось число c плавающей точкой');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');

end;

end.
