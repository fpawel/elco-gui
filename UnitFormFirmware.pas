unit UnitFormFirmware;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ExtCtrls, server_data_types, server_data_types_helpers,
    System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Grids, VclTee.TeeGDIPlus,
    VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, VclTee.Series,
    UnitFormLastParty, Vcl.Menus;

type
    TFormFirmware = class(TForm)
        ImageList3: TImageList;
        Panel1: TPanel;
        Panel2: TPanel;
        GroupBox2: TGroupBox;
        StringGrid2: TStringGrid;
        Panel5: TPanel;
        Panel4: TPanel;
        Label2: TLabel;
        Label1: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        EditSerial: TEdit;
        DateTimePicker1: TDateTimePicker;
        ComboBoxProductType: TComboBox;
        ComboBoxGas: TComboBox;
        Panel3: TPanel;
        Label6: TLabel;
        Label8: TLabel;
        Label7: TLabel;
        EditScaleBegin: TEdit;
        EditScaleEnd: TEdit;
        EditSensLab73: TEdit;
        EditSensProduct: TEdit;
        Label11: TLabel;
        ComboBoxUnits: TComboBox;
        Label5: TLabel;
        EditFon20: TEdit;
        Label10: TLabel;
        ToolBar1: TToolBar;
        ToolButton1: TToolButton;
        ToolButton2: TToolButton;
        ButtonWrite: TButton;
        Button2: TButton;
        Button3: TButton;
        Button1: TButton;
        Button4: TButton;
        PopupMenu1: TPopupMenu;
        MenuCalcProduct: TMenuItem;
        MenuUseSelectedProductType: TMenuItem;
        MenuSaveProductType: TMenuItem;
        Label9: TLabel;
        ComboBoxPlace: TComboBox;
        Label12: TLabel;
        N1: TMenuItem;
        N2: TMenuItem;
    Button5: TButton;
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid2MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure FormShow(Sender: TObject);
        procedure ComboBoxProductTypeDropDown(Sender: TObject);
        procedure ComboBoxGasDropDown(Sender: TObject);
        procedure ComboBoxUnitsDropDown(Sender: TObject);
        procedure LinkLabel1Click(Sender: TObject);
        procedure LinkLabel2Click(Sender: TObject);
        procedure ToolButton8Click(Sender: TObject);
        procedure ToolButton9Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure MenuCalcProductClick(Sender: TObject);
        procedure MenuUseSelectedProductTypeClick(Sender: TObject);
        procedure MenuSaveProductTypeClick(Sender: TObject);
        procedure ButtonWriteClick(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;

        FProduct: TProductInfo;

        procedure DrawCellText(text: string; ACnv: TCanvas; Rect: TRect;
          ta: TAlignment);

        procedure SetTemperaturePointsChart(ATemp: TArray<Double>;
          AFon: TArray<Double>; ASens: TArray<Double>);

        // procedure SetTemperaturePointsGrid(ATemp: TArray<Double>;
        // AFon: TArray<Double>; ASens: TArray<Double>);

        procedure SetTemperaturePointsGrid(AValues: TArray<string>);

        function GetTemperatureValues: TArray<string>;

        procedure ClearFirmwareInfo;

        procedure applyProduct;

        function GetTFirmwareInfo: TFirmwareInfo;

        procedure UploadTempPoints;

    public
        { Public declarations }
        procedure SetFirmwareInfo(f: TFirmwareInfo);
        procedure SetProduct(p: TProductInfo);

    end;

var
    FormFirmware: TFormFirmware;

implementation

{$R *.dfm}

uses System.Types, stringgridutils, stringutils, services, dateutils, math,
    UnitElcoMainForm, UnitFormFirmwareChart, UnitFormFirmwareBytes;

procedure TFormFirmware.FormCreate(Sender: TObject);
var
    s: string;
    i: Integer;
begin

    ComboBoxProductType.Items.Clear;
    ComboBoxUnits.Items.Clear;
    ComboBoxGas.Items.Clear;

    with StringGrid2 do
    begin
        Cells[0, RowCount - 1] := 'T⁰C';
        Cells[1, RowCount - 1] := 'Фон, нА';
        Cells[2, RowCount - 1] := 'Кч, %';
    end;

    for i := 0 to 95 do
        ComboBoxPlace.Items.Add(inttostr(i div 8 + 1) + '.' +
          inttostr(i mod 8 + 1));

end;

procedure TFormFirmware.FormShow(Sender: TObject);
begin
    //
end;

procedure TFormFirmware.StringGrid2DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    AGRd: TStringGrid;
    ACnv: TCanvas;
begin
    AGRd := Sender As TStringGrid;
    ACnv := AGRd.Canvas;
    ACnv.Font.Assign(AGRd.Font);

    if ARow = 0 then
        ACnv.Brush.Color := cl3DLight
    else if gdSelected in State then
        ACnv.Brush.Color := clGradientInactiveCaption
    else
        ACnv.Brush.Color := AGRd.Color;

    DrawCellText(AGRd.Cells[ACol, ARow], ACnv, Rect, taCenter);
    StringGrid_DrawCellBounds(ACnv, ACol, ARow, Rect);
end;

procedure TFormFirmware.StringGrid2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = mbRight then
        with StringGrid2 do
        begin
            if RowCount > 1 then
                Row := RowCount - 1;
        end;

end;

procedure TFormFirmware.StringGrid2SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
    // When selecting a cell
    with Sender as TStringGrid do
        if EditorMode then
        begin // It was a cell being edited
            EditorMode := false; // Deactivate the editor
            // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
            // This is to be able to use also the arrow-keys up and down in the Grid.
            if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
                StringGrid2SetEditText(Sender as TStringGrid, Last_Edited_Col,
                  Last_Edited_Row, Cells[Last_Edited_Col, Last_Edited_Row]);
            // Just make the call
        end;
    // Do whatever else wanted
end;

procedure TFormFirmware.StringGrid2SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: string);
begin
    With Sender as TStringGrid do
        // Fired on every change
        if Not EditorMode // goEditing must be 'True' in Options
        then
        begin // Only after user ends editing the cell
            Last_Edited_Col := -1; // Indicate no cell is edited
            Last_Edited_Row := -1; // Indicate no cell is edited

            // Do whatever wanted after user has finish editing a cell
            UploadTempPoints;

        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;
