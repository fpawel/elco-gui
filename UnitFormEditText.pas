unit UnitFormEditText;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
    System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
    TFormEditText = class(TForm)
        ImageList4: TImageList;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        RichEdit1: TRichEdit;
    ToolButton3: TToolButton;
        procedure ToolButton2Click(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
    end;

var
    FormEditText: TFormEditText;

implementation

{$R *.dfm}

uses services, Winapi.RichEdit, System.Character;

procedure TFormEditText.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

procedure TFormEditText.FormShow(Sender: TObject);
begin
    RichEdit1.Text :=  TConfigSvc.GetYAML;

end;

procedure TFormEditText.RichEdit1Change(Sender: TObject);
begin
    ToolButton2.Enabled := true;
end;

procedure TFormEditText.ToolButton2Click(Sender: TObject);
begin
    RichEdit1.Text := TConfigSvc.SetYAML(RichEdit1.Text);
end;

procedure TFormEditText.ToolButton3Click(Sender: TObject);
begin
    RichEdit1.Text := TConfigSvc.GetYAML();
    ToolButton2.Enabled := false;
end;

end.
