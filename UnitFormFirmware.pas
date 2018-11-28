unit UnitFormFirmware;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ExtCtrls, server_data_types, server_data_types_helpers,
    System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Grids, VclTee.TeeGDIPlus,
    VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, pipe, VCLTee.Series;

type
    TFormFirmware = class(TForm)
        Panel14: TPanel;
        Label1: TLabel;
        DateTimePicker1: TDateTimePicker;
        Label2: TLabel;
        EditSerial: TEdit;
        Label5: TLabel;
        ComboBoxUnits: TComboBox;
        Panel4: TPanel;
        Panel2: TPanel;
        Panel11: TPanel;
        Panel13: TPanel;
        Label3: TLabel;
        ComboBoxProductType: TComboBox;
        Label4: TLabel;
        ComboBoxGas: TComboBox;
        Label6: TLabel;
        EditScale: TEdit;
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
        EditSens: TEdit;
        Panel6: TPanel;
        Panel7: TPanel;
        Panel8: TPanel;
        StringGrid2: TStringGrid;
        PanelConsoleHeader: TPanel;
        ImageList3: TImageList;
        ToolBar4: TToolBar;
        ToolButton1: TToolButton;
        ToolBar1: TToolBar;
        ToolButton2: TToolButton;
        ToolButton3: TToolButton;
        Panel10: TPanel;
        Panel12: TPanel;
        Chart1: TChart;
        Panel9: TPanel;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
        procedure ToolButton1Click(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
          Rect: TRect; State: TGridDrawState);
        procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
        procedure DrawCellText(text: string; ACnv: TCanvas; Rect: TRect;
          ta: TAlignment);
    public
        { Public declarations }
        procedure SetProduct(p: TProduct);
    end;

var
    FormFirmware: TFormFirmware;

implementation

{$R *.dfm}

uses stringgridutils, stringutils, services, dateutils, math;

procedure TFormFirmware.FormCreate(Sender: TObject);
var
    s: string;
begin
    ComboBoxProductType.Items.Clear;
    ComboBoxUnits.Items.Clear;
    ComboBoxGas.Items.Clear;

    for s in TProductTypes.Names do
        ComboBoxProductType.Items.Add(s);
    for s in TProductTypes.Gases do
        ComboBoxGas.Items.Add(s);
    for s in TProductTypes.Units do
        ComboBoxUnits.Items.Add(s);

end;

procedure TFormFirmware.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormFirmware.StringGrid2DrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    AGRd: TStringGrid;
    ACnv: TCanvas;
begin
    AGRd := Sender As TStringGrid;
    ACnv := AGRd.Canvas;
    ACnv.Font.Assign(AGRd.Font);
    ACnv.Brush.Color := AGRd.Color;
    DrawCellText(AGRd.cells[ACol, ARow], ACnv, Rect, taCenter);
    StringGrid_DrawCellBounds(ACnv, ACol, ARow, Rect);
end;

procedure TFormFirmware.ToolButton1Click(Sender: TObject);
begin
    ToolButton1.ImageIndex := Integer(not boolean(ToolButton1.ImageIndex));
    StringGrid2.Visible := ToolButton1.ImageIndex = 1;
    ToolBar1.Visible := StringGrid2.Visible;

end;

procedure TFormFirmware.DrawCellText(text: string; ACnv: TCanvas;
  Rect: TRect; ta: TAlignment);
var
    X, Y, txt_width, txt_height: Integer;
begin
    // s := AGrd.Cells[ACol, ARow];
    with ACnv do
    begin

        if TextWidth(text) + 3 > Rect.Width then
            text := cut_str(text, ACnv, Rect.Width);
        txt_width := TextWidth(text);
        txt_height := TextHeight(text);
        X := Rect.Left + 3;
        if ta = taRightJustify then
            X := Rect.Right - 3 - round(txt_width)
        else if ta = taCenter then
            X := Rect.Left + round((Rect.Width - txt_width) / 2.0);
        Y := Rect.Top + round((Rect.Height - txt_height) / 2.0);
        TextRect(Rect, X, Y, text);
    end;
end;

procedure SetComboBoxText(X: TComboBox; text: String);
begin
    X.ItemIndex := X.Items.IndexOf(text);
end;

procedure TFormFirmware.SetProduct(p: TProduct);
var
    f: TFlashInfo;
    i: Integer;
begin
    f := nil;
    try
        f := TProductFirmware.Stored(p.FProductID);
    except
        on E: TRemoteError do;
    end;

    if not Assigned(f) then
        try
            f := TProductFirmware.Calculated(p.FProductID);
        except
            on E: TRemoteError do;
        end;

    if not Assigned(f) then
        exit;

    DateTimePicker1.DateTime := f.FTime;
    EditSerial.text := FloatToStr(f.FSerial);
    EditSens.text := FloatToStr(RoundTo(f.FSensitivity, -3));
    EditScale.text := f.FScale;
    SetComboBoxText(ComboBoxProductType, f.FProductType);
    SetComboBoxText(ComboBoxUnits, f.FUnits);
    SetComboBoxText(ComboBoxGas, f.FGas);

    Series1.Clear;
    Series2.Clear;

    for i :=0 to length(f.FTemp) -1 do
    begin
        Series1.AddXY(f.FTemp[i], f.FFon[i]);
        Series2.AddXY(f.FTemp[i], f.FSens[i]);

    end;



    f.Free;
    Show;

end;

end.