end;

procedure TFormFirmware.UploadTempPoints;
var
    tt: TTempPoints;
begin
    tt := TPlaceFirmware.CalculateTempPoints(GetTFirmwareInfo.TempValues);
    SetTemperaturePointsChart(tt.Temp, tt.Fon, tt.Sens);
    // FormFirmwareBytes.setup(f.Bytes);
end;

procedure TFormFirmware.ToolButton8Click(Sender: TObject);
var
    cl, ro: Integer;
begin
    with StringGrid2 do
    begin
        RowCount := RowCount + 1;
        if Row > 0 then
        begin
            for ro := RowCount - 1 downto Row do
                for cl := 0 to ColCount - 1 do
                    Cells[cl, ro + 1] := Cells[cl, ro];
            for cl := 0 to ColCount - 1 do
                Cells[cl, Row + 1] := '';
            Row := Row + 1;
        end;
    end;
    UploadTempPoints;
end;

procedure TFormFirmware.ToolButton9Click(Sender: TObject);
var
    cl, ro: Integer;
begin
    with StringGrid2 do
    begin
        if Row > 0 then
        begin
            for ro := Row to RowCount - 1 do
                for cl := 0 to ColCount - 1 do
                    Cells[cl, ro] := Cells[cl, ro + 1];
        end;
        RowCount := RowCount - 1;
    end;

    UploadTempPoints;
end;

procedure TFormFirmware.DrawCellText(text: string; ACnv: TCanvas; Rect: TRect;
  ta: TAlignment);
var
    X, Y, txt_width, txt_height: Integer;
begin
    // s := AGrd.Cells[ACol, ARow];
    with ACnv do
    begin

        if TextWidth(text) + 3 > Rect.Width then
            text := cut_str(text, ACnv, Rect.Width);
        txt_width := TextWidth(text);
        txt_height := TextHeight(text);
        X := Rect.Left + 3;
        if ta = taRightJustify then
            X := Rect.Right - 3 - round(txt_width)
        else if ta = taCenter then
            X := Rect.Left + round((Rect.Width - txt_width) / 2.0);
        Y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        TextRect(Rect, X, Y, text);
    end;
