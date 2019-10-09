unit UnitFormFirmware;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ExtCtrls, server_data_types, server_data_types_helpers,
    System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Grids, VclTee.TeeGDIPlus,
    VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, VclTee.Series;

type
    TFormFirmware = class(TForm)
        ImageList3: TImageList;
        Panel1: TPanel;
        ToolBar2: TToolBar;
        ToolButton3: TToolButton;
        ToolButton4: TToolButton;
        Panel2: TPanel;
        Panel4: TPanel;
        Label9: TLabel;
        ComboBoxPlace: TComboBox;
        Label2: TLabel;
        EditSerial: TEdit;
        Label1: TLabel;
        DateTimePicker1: TDateTimePicker;
        Label3: TLabel;
        ComboBoxProductType: TComboBox;
        Label4: TLabel;
        ComboBoxGas: TComboBox;
        Label5: TLabel;
        ComboBoxUnits: TComboBox;
        Label6: TLabel;
        EditScaleBegin: TEdit;
        Label8: TLabel;
        EditScaleEnd: TEdit;
        Label7: TLabel;
        EditSens: TEdit;
        GroupBox2: TGroupBox;
        StringGrid2: TStringGrid;
        Panel3: TPanel;
        ToolBar3: TToolBar;
        ToolButton14: TToolButton;
        ToolButton15: TToolButton;
        ToolBar5: TToolBar;
        ToolButton18: TToolButton;
        ToolButton19: TToolButton;
        ToolButton111: TToolButton;
        RadioButton1: TRadioButton;
        RadioButton2: TRadioButton;
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
        procedure ToolButton3Click(Sender: TObject);
        procedure StringGrid2MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure ToolButton122Click(Sender: TObject);
        procedure RadioButton1Click(Sender: TObject);
        procedure RadioButton2Click(Sender: TObject);
        procedure ToolButton8Click(Sender: TObject);
        procedure ToolButton6Click(Sender: TObject);
        procedure ToolButton4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    private
        { Private declarations }
        Last_Edited_Col, Last_Edited_Row: Integer;

        FProduct: TProductInfo;


        procedure DrawCellText(text: string; ACnv: TCanvas; Rect: TRect;
          ta: TAlignment);
        procedure SetTemperaturePointsChart(ATemp: TArray<Double>;
          AFon: TArray<Double>; ASens: TArray<Double>);
        procedure SetTemperaturePointsGrid(ATemp: TArray<Double>;
          AFon: TArray<Double>; ASens: TArray<Double>);

        function GetTemperatureValues: TArray<string>;

        procedure SetFirmwareInfo(f: TFirmwareInfo);
        procedure ClearFirmwareInfo;

        procedure SetProduct(p: TProductInfo);
        procedure applyProduct;

    public
        { Public declarations }
        procedure SetReadFirmwareInfo(f: TFirmwareInfo);
        property Product: TProductInfo read FProduct write SetProduct;

    end;

var
    FormFirmware: TFormFirmware;

implementation

{$R *.dfm}

uses System.Types, stringgridutils, stringutils, services, dateutils, math,
    UnitElcoMainForm, UnitFormProductCurrents, UnitFormFirmwareChart;

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
        Cells[3, RowCount - 1] := 'Ч, нА';
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
            with TPlaceFirmware.TempPoints(GetTemperatureValues) do
                SetTemperaturePointsChart(Temp, Fon, Sens);

        end
        else
        begin // The cell is being editted
            Last_Edited_Col := ACol; // Remember column of cell being edited
            Last_Edited_Row := ARow; // Remember row of cell being edited
        end;
end;

procedure TFormFirmware.ToolButton122Click(Sender: TObject);
var
    t: TDateTime;
begin
    t := DateTimePicker1.DateTime;

    // Year, Month, Day, Hour, Minute, Second

    TPlaceFirmware.RunWritePlaceFirmware(ComboBoxPlace.ItemIndex, YearOf(t),
      MonthOf(t), DayOf(t), HourOf(t), MinuteOf(t), SecondOf(t), EditSens.text,
      EditSerial.text, ComboBoxProductType.text, ComboBoxGas.text,
      ComboBoxUnits.text, EditScaleBegin.text, EditScaleEnd.text,
      GetTemperatureValues);
end;

procedure TFormFirmware.ToolButton2Click(Sender: TObject);
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
    with TPlaceFirmware.TempPoints(GetTemperatureValues) do
        SetTemperaturePointsChart(Temp, Fon, Sens);
