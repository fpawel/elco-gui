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
        Panel14: TPanel;
        Edit1: TEdit;
        Panel3: TPanel;
        Edit2: TEdit;
        StringGrid1: TStringGrid;
    ImageList1: TImageList;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
        FTable : TArray<TArray<TCell>>;
        FBmpFirmware, FBmpFirmwareSelected: TBitmap;
        procedure DrawCellFirmware(Rect: TRect; State: TGridDrawState);
    public
        { Public declarations }
        procedure Fetch;
    end;

var
    FormJournalProducts: TFormJournalProducts;

implementation

{$R *.dfm}

uses stringgridutils, services;

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
    cell : TCell;
    ta:TAlignment;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    if length(FTable) = 0 then
    begin
        cell.Res :=0;
        cell.Str := '';
    end else
        cell := FTable[ARow][ACol];
    ta := taLeftJustify;

    if ARow = 0 then
    begin
        StringGrid1.Canvas.Brush.Color := cl3DLight;
        ta := taCenter;
        //StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, taCenter, cell.Str);
        //StringGrid_DrawCellBounds(StringGrid1.Canvas, ACol, ARow, Rect);
        //exit;
    end;



    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if ARow = grd.Row then
        cnv.Brush.Color := clInfoBk
    else
    begin
        cnv.Brush.Color := $F9F9F9;
        cnv.Font.Color := clGray;
    end;


    if (ARow > 0) AND (ACol=2) then
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
        StringGrid_DrawCellText(StringGrid1, ACol, ARow, Rect, ta, cell.Str);
    end;

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormJournalProducts.DrawCellFirmware(Rect: TRect; State: TGridDrawState);
begin
    if gdSelected in State then
        StringGrid_DrawCellBmp(StringGrid1, Rect, FBmpFirmwareSelected)
    else
        StringGrid_DrawCellBmp(StringGrid1, Rect, FBmpFirmware);
    StringGrid1.Canvas.FillRect(Rect);
end;

procedure TFormJournalProducts.Fetch;
var n, nRow, nCol:integer;

begin
    if TryStrToInt(Edit1.Text, n) then
        FTable := TProductsCatalogueSvc.ListProductsBySerial(n)
    else
    begin
        FTable := [];
        StringGrid_Clear(StringGrid1);
        exit;
    end;

    with StringGrid1 do
    begin
        ColCount := Length( FTAble[0] );
        RowCount := Length( FTAble );
        for nRow :=0 to RowCount-1 do
        for nCol := 0 to ColCount-1 do
            Cells[nCol,nRow]:= FTable[nRow][nCol].Str;



    end;

end;

end.
