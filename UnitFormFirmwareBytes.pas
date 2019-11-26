unit UnitFormFirmwareBytes;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils;

type
    TFormFirmwareBytes = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure setup(ABytes: TArray<string>);
    end;

var
    FormFirmwareBytes: TFormFirmwareBytes;

implementation

{$R *.dfm}

procedure TFormFirmwareBytes.setup(ABytes: TArray<string>);
var
    ARow, i: Integer;
begin
    with StringGrid1 do
    begin
        Visible := false;
        RowCount := 1;
        ColWidths[0] := 60;
        Cells[0,0] := 'Àäð./+';
        for i := 0 to 15 do
            Cells[i+1, 0] := IntToHex(i,2);
        for i := 0 to Length(ABytes) - 1 do
        begin
            if i mod 16 = 0 then
            begin
                RowCount := RowCount + 1;
                Visible := true;
                ARow := RowCount - 1;
                Cells[0,ARow] := IntToHex(i,4);
                FixedRows := 1;
                FixedCols := 1;
            end;
            Cells[ i mod 16 + 1,ARow] := ABytes[i];

        end;
    end;

end;

procedure TFormFirmwareBytes.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    AText: string;
    isFF: bool;
    AValue: Integer;

begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    cnv.Brush.Color := grd.Color;
    AText := grd.Cells[ACol, ARow];

    isFF := (not TryStrToInt('$' + AText, AValue)) or (AValue = $FF);

    if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if (gdFixed in State) or isFF then
        cnv.Brush.Color := cl3DLight;

    StringGrid_DrawCellText(grd, ACol, ARow, Rect, taCenter,
      grd.Cells[ACol, ARow]);

    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

end.
