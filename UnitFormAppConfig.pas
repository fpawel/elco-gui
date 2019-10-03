unit UnitFormAppConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.Generics.collections,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    ComponentBaloonHintU, server_data_types;

type
    EWrongInputExcpetion = class(Exception);

    TFormAppConfig = class(TForm)
    GroupBox3: TGroupBox;
    GridPanel3: TGridPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Editfon20Min: TEdit;
    Editfon20Max: TEdit;
    Label17: TLabel;
    EditDfon20Max: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    EditKch20Min: TEdit;
    EditKch20Max: TEdit;
    Label20: TLabel;
    EditKch50Min: TEdit;
    EditKch50Max: TEdit;
    Label21: TLabel;
    EditDfon50Min: TEdit;
    EditDfon50Max: TEdit;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GridPanel1: TGridPanel;
    Label15: TLabel;
    ComboBoxComportProducts: TComboBox;
    Label1: TLabel;
    EditAmbientTemp: TEdit;
    Label13: TLabel;
    EditDurMinutesBlowGas: TEdit;
    EditDurMinutesHoldTemperature: TEdit;
    Label16: TLabel;
    Label2: TLabel;
    ComboBoxComportGas: TComboBox;
    Label9: TLabel;
    ComboBoxChipType: TComboBox;
    GroupBox2: TGroupBox;
    GridPanel2: TGridPanel;
    Label3: TLabel;
    ComboBoxProductTypeName: TComboBox;
    Label4: TLabel;
    EditC1: TEdit;
    Label5: TLabel;
    EditC2: TEdit;
    Label7: TLabel;
    EditC3: TEdit;
    Label8: TLabel;
    Label6: TLabel;
    ComboBoxPointsMethod: TComboBox;
    ComboBoxEndScaleGas: TComboBox;
    Label22: TLabel;
    EditNotMeasuredMax: TEdit;
    GroupBox4: TGroupBox;
    Memo1: TMemo;
    TimerDebounceParty: TTimer;
        procedure FormCreate(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure ComboBoxComportProductsChange(Sender: TObject);
        procedure ComboBoxProductTypeNameChange(Sender: TObject);
    procedure TimerDebouncePartyTimer(Sender: TObject);
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

        function TryEdToInt(ed: TEdit): Integer;
        function TryEdToFloat(ed: TEdit): double;
        function TryEdToNullFloat(ed: TEdit): TNullFloat64;

    public
        { Public declarations }
    end;

var
    FormAppConfig: TFormAppConfig;

implementation

{$R *.dfm}

uses registry,  stringutils, services;

procedure EnumComports(const Ports: TStrings);
var
    nInd: integer;
begin
    with TRegistry.Create(KEY_READ) do
        try
            RootKey := HKEY_LOCAL_MACHINE;
            if OpenKey('hardware\devicemap\serialcomm', false) then
            begin
                Ports.BeginUpdate();
                GetValueNames(Ports);
                for nInd := Ports.count - 1 downto 0 do
                    Ports.Strings[nInd] := ReadString(Ports.Strings[nInd]);
            end;

        finally
            Ports.EndUpdate();
            CloseKey();
            Free();
        end
end;

procedure setupCB(cb: TComboBox; s: string);
begin
    cb.ItemIndex := cb.Items.IndexOf(s);
end;

procedure setNullFloatEd(ed: TEdit; v: TNullFloat64);
begin
    if v.Valid = true then
        ed.Text := FloatToStr(v.Float64)
    else
        ed.Text := '';
end;

procedure TFormAppConfig.FormCreate(Sender: TObject);
begin
    FEnableOnEdit := false;
end;

procedure TFormAppConfig.FormShow(Sender: TObject);
var
    s: string;
    v: TGuiSettings;
    p: TParty3;

begin
    FEnableOnEdit := false;
    ComboBoxProductTypeName.Items.Clear;
    for s in TProductTypesSvc.Names do
        ComboBoxProductTypeName.Items.Add(s);
    EnumComports(ComboBoxComportProducts.Items);
    EnumComports(ComboBoxComportGas.Items);
    v := TConfigSvc.GetGui;

    setupCB(ComboBoxComportProducts, v.ComportMeasurer);
    setupCB(ComboBoxComportGas, v.ComportGas);
    setupCB(ComboBoxChipType, v.ChipType);
    EditAmbientTemp.Text := FloatToStr(v.AmbientTemperature);
    EditDurMinutesBlowGas.Text := IntToStr(v.BlowGasMinutes);
    EditDurMinutesHoldTemperature.Text := IntToStr(v.HoldTemperatureMinutes);
    if v.EndScaleGas2 = true then
        setupCB(ComboBoxEndScaleGas, 'ПГС2')
    else
        setupCB(ComboBoxEndScaleGas, 'ПГС3');


    p := TLastPartySvc.GetValues;
    setupCB(ComboBoxProductTypeName, p.ProductTypeName);
    EditC1.Text := FloatToStr(p.Concentration1);
    EditC2.Text := FloatToStr(p.Concentration2);
    EditC3.Text := FloatToStr(p.Concentration3);
    if p.PointsMethod = 2 then
        setupCB(ComboBoxPointsMethod, '2 точки')
    else
        setupCB(ComboBoxPointsMethod, '3 точки');

    setNullFloatEd(Editfon20Min, p.MinFon);
    setNullFloatEd(Editfon20Max, p.MaxFon);
    setNullFloatEd(EditDfon20Max, p.MaxDFon);
    setNullFloatEd(EditDfon50Min, p.MinDTemp);
    setNullFloatEd(EditDfon50Max, p.MaxDTemp);

    setNullFloatEd(EditKch20Min, p.MinKSens20);
    setNullFloatEd(EditKch20Max, p.MaxKSens20);
    setNullFloatEd(EditKch50Min, p.MinKSens50);
    setNullFloatEd(EditKch50Max, p.MaxKSens50);
    setNullFloatEd(EditNotMeasuredMax, p.MaxDNotMeasured);

    if p.Note.Valid = true then
        Memo1.Lines.Text := p.Note.Str
    else
        Memo1.Lines.Text := '';
    FEnableOnEdit := true;
end;

procedure TFormAppConfig.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormAppConfig.ComboBoxProductTypeNameChange(Sender: TObject);
begin
    if not FEnableOnEdit then
        exit;
    CloseWindow(FhWndTip);
    (Sender as TWinControl).SetFocus;
    if Sender <> ComboBoxProductTypeName then
    begin
        TimerDebounceParty.Enabled := true;
        exit;
    end;
    TLastPartySvc.SetProductType(ComboBoxProductTypeName.Text);
    FormShow(self);
end;

procedure TFormAppConfig.ComboBoxComportProductsChange(Sender: TObject);
var
    v: TGuiSettings;
begin
    if not FEnableOnEdit then
        exit;
    CloseWindow(FhWndTip);

    try
        v.ComportMeasurer := ComboBoxComportProducts.Text;
        v.ComportGas := ComboBoxComportGas.Text;
        v.BlowGasMinutes := TryEdToInt(EditDurMinutesBlowGas);
        v.HoldTemperatureMinutes := TryEdToInt(EditDurMinutesHoldTemperature);
        v.ChipType := ComboBoxChipType.Text;
        v.AmbientTemperature := TryEdToFloat(EditAmbientTemp);
        v.EndScaleGas2 := ComboBoxEndScaleGas.ItemIndex = 0;
        TConfigSvc.SetGui(v);
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

function TFormAppConfig.TryEdToInt(ed: TEdit): Integer;
begin
    if TryStrToInt(ed.Text, result) then
        exit(result);
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось целое число');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');