end;

procedure SetComboBoxText(X: TComboBox; AText: String);
begin
    X.text := AText;
    if X.text <> AText then
        X.ItemIndex := X.Items.IndexOf(AText);
end;

procedure correct_axis_oreders(ax: TChartAxis; min_v, max_v: Double);
var
    d_ax: Double;
begin
    if min_v = max_v then
        d_ax := 1
    else
        d_ax := (max_v - min_v) * 0.1;
    ax.SetMinMax(min_v - d_ax, max_v + d_ax);
end;

procedure TFormFirmware.ButtonWriteClick(Sender: TObject);
begin
    TPlaceFirmware.RunWritePlaceFirmware(GetTFirmwareInfo,
      ComboBoxPlace.ItemIndex, ComboBoxPlace.ItemIndex);
end;

procedure TFormFirmware.Button1Click(Sender: TObject);
begin
    TPlaceFirmware.RunWritePlaceFirmware(GetTFirmwareInfo, 0,
      ComboBoxPlace.ItemIndex);
end;

procedure TFormFirmware.Button2Click(Sender: TObject);
begin
    TPlaceFirmware.RunReadPlaceFirmware(ComboBoxPlace.ItemIndex);
end;

procedure TFormFirmware.Button3Click(Sender: TObject);
var
    productType: string;
begin
    MenuCalcProduct.Visible := FProduct.ProductID <> 0;
    MenuCalcProduct.Caption := Format('Расчёт по данным ЭХЯ %d',
      [FProduct.ProductID]);

    if ComboBoxProductType.text = '' then
        ComboBoxProductType.text := FProduct.AppliedProductTypeName;

    if ComboBoxProductType.text = '' then
        ComboBoxProductType.text := TLastPartySvc.GetValues.ProductTypeName;

    if EditSerial.text = '' then
        EditSerial.text := FProduct.Serial.Str;

    MenuUseSelectedProductType.Caption := 'Использовать данные исполнения ' +
      ComboBoxProductType.text;
    MenuSaveProductType.Caption := 'Сохранить для исполнения ' +
      ComboBoxProductType.text;

    with Mouse.CursorPos do
        (Sender as TButton).PopupMenu.Popup(X, Y);
end;

procedure TFormFirmware.Button4Click(Sender: TObject);
begin
    TPlaceFirmware.RunReadPlaceFirmware(0);
end;

procedure TFormFirmware.Button5Click(Sender: TObject);
begin
    try
        ElcoMainForm.Hide;
        FormFirmwareBytes.SetupBytes
          (TPlaceFirmware.GetFirmwareBytes(GetTFirmwareInfo));

        FormFirmwareBytes.ShowModal;
        if FormFirmwareBytes.ModalResult = mrOk then
            SetFirmwareInfo(TPlaceFirmware.SetFirmwareBytes
              (FormFirmwareBytes.Getbytes));
    finally
        ElcoMainForm.Show;

    end;
end;

procedure TFormFirmware.MenuCalcProductClick(Sender: TObject);
begin
    SetFirmwareInfo(TPlaceFirmware.CalculatedProductFirmware
      (FProduct.ProductID));
end;

procedure TFormFirmware.ClearFirmwareInfo;
begin
    DateTimePicker1.DateTime := 0;
    EditSerial.text := '';
    EditSensProduct.text := '';
    EditSensLab73.text := '';
    EditScaleBegin.text := '';
    EditScaleEnd.text := '';
    EditFon20.text := '';

    SetComboBoxText(ComboBoxProductType, '');
    SetComboBoxText(ComboBoxUnits, '');
    SetComboBoxText(ComboBoxGas, '');
    FormFirmwareChart.Series1.Clear;
    FormFirmwareChart.Series2.Clear;
    StringGrid_Clear(StringGrid2);
end;

procedure TFormFirmware.ComboBoxGasDropDown(Sender: TObject);
var
    Str, s: string;
begin
    Str := ComboBoxGas.text;
    ComboBoxGas.Items.Clear;
    for s in TProductTypesSvc.Gases do
        ComboBoxGas.Items.Add(s);
    ComboBoxGas.ItemIndex := ComboBoxGas.Items.IndexOf(Str);
