unit UnitFormScriptSource;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
    Vcl.ToolWin,
    Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, server_data_types,
  UnitElcoMainForm;

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
        procedure ToolButton1Click(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
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

uses services, richeditutils;

procedure TFormScriptSource.FormCreate(Sender: TObject);
begin
    if FileExists(ExtractFileDir(ParamStr(0)) + '\scenary.scn') then
        RichEdit1.Lines.LoadFromFile(ExtractFileDir(ParamStr(0)) +
          '\scenary.scn');

    Label1.Hide;
    RichEdit1.Font.Size := 20;
    RichEdit1.Font.Name := 'Consolas';
end;

procedure TFormScriptSource.FormDestroy(Sender: TObject);
begin
    RichEdit1.Lines.SaveToFile(ExtractFileDir(ParamStr(0)) + '\scenary.scn');
end;

procedure TFormScriptSource.ToolButton1Click(Sender: TObject);
begin
    with TFileOpenDialog.Create(nil) do
    begin
        with fileTypes.Add do
        begin
            DisplayName := 'Файлы сценария *.scn';
            FileMask := '*.scn';
        end;
        DefaultFolder := ExtractFileDir(ParamStr(0));
        DefaultExtension := '*.scn';

        if Execute then
            RichEdit1.Lines.LoadFromFile(FileName);

        Free;
    end;
end;

procedure TFormScriptSource.ToolButton2Click(Sender: TObject);
begin
    with TFileSaveDialog.Create(nil) do
    begin
        with fileTypes.Add do
        begin
            DisplayName := 'Файлы сценария *.scn';
            FileMask := '*.scn';
        end;
        DefaultFolder := ExtractFileDir(ParamStr(0));
        DefaultExtension := '*.scn';
        Options := Options + [fdoOverwritePrompt];
        if Execute then
            RichEdit1.Lines.SaveToFile(FileName);

        Free;
    end;

end;

procedure TFormScriptSource.ToolButtonStopClick(Sender: TObject);
var
    r: TRunScriptResult;
begin
    if ElcoMainForm.FWorkStarted then
    begin
        TRunnerSvc.StopHardware;
        Exit;
    end;
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
var
    s: string;
begin
    s := RichEdit1.Lines.Text;
    RichEdit1.Lines.Clear;
    RichEdit1.Lines.Text := s;
    RichEdit1.SelStart := RichEdit1.Perform(EM_LINEINDEX, x.Lineno - 1, 0);
    RichEdit1.SelLength := RichEdit1.Perform(EM_LINEINDEX, x.Lineno, 0) -
      RichEdit1.SelStart;
    RichEdit1.SelAttributes.Style := [fsBold];
    RichEdit1.SelAttributes.Color := clNavy;
    RichEdit_SetBackgroundColor(RichEdit1, clGradientInactiveCaption);
    RichEdit1.SelLength := 0;

end;

end.
