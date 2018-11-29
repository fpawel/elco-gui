unit UnitFormFirmware;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ExtCtrls, server_data_types, server_data_types_helpers,
    System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Grids, VclTee.TeeGDIPlus,
    VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, pipe, VclTee.Series;

type
    TFormFirmware = class(TForm)
        Panel3: TPanel;
        Panel8: TPanel;
        StringGrid2: TStringGrid;
        PanelConsoleHeader: TPanel;
        ImageList3: TImageList;
        ToolBar4: TToolBar;
        ToolButton1: TToolButton;
        ToolBar1: TToolBar;
        ToolButton2: TToolButton;
        ToolButton3: TToolButton;
        Panel10: TPanel;
    FlowPanel1: TFlowPanel;
    Label2: TLabel;
    EditSerial: TEdit;
    Label3: TLabel;
    ComboBoxProductType: TComboBox;
    Label5: TLabel;
    ComboBoxUnits: TComboBox;
    Label4: TLabel;
    ComboBoxGas: TComboBox;
    Label6: TLabel;
    EditScale: TEdit;
    Label7: TLabel;
    EditSens: TEdit;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
        procedure ToolButton1Click(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure Chart1AfterDraw(Sender: TObject);
    private
        { Private declarations }
        procedure DrawCellText(text: string; ACnv: TCanvas; Rect: TRect;
          ta: TAlignment);
    public
        { Public declarations }
        procedure SetProduct(p: TProduct);
    end;

var
    FormFirmware: TFormFirmware;

implementation

{$R *.dfm}

uses System.Types, stringgridutils, stringutils, services, dateutils, math;

const
    main_temperatures: array [0 .. 7] of double = (-40, -20, 0, 20, 30,
      40, 45, 50);

function is_main_temperature(x: double): boolean;
var
    t: double;
begin
    for t in main_temperatures do
        if t = x then
            exit(true);
    exit(false);
end;

function pow2(x: Extended): Extended;
begin
    exit(IntPower(x, 2));
end;

procedure TFormFirmware.FormCreate(Sender: TObject);
var
    s: string;
begin
    with Chart1.BottomAxis.Grid do
    begin
        Style := psDashDotDot;
        Color := clGray;
        Width := 0;
    end;

    with Chart1.LeftAxis.Grid do
    begin
        Style := psDashDotDot;
        Color := clGray;
        Width := 0;
    end;

    with Chart1.RightAxis.Grid do
    begin
        Style := psDashDotDot;
        Color := clGray;
        Width := 0;
    end;

    ComboBoxProductType.Items.Clear;
    ComboBoxUnits.Items.Clear;
    ComboBoxGas.Items.Clear;

    for s in TProductTypes.Names do
        ComboBoxProductType.Items.Add(s);
    for s in TProductTypes.Gases do
        ComboBoxGas.Items.Add(s);
    for s in TProductTypes.Units do
        ComboBoxUnits.Items.Add(s);

end;

procedure TFormFirmware.FormDeactivate(Sender: TObject);
begin
    Hide;
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
    ACnv.Brush.Color := AGRd.Color;
    DrawCellText(AGRd.cells[ACol, ARow], ACnv, Rect, taCenter);
    StringGrid_DrawCellBounds(ACnv, ACol, ARow, Rect);
end;

procedure TFormFirmware.ToolButton1Click(Sender: TObject);
begin
    ToolButton1.ImageIndex := Integer(not boolean(ToolButton1.ImageIndex));
    StringGrid2.Visible := ToolButton1.ImageIndex = 1;
    ToolBar1.Visible := StringGrid2.Visible;

end;

procedure TFormFirmware.Chart1AfterDraw(Sender: TObject);
var
    i, xPos, yPos, a, b: Integer;
    ser: TChartSeries;

    marker_place: boolean;
    marker_rects: array of TRect;
    marker_rect, r2: TRect;
    marker_text: string;
begin

    // ShowCurrentScaleValues;

    Chart1.Canvas.Pen.Style := psSolid;
    Chart1.Canvas.Pen.Width := 1;
    Chart1.Canvas.Pen.Mode := pmCopy;
    Chart1.Canvas.Font.Size := 12;

    for ser in Chart1.SeriesList do
    begin
        if not ser.Active then
            continue;

        Chart1.Canvas.Pen.Color := ser.Color;
        Chart1.Canvas.Brush.Color := ser.Color;

        for i := ser.FirstValueIndex to ser.LastValueIndex do
        begin
            if not is_main_temperature(ser.XValues[i]) then
                continue;

            xPos := ser.CalcXPos(i);
            yPos := ser.CalcYPos(i);

            if not PtInRect(Chart1.ChartRect, Point(xPos, yPos)) then
                continue;

            if (i > ser.FirstValueIndex) AND (i < ser.LastValueIndex) AND
              (pow2(xPos - a) + pow2(yPos - b) < pow2(7)) then
                continue;

            Chart1.Canvas.Ellipse(xPos - 5, yPos - 5, xPos + 5, yPos + 5);
            // Chart1.Canvas.Donut(xPos, yPos, 3, 3, -1, 361, 100);
            a := xPos;
            b := yPos;

            marker_text := Format('%g', [ser.YValues[i]]);
            with marker_rect do
            begin
                Left := xPos + 10;
                Top := yPos + 10 - Canvas.TextHeight(marker_text);
                Right := xPos + 10 + Canvas.TextWidth(marker_text);
                Bottom := yPos + 10 ;
            end;

            marker_place := true;
            for r2 in marker_rects do
            begin
                if System.Types.IntersectRect(marker_rect, r2) then
                begin
                    marker_place := false;
                    break;
                end;
            end;
            if marker_place then
            begin
                Chart1.Canvas.Font.Color := ser.Color;
                Chart1.Canvas.TextOut(marker_rect.Left, marker_rect.Top,
                  marker_text);
                SetLength(marker_rects, length(marker_rects) + 1);
                marker_rects[length(marker_rects) - 1] := marker_rect;
            end;
        end;
    end;

end;

procedure TFormFirmware.DrawCellText(text: string; ACnv: TCanvas; Rect: TRect;
  ta: TAlignment);
var
    x, Y, txt_width, txt_height: Integer;
begin
    // s := AGrd.Cells[ACol, ARow];
    with ACnv do
    begin

        if TextWidth(text) + 3 > Rect.Width then
            text := cut_str(text, ACnv, Rect.Width);
        txt_width := TextWidth(text);
        txt_height := TextHeight(text);
        x := Rect.Left + 3;
        if ta = taRightJustify then
            x := Rect.Right - 3 - round(txt_width)
        else if ta = taCenter then
            x := Rect.Left + round((Rect.Width - txt_width) / 2.0);
        Y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        TextRect(Rect, x, Y, text);
    end;
end;

procedure SetComboBoxText(x: TComboBox; text: String);
begin
    x.ItemIndex := x.Items.IndexOf(text);
end;

procedure correct_axis_oreders(ax: TChartAxis; min_v, max_v:double);
var    d_ax: double;
begin
    if min_v = max_v then
        exit;
    d_ax := (max_v - min_v) * 0.1;
    ax.SetMinMax(min_v - d_ax, max_v + d_ax);
end;

procedure TFormFirmware.SetProduct(p: TProduct);
var
    f: TProductFirmwareInfo;
    i: Integer;


begin

     if p.FHasFirmware then
         f := TProductFirmware.Stored(p.FProductID)
     else
        f := TProductFirmware.Calculate(p.FProductID);

    DateTimePicker1.DateTime := f.FTime;
    EditSerial.text := f.FSerial;
    EditSens.text := f.FSensitivity;
    EditScale.text := f.FScale;
    SetComboBoxText(ComboBoxProductType, f.FProductType);
    SetComboBoxText(ComboBoxUnits, f.FUnits);
    SetComboBoxText(ComboBoxGas, f.FGas);

    Series1.Clear;
    Series2.Clear;

    for i := 0 to length(f.FTemp) - 1 do
    begin
        Series1.AddXY(f.FTemp[i], f.FFon[i]);
        Series2.AddXY(f.FTemp[i], f.FSens[i]);
    end;
    f.Free;

    correct_axis_oreders(Chart1.BottomAxis, -125, 125);
    correct_axis_oreders(Chart1.LeftAxis, Series1.MinYValue, Series1.MaxYValue);
    correct_axis_oreders(Chart1.RightAxis, Series2.MinYValue, Series2.MaxYValue);
    Show;
end;

end.
