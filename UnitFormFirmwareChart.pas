unit UnitFormFirmwareChart;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VclTee.TeEngine,
    VclTee.Series, Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart;

type
    TFormFirmwareChart = class(TForm)
        Chart1: TChart;
        Series1: TFastLineSeries;
        Series2: TFastLineSeries;
        procedure FormCreate(Sender: TObject);
        procedure Chart1AfterDraw(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormFirmwareChart: TFormFirmwareChart;

implementation

uses System.types, server_data_types_helpers, math;

{$R *.dfm}

procedure TFormFirmwareChart.Chart1AfterDraw(Sender: TObject);
var
    i, xPos, yPos, a, b: Integer;
    ser: TChartSeries;

    marker_place: Boolean;
    marker_rects: array of TRect;
    marker_rect, r2: TRect;
    value_format, marker_text: string;

    function pow2(X: Extended): Extended;
    begin
        exit(IntPower(X, 2));
    end;

begin

    // ShowCurrentScaleValues;

    Chart1.Canvas.Pen.Style := psSolid;
    Chart1.Canvas.Pen.Width := 1;
    Chart1.Canvas.Pen.Mode := pmCopy;
    Chart1.Canvas.Font.Size := 8;

    for ser in Chart1.SeriesList do
    begin
        if not ser.Active then
            continue;

        Chart1.Canvas.Pen.Color := ser.Color;
        Chart1.Canvas.Brush.Color := ser.Color;

        for i := ser.FirstValueIndex to ser.LastValueIndex do
        begin
            if (i = -1) OR (not is_main_temperature(ser.XValues[i])) then
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

            value_format := Chart1.LeftAxis.AxisValuesFormat;
            if ser = Series2 then
                value_format := Chart1.RightAxis.AxisValuesFormat;

            marker_text := FormatFloat(value_format, ser.YValues[i]);
            with marker_rect do
            begin
                Left := xPos + 10;
                Top := yPos + 10 - Canvas.TextHeight(marker_text);
                Right := xPos + 10 + Canvas.TextWidth(marker_text);
                Bottom := yPos + 10;
            end;

            marker_place := true;
            for r2 in marker_rects do
            begin
                if System.types.IntersectRect(marker_rect, r2) then
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

procedure TFormFirmwareChart.FormCreate(Sender: TObject);
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

end;

end.
