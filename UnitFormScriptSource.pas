unit UnitFormScriptSource;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ToolWin,
    Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, server_data_types;

type
    TFormScriptSource = class(TForm)
        ImageList4: TImageList;
        Panel1: TPanel;
        ToolBar6: TToolBar;
        ToolButtonStop: TToolButton;
        ToolButton1: TToolButton;
        ToolButton2: TToolButton;
        RichEdit1: TRichEdit;
        Label1: TLabel;
        procedure ToolButtonStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure OnScriptLine(x: TScriptLine);
    end;

var
    FormScriptSource: TFormScriptSource;

implementation

{$R *.dfm}

uses services, richeditutils, UnitElcoMainForm;

procedure TFormScriptSource.FormShow(Sender: TObject);
begin
    RichEdit1.Lines.Text := ElcoMainForm.FIni.ReadString('work', 'script', '');
    Label1.Hide;
end;


procedure TFormScriptSource.ToolButtonStopClick(Sender: TObject);
var
    r: TRunScriptResult;
begin
    r := TRunnerSvc.RunScript(RichEdit1.Lines.Text);
    if r.ErrorLineno > -1 then
    begin
        Label1.Show;
        Label1.Caption := Format('ошибка в строке %d: "%s"',
          [r.ErrorLineno, r.ErrorLine]);
    end
    else
    begin
        Label1.Hide;
    end;

end;


procedure TFormScriptSource.OnScriptLine(x: TScriptLine);
var s : string;
begin
    s := RichEdit1.Lines.Text;
    RichEdit1.Lines.Clear;
    RichEdit1.Lines.Text := s;
    RichEdit1.SelStart := RichEdit1.Perform(EM_LINEINDEX, x.Lineno-1, 0);
    RichEdit1.SelLength := RichEdit1.Perform(EM_LINEINDEX, x.Lineno, 0) -
      RichEdit1.SelStart;
    RichEdit1.SelAttributes.Style := [fsBold];
    RichEdit1.SelAttributes.Color := clNavy;
    RichEdit_SetBackgroundColor(RichEdit1, clGradientInactiveCaption);
    RichEdit1.SelLength := 0;

end;

procedure TFormScriptSource.RichEdit1Change(Sender: TObject);
begin
    ElcoMainForm.FIni.WriteString('work', 'script', RichEdit1.Lines.Text);
end;

end.
