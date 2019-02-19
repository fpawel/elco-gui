unit UnitFormParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    server_data_types, Product_Column;

type
    TFormParty = class(TForm)
        StringGrid1: TStringGrid;
        ImageList1: TImageList;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
    private
        { Private declarations }
        FParty: TParty;
        FColumns: TProductColumns;

        procedure SetParty(AParty: TParty);
        procedure DoSetParty;

        procedure DrawCellText(ACol, ARow: Integer; Rect: TRect;
          ta: TAlignment);

        function GetProductValue(ColumnIndex, RowIndex: Integer): RProductValue;
        procedure DrawCellFirmware(Rect: TRect; State: TGridDrawState);

        property ProductValues[ColumnIndex, RowIndex: Integer]: RProductValue
          read GetProductValue;
    public
        { Public declarations }
        property Party: TParty read FParty write SetParty;

    end;

var
    FormParty: TFormParty;

implementation

uses stringgridutils, services, stringutils, UnitFormFirmware, pipe;

{$R *.dfm}

procedure TFormParty.FormCreate(Sender: TObject);
begin
    Party := services.TLastParty.Party;
end;

procedure TFormParty.StringGrid1DblClick(Sender: TObject);
var
    ACol, ARow: Integer;
    pt: TPoint;
    product : TProduct;
    f: TFirmwareInfo;
begin
    GetCursorPos(pt);
    pt :=  StringGrid1.ScreenToClient(pt);
    StringGrid1.MouseToCell(pt.X, pt.Y, ACol, ARow);
    if (ARow < 0) or (ARow > Length(FParty.FProducts)) then
        exit;
    FormFirmware.Product := FParty.FProducts[ARow - 1];
    FormFirmware.Show;
end;

procedure TFormParty.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: TProduct;
    pcol: TProductColumn;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);

    if ARow = 0 then
    begin
        StringGrid1.Canvas.Brush.Color := cl3DLight;
        DrawCellText(ACol, 0, Rect, taCenter);
        StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, 0, Rect);
        exit;
    end;

    p := FParty.FProducts[ARow - 1];

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if p.FProduction or p.FHAsFirmware then
    begin
        cnv.Brush.Color := grd.Color;
        // cnv.Font.Color := clNavy;
    end
    else
    begin
        cnv.Brush.Color := $F9F9F9;
        cnv.Font.Color := clGray;
    end;

    case ProductValues[ACol, ARow - 1].Valid of
        vpvInvalid:
            cnv.Font.Color := clRed;
        vpvValid:
            cnv.Font.Color := clBlue;
        vpvNotCheck:
            cnv.Font.Color := clBlack;
    end;

    case TProductColumn(FColumns[ACol]) of
        pcPlace:
            StringGrid_DrawCheckBoxCell(StringGrid1, 0, ARow, Rect, State,
              p.FProduction);
        pcFirmware:
            if p.FHasFirmware then
                DrawCellFirmware(Rect, State)
            else
                StringGrid1.Canvas.FillRect(Rect);

    else
        case ProductValues[ACol, ARow - 1].Valid of
            vpvInvalid:
                cnv.Font.Color := clRed;
            vpvValid:
                cnv.Font.Color := clBlue;
            vpvNotCheck:
                cnv.Font.Color := clBlack;
        end;
        DrawCellText(ACol, ARow, Rect, ProdColumnAlignment(FColumns[ACol]));
    end;

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormParty.DrawCellFirmware(Rect: TRect; State: TGridDrawState);
var
    bmp: TBitmap;
begin
    bmp := TBitmap.Create;
    if gdSelected in State then
        ImageList1.GetBitmap(1, bmp)
    else
        ImageList1.GetBitmap(0, bmp);
    StringGrid1.Canvas.FillRect(Rect);
    StringGrid_DrawCellBmp(StringGrid1, Rect, bmp);
    bmp.Free
end;

procedure TFormParty.DrawCellText(ACol, ARow: Integer; Rect: TRect;
  ta: TAlignment);
var
    s: string;
    X, Y, txt_width, txt_height: Integer;
begin
    s := StringGrid1.Cells[ACol, ARow];
    with StringGrid1.Canvas do
    begin

        if TextWidth(s) + 3 > Rect.Width then
            s := cut_str(s, StringGrid1.Canvas, Rect.Width);
        txt_width := TextWidth(s);
        txt_height := TextHeight(s);
        X := Rect.Left + 3;
        if ta = taRightJustify then
            X := Rect.Right - 3 - round(txt_width)
        else if ta = taCenter then
            X := Rect.Left + round((Rect.Width - txt_width) / 2.0);
        Y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        TextRect(Rect, X, Y, s);
    end;
end;

procedure TFormParty.DoSetParty;
var
    ARow, ACol: Integer;
begin
    StringGrid_Clear(StringGrid1);

    with StringGrid1 do
    begin
        if Length(FParty.FProducts) = 0 then
        begin
            Visible := false;
            exit;

        end;
        Visible := true;
        FColumns := GetProductColumns(FParty.FProducts, []);

        ColCount := Length(FColumns);
        RowCount := Length(FParty.FProducts) + 1;
        if RowCount > 1 then
            FixedRows := 1;
        if ColCount > 1 then
            FixedCols := 1;

        for ACol := 0 to ColCount - 1 do
        begin
            Cells[ACol, 0] := product_column_name[FColumns[ACol]];
            ColWidths[ACol] := ProductColumnWidth(FColumns[ACol],
              StringGrid1.Canvas, FParty.FProducts);
        end;

        for ARow := 1 to RowCount - 1 do
        begin
            for ACol := 0 to ColCount - 1 do
            begin
                Cells[ACol, ARow] := ProductValues[ACol, ARow - 1].Value;
            end;
        end;
    end;
end;

procedure TFormParty.SetParty(AParty: TParty);
begin
    FParty := AParty;
    DoSetParty;
end;

function TFormParty.GetProductValue(ColumnIndex, RowIndex: Integer)
  : RProductValue;
begin
    result := GetProductColumnValue(FParty.FProducts[RowIndex],
      FColumns[ColumnIndex]);

end;

end.
