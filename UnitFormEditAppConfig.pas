unit UnitFormEditAppConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
    System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
    TFormEditAppConfig = class(TForm)
        ImageList4: TImageList;
        ToolBarStop: TToolBar;
    ToolButtonSave: TToolButton;
        RichEdit1: TRichEdit;
        ToolButtonUpload: TToolButton;
        procedure ToolButtonSaveClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
        procedure ToolButtonUploadClick(Sender: TObject);
        procedure RichEdit1Change(Sender: TObject);
        procedure RichEdit1KeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
    private
        { Private declarations }

    public
        { Public declarations }
    end;

var
    FormEditAppConfig: TFormEditAppConfig;

implementation

{$R *.dfm}

uses services, Winapi.RichEdit, System.Character;

procedure TFormEditAppConfig.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormEditAppConfig.FormShow(Sender: TObject);
begin
    RichEdit1.Text := TConfigSvc.GetYAML;
    ToolButtonSave.Enabled := false;

end;

procedure TFormEditAppConfig.RichEdit1Change(Sender: TObject);
begin
    ToolButtonSave.Enabled := true;
end;

procedure TFormEditAppConfig.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Shift = [ssCtrl]) and (Upcase(Char(Key)) = 'S') then
        ToolButtonSave.Click;
end;

procedure TFormEditAppConfig.ToolButtonSaveClick(Sender: TObject);
var
    ASelStart: integer;
begin
    ASelStart := RichEdit1.SelStart;
    RichEdit1.Text := TConfigSvc.SetYAML(RichEdit1.Text);
    ToolButtonSave.Enabled := false;
    RichEdit1.SelStart := ASelStart;
    RichEdit1.SelLength := 0;
end;

procedure TFormEditAppConfig.ToolButtonUploadClick(Sender: TObject);
begin
    RichEdit1.Text := TConfigSvc.GetYAML();
    ToolButtonSave.Enabled := false;
end;

end.
