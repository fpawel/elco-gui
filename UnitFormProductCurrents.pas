unit UnitFormProductCurrents;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls;

type
    TFormProductCurrents = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure Load(productID: int64);
    end;

var
    FormProductCurrents: TFormProductCurrents;

implementation

{$R *.dfm}

uses stringgridutils, server_data_types, services;

procedure TFormProductCurrents.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);

    if ARow = 0 then
    begin
        StringGrid1.Canvas.Brush.Color := cl3DLight;
        StringGrid_DrawCellText(grd, ACol, ARow, Rect, taCenter,
          grd.Cells[ACol, ARow]);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        exit;
    end;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else
        Cnv.Brush.Color := GRd.Color;

    StringGrid_DrawCellText(grd, ACol, ARow, Rect, taCenter,
      grd.Cells[ACol, ARow]);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormProductCurrents.Load(productID: int64);
var
    xs: TArray<TProductCurrent>;
    v: TProductCurrent;
    ACol, ARow, w: Integer;
begin

    with StringGrid1 do
    begin
        ColCount := 5;
        Cells[0, 0] := 'Дата';
        Cells[1, 0] := 'Т"C';
        Cells[2, 0] := 'Газ';
        Cells[3, 0] := 'Ток,мкА';
        Cells[4, 0] := 'Прим.';

        for ACol := 0 to ColCount - 1 do
        begin
            ColWidths[ACol] := 20;
            for ARow := 1 to rowcount - 1 do
                Cells[ACol, ARow] := '';
        end;
        xs := TProductsCatalogueSvc.ProductCurrents(productID);
        rowcount := Length(xs) + 1;
        for ARow := 1 to rowcount - 1 do
            with xs[ARow-1] do
            begin
                Cells[0, ARow] := DateTimeToStr(StoredAt);
                Cells[1, ARow] := FloatToStr(Temperature);
                Cells[2, ARow] := IntToStr(Gas);
                Cells[3, ARow] := FloatToStr(CurrentValue);
                Cells[4, ARow] := Note;
            end;

        for ACol := 0 to ColCount - 1 do
            for ARow := 0 to rowcount - 1 do
            begin
                w := StringGrid1.Canvas.TextWidth(Cells[ACol, ARow]) + 5;
                if ColWidths[ACol] < w + 5 then
                    ColWidths[ACol] := w + 5;
            end;
    end;

end;

end.
