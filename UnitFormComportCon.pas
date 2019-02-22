unit UnitFormComportCon;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.Samples.Spin, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls,
    server_data_types;

type

    TFormComportCon = class(TForm)
        RichEdit1: TRichEdit;
        Panel3: TPanel;
        ImageList4: TImageList;
        ToolBar1: TToolBar;
        ToolButton1: TToolButton;
        Panel1: TPanel;
        Panel4: TPanel;
        Panel5: TPanel;
        Panel6: TPanel;
        SpinEdit1: TSpinEdit;
        procedure FormCreate(Sender: TObject);
        procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure ToolButton1Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);

    private
        { Private declarations }

    public
        { Public declarations }
        procedure OnComportEntry(entry:TComportEntry);
    end;

var
    FormComportCon: TFormComportCon;

implementation

uses Rest.Json, dateutils, richeditutils;

{$R *.dfm}

procedure TFormComportCon.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormComportCon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    //
end;

procedure TFormComportCon.OnComportEntry(entry:TComportEntry);
begin

    while RichEdit1.Lines.Count > SpinEdit1.Value do
        RichEdit1.Lines.Delete(0);

    SendMessage(RichEdit1.handle, EM_SETSEL, length(RichEdit1.Text),
      length(RichEdit1.Text));

    RichEdit1.SelAttributes.Color := clGreen;
    RichEdit1.SelText := formatDatetime('hh:mm:ss.zzz',now) + ' : ';

    RichEdit1.SelAttributes.Style := [fsBold];
    RichEdit1.SelAttributes.Color := clGray;
    RichEdit1.SelText := entry.FPort + ' : ';

    RichEdit1.SelAttributes.Style := [];
    if entry.FError then
    begin
        RichEdit1.SelAttributes.Color := clRed;
    end
    else
        RichEdit1.SelAttributes.Color := clNavy;

    RichEdit1.SelText := entry.FMsg + #13;

    SendMessage(RichEdit1.handle, WM_VSCROLL, SB_BOTTOM, 0);

    entry.Free;
    Panel5.Caption := IntToStr(RichEdit1.Lines.Count);
end;

procedure TFormComportCon.RichEdit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = TMouseButton.mbRight then
        RichEdit_PopupMenu(RichEdit1);
end;

procedure TFormComportCon.ToolButton1Click(Sender: TObject);
begin
    RichEdit1.Clear;
end;

end.
