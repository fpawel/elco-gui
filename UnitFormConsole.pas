unit UnitFormConsole;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.Samples.Spin, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls,
    server_data_types;

type

    TFormConsole = class(TForm)
        RichEdit1: TRichEdit;
        Panel3: TPanel;
        ImageList4: TImageList;
        ToolBar1: TToolBar;
        ToolButton1: TToolButton;
        Panel1: TPanel;
        Panel5: TPanel;
        Panel6: TPanel;
        procedure FormCreate(Sender: TObject);
        procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure ToolButton1Click(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);

    private
        { Private declarations }

    public
        { Public declarations }
        procedure OnComportEntry(entry: TComportEntry);
        procedure OnJournalEntry(entry: TJournalEntry);
    end;

var
    FormConsole: TFormConsole;

implementation

uses Rest.Json, dateutils, richeditutils, server_data_types_helpers;

{$R *.dfm}

procedure TFormConsole.FormCreate(Sender: TObject);
begin
    //
end;

procedure TFormConsole.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    //
end;

procedure TFormConsole.OnJournalEntry(entry: TJournalEntry);
begin
    RichEdit1.SelAttributes.Color := clGreen;
    RichEdit1.SelText := TimeToStr(entry.FCreatedAt) + '  ';

    RichEdit1.SelAttributes.Color := clWebLightSalmon;
    RichEdit1.SelText := entry.FFile + ' ' + inttostr(entry.FLine) + ' ';

    RichEdit1.SelAttributes.Style := [fsBold];
    RichEdit1.SelAttributes.Color := clGray;
    RichEdit1.SelText := entry.FWorkName + ' ';

    RichEdit1.SelAttributes.Style := [];

    if entry.IsErrorLevel then
    begin
        RichEdit1.SelAttributes.Color := clRed;
        // RichEdit_setBackcolor(RichEdit1, cl3DLight);
    end
    else if (entry.FLevel = 'warn') or (entry.FLevel = 'warning') then
        RichEdit1.SelAttributes.Color := clMaroon
    else if entry.FLevel = 'info' then
        RichEdit1.SelAttributes.Color := clNavy
    else if entry.FLevel = 'debug' then
        RichEdit1.SelAttributes.Color := clGray
    else
        RichEdit1.SelAttributes.Color := clBlack;

    RichEdit1.SelText := entry.FMessage + #13;

    if entry.FStack <> '' then
    begin
        RichEdit1.SelAttributes.Color := clGrayText;
        RichEdit1.SelText := entry.FStack + #13;
    end;

    SendMessage(RichEdit1.handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TFormConsole.OnComportEntry(entry: TComportEntry);
var
    i: Integer;
begin
    if RichEdit1.Lines.Count > 300 then
    begin
        RichEdit1.Hide;
        for i := 0 to 1000 div 3 do
            RichEdit1.Lines.Delete(0);
        RichEdit1.Show;
    end;

    SendMessage(RichEdit1.handle, EM_SETSEL, length(RichEdit1.Text),
      length(RichEdit1.Text));

    RichEdit1.SelAttributes.Color := clGreen;
    RichEdit1.SelText := formatDatetime('hh:mm:ss.zzz', now) + ' : ';

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
    Panel5.Caption := inttostr(RichEdit1.Lines.Count);


end;

procedure TFormConsole.RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if Button = TMouseButton.mbRight then
        RichEdit_PopupMenu(RichEdit1);
end;

procedure TFormConsole.ToolButton1Click(Sender: TObject);
begin
    RichEdit1.Clear;
end;

end.
