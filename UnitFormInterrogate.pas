unit UnitFormInterrogate;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
    TFormInterrogate = class(TForm)
        StringGrid1: TStringGrid;
    Panel1: TPanel;
    Button1: TButton;
        procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure FormShow(Sender: TObject);
    procedure LinkLabel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    private
        { Private declarations }

        procedure DrawCellText(ACol, ARow: Integer; Rect: TRect;
          ta: TAlignment);

    public
        FCheckBlock: TArray<boolean>;
        procedure UpdateCheckBlocks;
        { Public declarations }
    end;

var
    FormInterrogate: TFormInterrogate;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, services, server_data_types;

procedure TFormInterrogate.FormCreate(Sender: TObject);
var
    cl, ro: Integer;
begin
    SetLength(FCheckBlock, 12);
    with StringGrid1 do
    begin
        DefaultColWidth := 85;
        DefaultRowHeight := 30;
        RowCount := 13;
        ColCount := 9;
        for cl := 1 to 9 do
            Cells[cl, 0] := 'Место ' + inttostr(cl);
        for ro := 1 to 13 do
            Cells[0, ro] := 'Блок ' + inttostr(ro);

    end;
end;

procedure TFormInterrogate.FormShow(Sender: TObject);
begin
    FCheckBlock := TLastPartySvc.GetCheckBlocks.Check;
end;

procedure TFormInterrogate.LinkLabel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
      (Sender as TLinkLabel).Color := clBlue;
end;

procedure TFormInterrogate.StringGrid1DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
        cnv.Brush.Color := clGradientInactiveCaption;

    if (ACol = 0) and (ARow > 0) then
        StringGrid_DrawCheckBoxCell(StringGrid1, 0, ARow, Rect, State,
          FCheckBlock[ARow - 1])
    else
        DrawCellText(ACol, ARow, Rect, al);
    StringGrid_DrawCellBounds(cnv, ACol, ARow, Rect);
end;

procedure TFormInterrogate.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    ACol, ARow: Integer;
begin
    if (GetAsyncKeyState(VK_LBUTTON) >= 0) then
        exit;
    StringGrid1.MouseToCell(X, Y, ACol, ARow);
    if (ACol > 0) or (ARow = 0) then
        exit;
    FCheckBlock[ARow - 1] := boolean(TLastPartySvc.SetBlockChecked(ARow - 1,
      Integer(not FCheckBlock[ARow - 1])));
    if FCheckBlock[ARow - 1] then
        StringGrid_RedrawRow(StringGrid1, ARow)
    else
    begin
        StringGrid1.Cells[0, ARow] := StringGrid1.Cells[0, ARow];
        for ACol := 1 to StringGrid1.ColCount - 1 do
            StringGrid1.Cells[ACol, ARow] := '';
    end;

end;

procedure TFormInterrogate.Button1Click(Sender: TObject);
begin
    TThread.CreateAnonymousThread(procedure begin
        TRunnerSvc.RunReadCurrent;
    end).Start;

end;

procedure TFormInterrogate.DrawCellText(ACol, ARow: Integer; Rect: TRect;
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

procedure TFormInterrogate.UpdateCheckBlocks;
var
    r: TGetCheckBlocksArg;
    ARow: Integer;
begin
    r := TLastPartySvc.GetCheckBlocks;
    FCheckBlock := r.Check;
    for ARow := 1 to 12 do
        StringGrid1.Cells[0, ARow] := StringGrid1.Cells[0, ARow];
end;

end.