end;

procedure TFormFirmware.ToolButton3Click(Sender: TObject);
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

    with TPlaceFirmware.TempPoints(GetTemperatureValues) do
        SetTemperaturePointsChart(Temp, Fon, Sens);
end;

procedure TFormFirmware.ToolButton4Click(Sender: TObject);
begin
    TPlaceFirmware.RunReadPlaceFirmware(ComboBoxPlace.ItemIndex);

end;

procedure TFormFirmware.ToolButton6Click(Sender: TObject);
var
    n, i: Integer;
    Temp, Ifon20, Isens20, KSens, Ifon, Isens, Ksens_percent, scale_end,
      scale_begin, scale: Double;
    f: Boolean;
begin
    if not try_str_to_float(EditScaleEnd.text, scale_end) then
        raise Exception.Create('Не задан конец шкалы');

    if not try_str_to_float(EditScaleBegin.text, scale_begin) then
        raise Exception.Create('Не задано начало шкалы');

    scale := scale_end - scale_begin;

    if scale = 0 then
        raise Exception.Create('Шкала не должна быть нулевой');

    with StringGrid2 do
    begin
        f := false;
        for i := 1 to RowCount - 1 do
        begin
            if (try_str_to_float(Cells[0, i], Temp)) and (Temp = 20) and
              (try_str_to_float(Cells[1, i], Ifon20)) then
            begin
                f := true;
                break;
            end;
        end;
        if not f then
            raise Exception.Create('Не заданы токи при 20"С');

        if not try_str_to_float(EditSens.text, KSens) then
            raise Exception.Create('Не задан коэффициент чувствительности');

        Isens20 := Ifon20 + scale * KSens;

        if Isens20 = Ifon20 then
            raise Exception.Create
              ('Фоновый ток при 20"С не должен быть равен току чувствительности при 20"С');

        for i := 1 to RowCount - 1 do
        begin
            if try_str_to_float(Cells[1, i], Ifon) and
              try_str_to_float(Cells[2, i], Ksens_percent) then
            begin
                Cells[3, i] := FloatToStr(Ksens_percent * (Isens20 - Ifon20) /
                  100.0 + Ifon);

            end;
        end;
    end;

end;

procedure TFormFirmware.ToolButton8Click(Sender: TObject);
var
    n, i: Integer;
    Temp, Ifon20, Isens20, Ifon, Isens, scale_end, scale_begin, scale: Double;
    f: Boolean;
begin
    if not try_str_to_float(EditScaleEnd.text, scale_end) then
        raise Exception.Create('Не задан конец шкалы');

    if not try_str_to_float(EditScaleBegin.text, scale_begin) then
        raise Exception.Create('Не задано начало шкалы');

    scale := scale_end - scale_begin;

    if scale = 0 then
        raise Exception.Create('Шкала не должна быть нулевой');

    with StringGrid2 do
    begin
        f := false;
        for i := 1 to RowCount - 1 do
        begin
            if (try_str_to_float(Cells[0, i], Temp)) and (Temp = 20) and
              (try_str_to_float(Cells[1, i], Ifon20)) and
              (try_str_to_float(Cells[3, i], Isens20)) then
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

        EditSens.text := FloatToStr((Isens20 - Ifon20) / scale);

        for i := 1 to RowCount - 1 do
        begin
            if try_str_to_float(Cells[1, i], Ifon) and
              try_str_to_float(Cells[2, i], Isens) then
            begin
                Cells[2, i] :=
                  FloatToStr(100 * abs((Isens - Ifon) / (Isens20 - Ifon20)));

            end;
        end;
    end;

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

procedure SetComboBoxText(X: TComboBox; text: String);
begin
    X.ItemIndex := X.Items.IndexOf(text);
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

procedure TFormFirmware.ClearFirmwareInfo;
begin
    DateTimePicker1.DateTime := now;
    EditSerial.text := '';
    EditSens.text := '';
    EditScaleBegin.text := '';
    EditScaleEnd.text := '';
    SetComboBoxText(ComboBoxProductType, '');
    SetComboBoxText(ComboBoxUnits, '');
    SetComboBoxText(ComboBoxGas, '');
    FormFirmwareChart.Series1.Clear;
    FormFirmwareChart.Series2.Clear;
    StringGrid_Clear(StringGrid2);
end;

procedure TFormFirmware.SetFirmwareInfo(f: TFirmwareInfo);
var
    i: Integer;
    has_null: Boolean;
    Temp: Double;
    s: string;
