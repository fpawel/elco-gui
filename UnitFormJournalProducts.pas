unit UnitFormJournalProducts;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
    server_data_types, System.ImageList, Vcl.ImgList;

type
    TFormJournalProducts = class(TForm)
        Panel1: TPanel;
        Edit1: TEdit;
        Panel3: TPanel;
        StringGrid1: TStringGrid;
        ImageList1: TImageList;
        Timer1: TTimer;
        ComboBox1: TComboBox;
    Button1: TButton;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
        procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    private
        { Private declarations }
        FTable: TArray<TArray<TCell>>;
        FBmpFirmware, FBmpFirmwareSelected: TBitmap;
        procedure DrawCellFirmware(Rect: TRect; State: TGridDrawState);
    public
        { Public declarations }
    end;

var
    FormJournalProducts: TFormJournalProducts;

implementation

{$R *.dfm}

uses stringgridutils, services;

procedure SetTableGrid(grd: TStringGrid; ATable: TArray < TArray < TCell >> );
var
    Row: TArray<TCell>;
    w, ACol, ARow: Integer;
begin

    with grd do
    begin
        ColCount := Length(ATable[0]);
        RowCount := Length(ATable);
        for ARow := 0 to RowCount - 1 do
            for ACol := 0 to ColCount - 1 do
                Cells[ACol, ARow] := ATable[ARow][ACol].Str;
        if RowCount > 1 then
            FixedRows := 1;
    end;

    for Row in ATable do
        for ACol := 0 to Length(Row) - 1 do
        begin
            w := grd.Canvas.TextWidth(Row[ACol].Str) + 5;
            if grd.ColWidths[ACol] < w then
                grd.ColWidths[ACol] := w;
        end;

end;

procedure TFormJournalProducts.FormCreate(Sender: TObject);
begin
    FBmpFirmware := TBitmap.Create;
    FBmpFirmwareSelected := TBitmap.Create;
    ImageList1.GetBitmap(0, FBmpFirmware);
    ImageList1.GetBitmap(1, FBmpFirmwareSelected);
end;

procedure TFormJournalProducts.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    cell: TCell;
begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    if Length(FTable) = 0 then
    begin
        cell.Res := 0;
        cell.Str := '';
    end
    else
        cell := FTable[ARow][ACol];

    if ARow = 0 then
        StringGrid1.Canvas.Brush.Color := cl3DLight;

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if ARow = grd.Row then
        cnv.Brush.Color := clInfoBk
    else
    begin
        cnv.Brush.Color := grd.Color;
        cnv.Font.Color := clGray;
    end;

    if (ARow > 0) AND (ACol = 2) then
    begin
        if cell.Str = 'true' then
            DrawCellFirmware(Rect, State)
        else
            StringGrid1.Canvas.FillRect(Rect);
    end
    else
    begin
        case cell.Res of
            2:
                cnv.Font.Color := clRed;
            1:
                cnv.Font.Color := clBlue;
            0:
                cnv.Font.Color := clBlack;
        end;
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect,
          TAlignment(cell.TextAlignment), cell.Str);
    end;

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormJournalProducts.StringGrid1SelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
    StringGrid_RedrawRow(StringGrid1, StringGrid1.Row);
    StringGrid_RedrawRow(StringGrid1, ARow);
end;

procedure TFormJournalProducts.Button1Click(Sender: TObject);
var
    n, ARow, ACol: Integer;

begin
    with StringGrid1 do
    begin
        for ACol := 0 to ColCount - 1 do
            for ARow := 0 to RowCount - 1 do
                Cells[ACol, ARow] := '';
        ColCount := 1;
        RowCount := 1;
    end;
    FTable := [];

    case ComboBox1.ItemIndex of
        0:
            if TryStrToInt(Edit1.Text, n) then
                FTable := TProductsCatalogueSvc.ListProductsBySerial(n);

        1:
            FTable := TProductsCatalogueSvc.ListProductsByNote(Edit1.Text);

    end;

    if Length(FTable) > 0 then
        SetTableGrid(StringGrid1, FTable);

end;

procedure TFormJournalProducts.DrawCellFirmware(Rect: TRect;
  State: TGridDrawState);
begin
    StringGrid1.Canvas.FillRect(Rect);
    if gdSelected in State then
        StringGrid_DrawCellBmp(StringGrid1, Rect, FBmpFirmwareSelected)
    else
        StringGrid_DrawCellBmp(StringGrid1, Rect, FBmpFirmware);

end;

procedure TFormJournalProducts.Edit1Change(Sender: TObject);
begin
    Timer1.Enabled := true;
end;

end.
