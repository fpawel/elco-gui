unit UnitFormConsole;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.Samples.Spin, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls;

type

    TFormConsole = class(TForm)
        RichEdit1: TRichEdit;
        ImageList4: TImageList;
    Panel3: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    Panel1: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
        procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure ToolButton1Click(Sender: TObject);

    private
        { Private declarations }

    public
        { Public declarations }
        procedure OnEntry(entry:string);
    end;

var
    FormConsole: TFormConsole;

implementation

uses Rest.Json, dateutils, richeditutils;

{$R *.dfm}

procedure TFormConsole.OnEntry(entry:string);
begin

    SendMessage(RichEdit1.handle, EM_SETSEL, length(RichEdit1.Text),
      length(RichEdit1.Text));
    RichEdit1.SelText := entry + #13;
    SendMessage(RichEdit1.handle, WM_VSCROLL, SB_BOTTOM, 0);
    Panel5.Caption := IntToStr(RichEdit1.Lines.Count);
end;

procedure TFormConsole.RichEdit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Button = TMouseButton.mbRight then
        RichEdit_PopupMenu(RichEdit1);
end;

procedure TFormConsole.ToolButton1Click(Sender: TObject);
begin
    RichEdit1.Clear;
end;

end.