begin
    ComboBoxProductType.Items.Clear;
    ComboBoxUnits.Items.Clear;
    ComboBoxGas.Items.Clear;
    for s in TProductTypesSvc.Names do
        ComboBoxProductType.Items.Add(s);
    for s in TProductTypesSvc.Gases do
        ComboBoxGas.Items.Add(s);
    for s in TProductTypesSvc.Units do
        ComboBoxUnits.Items.Add(s);

    ComboBoxPlace.ItemIndex := f.Place;
    DateTimePicker1.DateTime := f.CreatedAt.DateTime;
    EditSerial.text := f.Serial;
    EditSens.text := f.Sensitivity;
    EditScaleBegin.text := f.ScaleBeg;
    EditScaleEnd.text := f.ScaleEnd;
    SetComboBoxText(ComboBoxProductType, f.ProductType);
    SetComboBoxText(ComboBoxUnits, f.Units);
    SetComboBoxText(ComboBoxGas, f.Gas);
    SetTemperaturePointsChart(f.Temp, f.Fon, f.Sens);
    SetTemperaturePointsGrid(f.Temp, f.Fon, f.Sens);

    with StringGrid2 do
    begin
        for i := 1 to RowCount - 1 do
        begin
            if not try_str_to_float(Cells[0, i], Temp) then
                continue;
            if (Temp = 20) then
                Cells[3, i] := f.ISPlus20
            else if (Temp = -20) then
                Cells[3, i] := f.ISMinus20
            else if (Temp = 50) then
                Cells[3, i] := f.ISPlus50;

        end;
    end;
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

procedure TFormFirmware.RadioButton1Click(Sender: TObject);
begin
    RadioButton2.OnClick := nil;
    applyProduct;
    RadioButton2.OnClick := RadioButton2Click;
end;

procedure TFormFirmware.RadioButton2Click(Sender: TObject);
begin
    RadioButton1.OnClick := nil;
    applyProduct;
    RadioButton1.OnClick := RadioButton1Click;
end;

procedure TFormFirmware.SetTemperaturePointsChart(ATemp: TArray<Double>;
  AFon: TArray<Double>; ASens: TArray<Double>);
var
    i: Integer;
begin
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

procedure TFormFirmware.SetTemperaturePointsGrid(ATemp: TArray<Double>;
  AFon: TArray<Double>; ASens: TArray<Double>);
var
    i: Integer;
    has_null: Boolean;
begin
    StringGrid2.RowCount := 1;
    has_null := false;
    for i := 0 to length(ATemp) - 1 do
    begin
        if is_main_temperature(ATemp[i]) then
            with StringGrid2 do
            begin
                if (ATemp[i] = 0) then
                begin
                    if has_null then
                        continue;
                    has_null := true;
                end;

                RowCount := RowCount + 1;
                Cells[0, RowCount - 1] := FloatToStr(ATemp[i]);
                Cells[1, RowCount - 1] := FloatToStr(AFon[i]);
                Cells[2, RowCount - 1] := FloatToStr(ASens[i]);
                Cells[3, RowCount - 1] := '';
            end;
    end;
end;

procedure TFormFirmware.SetReadFirmwareInfo(f: TFirmwareInfo);
var
    n: Integer;
begin
    RadioButton1.OnClick := nil;
    RadioButton2.OnClick := nil;
    SetFirmwareInfo(f);
    RadioButton1.Checked := true;
    RadioButton1.OnClick := RadioButton1Click;
    RadioButton2.OnClick := RadioButton2Click;
end;

procedure TFormFirmware.applyProduct;
begin

    Caption := 'Прошивка ЭХЯ ' + inttostr(FProduct.ProductID);


    if FProduct.ProductID <> 0 then
    begin
        if RadioButton1.Checked then
        begin
            if FProduct.HasFirmware = true then
                SetFirmwareInfo(TPlaceFirmware.StoredFirmwareInfo
                  (FProduct.ProductID))
            else
            begin
                ClearFirmwareInfo;
            end;
        end
        else
            SetFirmwareInfo(TPlaceFirmware.CalculateFirmwareInfo
              (FProduct.ProductID));
    end
    else
    begin
        ClearFirmwareInfo;
    end;
    ComboBoxPlace.ItemIndex := FProduct.Place;
end;

procedure TFormFirmware.SetProduct(p: TProductInfo);
begin
    FProduct := p;
    applyProduct;
end;

end.