end;

procedure TFormFirmware.ComboBoxProductTypeDropDown(Sender: TObject);
var
    Str, s: string;
begin
    Str := ComboBoxProductType.text;
    ComboBoxProductType.Items.Clear;
    for s in TProductTypesSvc.Names do
        ComboBoxProductType.Items.Add(s);
    ComboBoxProductType.ItemIndex := ComboBoxProductType.Items.IndexOf(Str);

end;

procedure TFormFirmware.ComboBoxUnitsDropDown(Sender: TObject);
var
    Str, s: string;
begin
    Str := ComboBoxUnits.text;
    ComboBoxUnits.Items.Clear;
    for s in TProductTypesSvc.Units do
        ComboBoxUnits.Items.Add(s);
    ComboBoxUnits.ItemIndex := ComboBoxUnits.Items.IndexOf(Str);
end;

procedure TFormFirmware.SetFirmwareInfo(f: TFirmwareInfo);
var
    i: Integer;
    has_null: Boolean;
    Temp: Double;
    s: string;
begin

    ComboBoxUnits.Items.Clear;
    ComboBoxGas.Items.Clear;
    for s in TProductTypesSvc.Gases do
        ComboBoxGas.Items.Add(s);
    for s in TProductTypesSvc.Units do
        ComboBoxUnits.Items.Add(s);

    DateTimePicker1.DateTime := EncodeDatetime(f.Year, f.Month, f.Day, f.Hour,
      f.Minute, f.Second, 0);
    EditSerial.text := f.Serial;
    EditSensProduct.text := f.SensitivityProduct;
    EditSensLab73.text := f.SensitivityLab73;
    EditScaleBegin.text := f.ScaleBeg;
    EditScaleEnd.text := f.ScaleEnd;
    EditFon20.text := f.Fon20;

    SetComboBoxText(ComboBoxProductType, f.productType);
    SetComboBoxText(ComboBoxUnits, f.Units);
    SetComboBoxText(ComboBoxGas, f.Gas);
    SetTemperaturePointsChart(f.ProductTempPoints.Temp, f.ProductTempPoints.Fon,
      f.ProductTempPoints.Sens);
    SetTemperaturePointsGrid(f.TempValues);

end;

function TFormFirmware.GetTemperatureValues: TArray<string>;
var
    n, i: Integer;
begin
    with StringGrid2 do
    begin
        SetLength(Result, 3 * (RowCount - 1));
        for i := 1 to RowCount - 1 do
        begin
            n := (i - 1) * 3;
            Result[n + 0] := Cells[0, i];
            Result[n + 1] := Cells[1, i];
            Result[n + 2] := Cells[2, i];
        end;
    end;

end;

procedure TFormFirmware.SetTemperaturePointsChart(ATemp: TArray<Double>;
  AFon: TArray<Double>; ASens: TArray<Double>);
var
    i: Integer;
begin
    FormFirmwareChart.Caption := Format('График ЭХЯ %d - ',
      [FProduct.ProductID]);

    FormFirmwareChart.Series1.Clear;
    FormFirmwareChart.Series2.Clear;
    for i := 0 to length(ATemp) - 1 do
    begin
        FormFirmwareChart.Series1.AddXY(ATemp[i], AFon[i]);
        FormFirmwareChart.Series2.AddXY(ATemp[i], ASens[i]);
    end;
    correct_axis_oreders(FormFirmwareChart.Chart1.BottomAxis, -125, 125);
    correct_axis_oreders(FormFirmwareChart.Chart1.LeftAxis,
      FormFirmwareChart.Series1.MinYValue, FormFirmwareChart.Series1.MaxYValue);
    correct_axis_oreders(FormFirmwareChart.Chart1.RightAxis,
      FormFirmwareChart.Series2.MinYValue, FormFirmwareChart.Series2.MaxYValue);

end;

procedure TFormFirmware.SetTemperaturePointsGrid(AValues: TArray<string>);
var
    i: Integer;
    has_null: Boolean;
