unit UnitFormParty;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
    Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
    server_data_types, Product_Column, Vcl.Menus;

type
    TFormParty = class(TForm)
        StringGrid1: TStringGrid;
        PopupMenu1: TPopupMenu;
        MenuCheck: TMenuItem;
        MenuUncheck: TMenuItem;
    N1: TMenuItem;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1DblClick(Sender: TObject);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure MenuCheckClick(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
    procedure N1Click(Sender: TObject);
    private
        { Private declarations }
        FParty: TParty1;
        FColumns: TProductColumns;

        procedure SetParty(AParty: TParty1);
        procedure DoSetParty;

        procedure DrawCellText(ACol, ARow: Integer; Rect: TRect;
          ta: TAlignment);

        function GetProductValue(ColumnIndex, RowIndex: Integer): RProductValue;

        property ProductValues[ColumnIndex, RowIndex: Integer]: RProductValue
          read GetProductValue;
    public
        { Public declarations }
        property Party: TParty1 read FParty write SetParty;

    end;

var
    FormParty: TFormParty;

implementation

uses stringgridutils, services, stringutils, UnitFormFirmware,
  UnitFormLastParty, UnitFormFirmwareChart, UnitFormProductCurrents;

{$R *.dfm}

procedure TFormParty.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormParty.StringGrid1DblClick(Sender: TObject);
var
    ACol, ARow: Integer;
    pt: TPoint;
    product: TProductInfo;
    f: TFirmwareInfo;
begin
    GetCursorPos(pt);
    pt := StringGrid1.ScreenToClient(pt);
    StringGrid1.MouseToCell(pt.X, pt.Y, ACol, ARow);
    if (ARow < 1) or (ARow >= Length(FParty.Products)) then
        exit;
    FormFirmware.product := FParty.Products[ARow - 1];
    FormFirmware.show;
end;

procedure TFormParty.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    p: TProductInfo;
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

    p := FParty.Products[ARow - 1];

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if ARow = grd.Row then
        cnv.Brush.Color := clInfoBk
    else if (p.Production = true) or (p.HAsFirmware = true) then
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
              p.Production);
        pcFirmware:
            if p.HAsFirmware = true then
                FormLastParty.DrawCellFirmware(grd, Rect, State, ACol, ARow)
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

procedure TFormParty.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
    p: TProductInfo;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ACol > 0) or (ARow = 0) then
        exit;
    p := FParty.Products[ARow - 1];

    try
        TPartiesCatalogueSvc.ToggleProductProduction(p.ProductID);
    except
        on e: Exception do
        begin
            Application.ShowException(e);
            exit;
        end;
    end;

    p.Production := not p.Production;
    StringGrid_RedrawRow(StringGrid1, ARow);

end;

procedure TFormParty.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    StringGrid_RedrawRow(StringGrid1, StringGrid1.Row);
    StringGrid_RedrawRow(StringGrid1, ARow);
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
        if Length(FParty.Products) = 0 then
        begin
            Visible := false;
            exit;

        end;
        Visible := true;
        FColumns := GetProductColumns(FParty.Products, []);

        ColCount := Length(FColumns);
        RowCount := Length(FParty.Products) + 1;
        if RowCount > 1 then
            FixedRows := 1;
        if ColCount > 1 then
            FixedCols := 1;

        for ACol := 0 to ColCount - 1 do
        begin
            Cells[ACol, 0] := product_column_name[FColumns[ACol]];
            ColWidths[ACol] := ProductColumnWidth(FColumns[ACol],
              StringGrid1.Canvas, FParty.Products);
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

procedure TFormParty.SetParty(AParty: TParty1);
begin
    FParty := AParty;
    DoSetParty;
end;

function TFormParty.GetProductValue(ColumnIndex, RowIndex: Integer)
  : RProductValue;
begin
    result := GetProductColumnValue(FParty.Products[RowIndex],
      FColumns[ColumnIndex]);

end;

procedure TFormParty.MenuCheckClick(Sender: TObject);
var
    ARow: Integer;
    p: ^TProductInfo;
    ProductIDs: TArray<Int64>;

begin
    with StringGrid1 do
    begin
        for ARow := Selection.Top to Selection.Bottom do
        begin
            p := @FParty.Products[ARow - 1];
            p.Production := Sender = MenuCheck;
            Cells[0, ARow] := GetProductColumnValue(p^, pcPlace).Value;
            SetLength(ProductIDs, Length(ProductIDs) + 1);
            ProductIDs[Length(ProductIDs) - 1] := p.ProductID;
        end;
    end;

    try
        TPartiesCatalogueSvc.SetProductsProduction(ProductIDs,
          Sender = MenuCheck);
    except
        on e: Exception do
        begin
            Application.ShowException(e);
            exit;
        end;
    end;
end;

procedure TFormParty.N1Click(Sender: TObject);
begin
    TPdfSvc.RunProductID(FParty.Products[StringGrid1.Row - 1].ProductID);
end;

end.
