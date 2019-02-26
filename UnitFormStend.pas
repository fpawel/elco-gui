unit UnitFormStend;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
    TFormStend = class(TForm)
        StringGrid1: TStringGrid;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    private
        { Private declarations }

        procedure DrawCellText(ACol, ARow: Integer; Rect: TRect;
          ta: TAlignment);

    public
        FCheckBlock: TArray< boolean>;
        { Public declarations }
    end;

var
    FormStend: TFormStend;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, services, server_data_types;

procedure TFormStend.FormCreate(Sender: TObject);
var
    cl, ro: Integer;
begin
    with StringGrid1 do
    begin
        DefaultColWidth := 85;
        DefaultRowHeight := 30;
        RowCount := 13;
        ColCount := 9;
        Cells[0, 0] := '/';
        for cl := 1 to 9 do
            Cells[cl, 0] := 'Место ' + inttostr(cl);
        for ro := 1 to 13 do
            Cells[0, ro] := 'Блок ' + inttostr(ro);

    end;
end;

procedure TFormStend.FormShow(Sender: TObject);
var r:TGetCheckBlocksArg;
begin
    r := TSettingsSvc.GetCheckBlocks;
    FCheckBlock :=r.FCheck;
    r.Free;
end;

procedure TFormStend.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    grd: TStringGrid;
    cnv: TCanvas;
    al: TAlignment;
begin
    grd := StringGrid1;
    cnv := grd.Canvas;
    cnv.Font.Assign(grd.Font);
    cnv.Brush.Assign(grd.Brush);

    al := taRightJustify;

    if (ARow = 0) then
    begin
        cnv.Brush.Color := cl3DLight;
        al := taCenter;
    end
    else if gdSelected in State then
        cnv.Brush.Color := clGradientInactiveCaption
    else if not FCheckBlock[ARow - 1] then
    begin
        cnv.Brush.Color := $F9F9F9;
        cnv.Font.Color := clGray;
    end;

    if (ACol = 0) and (ARow > 0) then
        StringGrid_DrawCheckBoxCell(StringGrid1, 0, ARow, Rect, State,
          FCheckBlock[ARow - 1])
    else
        DrawCellText(ACol, ARow, Rect, al);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormStend.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ACol > 0) or (ARow = 0) then
        exit;
    TSettingsSvc.SetCheckBlock(ARow - 1, integer(not FCheckBlock[ARow - 1]) );

    FCheckBlock[ARow - 1] := not FCheckBlock[ARow - 1];
    StringGrid_RedrawRow(StringGrid1, ARow);
end;

procedure TFormStend.DrawCellText(ACol, ARow: Integer; Rect: TRect;
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

end.
