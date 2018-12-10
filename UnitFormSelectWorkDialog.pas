unit UnitFormSelectWorkDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls;

type
  TFormSelectWorkDialog = class(TForm)
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
  FormSelectWorkDialog: TFormSelectWorkDialog;

implementation

{$R *.dfm}

uses services;

procedure TFormSelectWorkDialog.FormCreate(Sender: TObject);
var i:integer;
begin

end;

procedure TFormSelectWorkDialog.FormDeactivate(Sender: TObject);
begin
    hide;
end;

procedure TFormSelectWorkDialog.ToolButton2Click(Sender: TObject);
begin
    
    hide;
end;

end.
