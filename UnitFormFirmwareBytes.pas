unit UnitFormFirmwareBytes;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, stringgridutils,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
    TFormFirmwareBytes = class(TForm)
        StringGrid1: TStringGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
    private
        { Private declarations }

    public
        { Public declarations }
        procedure SetupBytes(ABytes: TArray<string>);
        function Getbytes: TArray<string>;
    end;

var
    FormFirmwareBytes: TFormFirmwareBytes;

implementation

{$R *.dfm}

uses UnitFormFirmware, services;

procedure TFormFirmwareBytes.SetupBytes(ABytes: TArray<string>);
var
    ATopRow, ARow, i: Integer;
    MyClass: TStringGrid;

begin
    with StringGrid1 do
    begin
        ATopRow := TopRow;

        ColWidths[0] := 60;
        Cells[0, 0] := 'Àäð./+';
        for i := 0 to 15 do
            Cells[i + 1, 0] := IntToHex(i, 2);

        if Length(ABytes) = 0 then
        begin
            Visible := false;
            exit;
        end;
        Visible := true;
        ARow := 0;

        for i := 0 to Length(ABytes) - 1 do
        begin
            if i mod 16 = 0 then
            begin
                Inc(ARow);
                if ARow >= RowCount then
                    RowCount := ARow + 1;

                Cells[0, ARow] := IntToHex(i, 4);

            end;
            if Cells[i mod 16 + 1, ARow] <> ABytes[i] then
                Cells[i mod 16 + 1, ARow] := ABytes[i];
        end;
        if (ATopRow > 1) and (ATopRow < RowCount) then
            TopRow := ATopRow;
        FixedRows := 1;
        FixedCols := 1;
        RowCount := ARow + 1;

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

function TFormFirmwareBytes.Getbytes: TArray<string>;
var
    cl, ro: Integer;
begin
    SetLength(result, 0);
    With StringGrid1 do
        for ro := 1 to RowCount - 1 do
            for cl := 1 to ColCount - 1 do
            begin
                SetLength(result, Length(result) + 1);
                result[Length(result) - 1] := Cells[cl, ro];
            end;

end;

end.