begin
    with StringGrid2 do
    begin
        RowCount := 1;
        i := 0;
        while i < length(AValues) - 1 do
        begin
            RowCount := RowCount + 1;
            Cells[0, RowCount - 1] := AValues[i];
            Cells[1, RowCount - 1] := AValues[i + 1];
            Cells[2, RowCount - 1] := AValues[i + 2];
            FixedRows := 1;
            Inc(i, 3);
        end;
    end;
end;

// procedure TFormFirmware.SetTemperaturePointsGrid(ATemp: TArray<Double>;
// AFon: TArray<Double>; ASens: TArray<Double>);
// var
// i: Integer;
// has_null: Boolean;
// begin
// StringGrid2.RowCount := 1;
// has_null := false;
// for i := 0 to length(ATemp) - 1 do
// begin
// if is_main_temperature(ATemp[i]) then
// with StringGrid2 do
// begin
// if (ATemp[i] = 0) then
// begin
// if has_null then
// continue;
// has_null := true;
// end;
//
// RowCount := RowCount + 1;
// Cells[0, RowCount - 1] := FloatToStr(ATemp[i]);
// Cells[1, RowCount - 1] := FloatToStr(AFon[i]);
// Cells[2, RowCount - 1] := FloatToStr(ASens[i]);
// FixedRows := 1;
// end;
// end;
//
// end;

procedure TFormFirmware.applyProduct;
begin

    Caption := 'Прошивка ЭХЯ ' + inttostr(FProduct.ProductID);
    if FProduct.HasFirmware = true then
        SetFirmwareInfo(TPlaceFirmware.StoredProductFirmware
          (FProduct.ProductID))
    else
    begin
        ClearFirmwareInfo;
        // FormFirmwareBytes.setup([]);
    end;
    ComboBoxPlace.ItemIndex := FProduct.Place;

end;

procedure TFormFirmware.SetProduct(p: TProductInfo);
begin
    FProduct := p;
    ComboBoxPlace.ItemIndex := p.Place;
    applyProduct;
end;

function TFormFirmware.GetTFirmwareInfo: TFirmwareInfo;
var
    t: TDateTime;
begin
    t := DateTimePicker1.DateTime;

    Result.Year := YearOf(t);
    Result.Month := MonthOf(t);
    Result.Day := DayOf(t);
    Result.Hour := HourOf(t);
    Result.Minute := MinuteOf(t);
    Result.Second := SecondOf(t);
    Result.SensitivityProduct := EditSensProduct.text;
    Result.SensitivityLab73 := EditSensLab73.text;
    Result.Serial := EditSerial.text;
    Result.productType := ComboBoxProductType.text;
    Result.Gas := ComboBoxGas.text;
    Result.Units := ComboBoxUnits.text;
    Result.ScaleBeg := EditScaleBegin.text;
    Result.ScaleEnd := EditScaleEnd.text;
    Result.TempValues := GetTemperatureValues;
    Result.Fon20 := EditFon20.text;
end;

procedure TFormFirmware.LinkLabel1Click(Sender: TObject);
var
    n, i: Integer;
    Temp, Ifon20, Isens20, Ifon, Isens, scale_end, scale_begin, scale: Double;
    f: Boolean;
begin
    if not TryStrToFloat2(EditScaleEnd.text, scale_end) then
        raise Exception.Create('Не задан конец шкалы');

    if not TryStrToFloat2(EditScaleBegin.text, scale_begin) then
        raise Exception.Create('Не задано начало шкалы');

    scale := scale_end - scale_begin;

    if scale = 0 then
        raise Exception.Create('Шкала не должна быть нулевой');

    with StringGrid2 do
    begin
        f := false;
        for i := 1 to RowCount - 1 do
        begin
            if (TryStrToFloat2(Cells[0, i], Temp)) and (Temp = 20) and
              (TryStrToFloat2(Cells[1, i], Ifon20)) and
              (TryStrToFloat2(Cells[2, i], Isens20)) then
            begin
                f := true;
                break;
            end;
        end;
        if not f then
            raise Exception.Create('Не заданы токи при 20"С');

        if Isens20 = Ifon20 then
            raise Exception.Create
              ('Фоновый ток при 20"С не должен быть равен току чувствительности при 20"С');

        EditSensProduct.text := FloatToStr((Isens20 - Ifon20) / scale);
        EditSensLab73.text := EditSensProduct.text;

        for i := 1 to RowCount - 1 do
        begin
            if TryStrToFloat2(Cells[1, i], Ifon) and
              TryStrToFloat2(Cells[2, i], Isens) then
            begin
                Cells[2, i] :=
                  FloatToStr(100 * abs((Isens - Ifon) / (Isens20 - Ifon20)));

            end;
        end;
    end;

    UploadTempPoints;

