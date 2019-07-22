unit UnitFormSelectTemperaturesDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
    Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls;

type
    TFormSelectTemperaturesDialog = class(TForm)
        ImageList3: TImageList;
        Panel14: TPanel;
        CheckListBox1: TCheckListBox;
        ToolBarStop: TToolBar;
        ToolButton2: TToolButton;
        procedure FormDeactivate(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ToolButton2Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FormSelectTemperaturesDialog: TFormSelectTemperaturesDialog;

implementation

{$R *.dfm}

uses services;

procedure TFormSelectTemperaturesDialog.FormCreate(Sender: TObject);
var
    i: integer;
begin

end;

procedure TFormSelectTemperaturesDialog.FormDeactivate(Sender: TObject);
begin
    hide;
end;

procedure TFormSelectTemperaturesDialog.ToolButton2Click(Sender: TObject);
begin
    hide;
    with CheckListBox1 do
        TRunnerSvc.RunMain(Checked[0], Checked[1], Checked[2], Checked[3]);
    hide;
end;

end.
