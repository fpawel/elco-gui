unit UnitFormFirmware;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Grids, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart;

type
  TFormFirmware = class(TForm)
    Panel14: TPanel;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    ComboBox3: TComboBox;
    Panel4: TPanel;
    Panel2: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    ComboBox2: TComboBox;
    Label6: TLabel;
    Edit2: TEdit;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Label7: TLabel;
    Edit3: TEdit;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    PanelConsoleHeader: TPanel;
    ImageList3: TImageList;
    Panel9: TPanel;
    ToolBar4: TToolBar;
    ToolButton1: TToolButton;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel10: TPanel;
    Panel12: TPanel;
    Chart1: TChart;
    Panel19: TPanel;
    procedure ToolButton1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DrawCellText(text:string; ACnv:TCanvas; Rect: TRect;
  ta: TAlignment);
  public
    { Public declarations }
  end;

var
  FormFirmware: TFormFirmware;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, services;

procedure TFormFirmware.FormCreate(Sender: TObject);
var s:string;
begin
    ComboBox1.Items.Clear;
    ComboBox2.Items.Clear;
    ComboBox3.Items.Clear;

    for s in TProductTypes.Names do
        ComboBox1.Items.Add(s);
    for s in TProductTypes.Gases do
        ComboBox2.Items.Add(s);
    for s in TProductTypes.Units do
        ComboBox3.Items.Add(s);


end;

procedure TFormFirmware.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormFirmware.StringGrid2DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var AGrd:TstringGrid;
ACnv: TCanvas;
begin
    AGrd := Sender As TStringGrid;
    ACnv := AGrd.Canvas;
    ACnv.Font.Assign(AGrd.Font);
    ACnv.Brush.Color := AGrd.Color;
    DrawCellText( AGrd.cells[ACol, ARow], ACnv, Rect, taCenter);
    StringGrid_DrawCellBounds(ACnv, ACol, ARow, Rect);
end;

procedure TFormFirmware.ToolButton1Click(Sender: TObject);
begin
    ToolButton1.ImageIndex := integer( not boolean(ToolButton1.ImageIndex) );
    StringGrid2.Visible := ToolButton1.ImageIndex = 1;
    ToolBar1.Visible := StringGrid2.Visible;

end;

procedure TFormFirmware.DrawCellText(text:string; ACnv:TCanvas; Rect: TRect;
  ta: TAlignment);
var
    s: string;
    X, Y, txt_width, txt_height: Integer;
begin
    //s := AGrd.Cells[ACol, ARow];
    with ACnv do
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