end;

procedure TFormFirmware.LinkLabel2Click(Sender: TObject);
var
    n, i: Integer;
    Temp, Ifon20, Isens20, KSens, Ifon, Isens, Ksens_percent, scale_end,
      scale_begin, scale: Double;
    f: Boolean;
begin
    if not TryStrToFloat2(EditScaleEnd.text, scale_end) then
        raise Exception.Create('Не задан конец шкалы');

    if not TryStrToFloat2(EditScaleBegin.text, scale_begin) then
        raise Exception.Create('Не задано начало шкалы');

    scale := scale_end - scale_begin;

    if scale = 0 then
        raise Exception.Create('Шкала не должна быть нулевой');

    with StringGrid2 do
    begin
        f := false;
        for i := 1 to RowCount - 1 do
        begin
            if (TryStrToFloat2(Cells[0, i], Temp)) and (Temp = 20) and
              (TryStrToFloat2(Cells[1, i], Ifon20)) then
            begin
                f := true;
                break;
            end;
        end;
        if not f then
            raise Exception.Create('Не заданы токи при 20"С');

        Ifon20 := Ifon20 / 1000;

        if not TryStrToFloat2(EditSensProduct.text, KSens) then
            raise Exception.Create('Не задан коэффициент чувствительности');

        Isens20 := (Ifon20 + scale * KSens);

        if Isens20 = Ifon20 then
            raise Exception.Create
              ('Фоновый ток при 20"С не должен быть равен току чувствительности при 20"С');

        for i := 1 to RowCount - 1 do
        begin
            if TryStrToFloat2(Cells[1, i], Ifon) and
              TryStrToFloat2(Cells[2, i], Ksens_percent) then
            begin
                Ifon := Ifon / 1000;
                Isens := Ksens_percent * (Isens20 - Ifon20) / 100.0 + Ifon;
                Cells[2, i] := FloatToStr(1000 * Isens);

            end;
        end;
    end;

end;

procedure TFormFirmware.MenuUseSelectedProductTypeClick(Sender: TObject);
var
    i: Integer;
    t: TProductType2;
    xs: TArray<TArray<string>>;
    s: string;
begin

    t := TPlaceFirmware.GetProductType(ComboBoxProductType.text);

    ComboBoxUnits.Items.Clear;
    ComboBoxGas.Items.Clear;
    for s in TProductTypesSvc.Gases do
        ComboBoxGas.Items.Add(s);
    for s in TProductTypesSvc.Units do
        ComboBoxUnits.Items.Add(s);

    EditSensProduct.text := t.KSens20.Str;
    EditSensLab73.text := t.KSens20.Str;
    EditScaleBegin.text := '0';
    EditScaleEnd.text := FloatToStr(t.scale);
    EditFon20.text := t.Fon20.Str;
    DateTimePicker1.DateTime := Now;

    SetComboBoxText(ComboBoxUnits, t.UnitsName);
    SetComboBoxText(ComboBoxGas, t.GasName);

    SetTemperaturePointsChart(t.TempPoints.Temp, t.TempPoints.Fon,
      t.TempPoints.Sens);
    xs := t.Currents;
    with StringGrid2 do
    begin
        RowCount := 1;
        for i := 0 to length(xs) - 1 do
        begin
            RowCount := RowCount + 1;
            Cells[0, RowCount - 1] := xs[i][0];
            Cells[1, RowCount - 1] := xs[i][1];
            Cells[2, RowCount - 1] := xs[i][2];
            FixedRows := 1;
        end;
    end;
end;

procedure TFormFirmware.MenuSaveProductTypeClick(Sender: TObject);
begin
    if MessageDlg(Format('Подтвердите сохранения данных для исполнения "%s".',
      [ComboBoxProductType.text]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes
    then
        exit;

    TPlaceFirmware.SaveProductType(GetTFirmwareInfo);
end;

end.