end;

procedure TFormAppConfig.TimerDebouncePartyTimer(Sender: TObject);
var
    p: TParty3;
begin
    TimerDebounceParty.Enabled := false;
    try
        p.ProductTypeName := ComboBoxProductTypeName.Text;
        p.Concentration1 := TryEdToFloat(EditC1);
        p.Concentration2 := TryEdToFloat(EditC2);
        p.Concentration3 := TryEdToFloat(EditC3);

        if ComboBoxPointsMethod.ItemIndex = 1 then
            p.PointsMethod := 3
        else
            p.PointsMethod := 2;

        p.MinFon := TryEdToNullFloat(Editfon20Min);
        p.MaxFon := TryEdToNullFloat(Editfon20Max);
        p.MaxDFon := TryEdToNullFloat(Editdfon20Max);
        p.MinDTemp := TryEdToNullFloat(EditDfon50Min);
        p.MaxDTemp := TryEdToNullFloat(EditDfon50Max);

        p.MinKSens20 := TryEdToNullFloat(EditKch20Min);
        p.MaxKSens20 := TryEdToNullFloat(EditKch20Max);

        p.MinKSens50 := TryEdToNullFloat(EditKch50Min);
        p.MaxKSens50 := TryEdToNullFloat(EditKch50Max);
        p.MaxDNotMeasured := TryEdToNullFloat(EditNotMeasuredMax);

        with p.Note do
        begin
            Valid := length(Trim(Memo1.Lines.Text)) > 0;
            Str := Memo1.Lines.Text;
        end;

        TLastPartySvc.SetValues(p);
    except
        on EWrongInputExcpetion do
            exit;
    end;

end;

function TFormAppConfig.TryEdToFloat(ed: TEdit): double;
begin
    if try_str_to_float(ed.Text, result) then
        exit(result);
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось число c плавающей точкой');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');

end;

function TFormAppConfig.TryEdToNullFloat(ed: TEdit): TNullFloat64;
begin
    result.Valid := try_str_to_float(ed.Text, result.Float64);
    if result.Valid = true then
        exit;
    if length(Trim(ed.Text))=0 then
        exit;
    ShowBalloonTip(ed, TIconKind.Error, 'не допустимое значение',
      'ожидалось число c плавающей точкой или пустая строка');
    ed.SetFocus;
    raise EWrongInputExcpetion.Create('');

end;

end.
