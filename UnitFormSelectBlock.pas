unit UnitFormSelectBlock;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
    Vcl.ExtCtrls;

type

    TFormSelectBlock = class(TForm)
        Panel14: TPanel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    private
        { Private declarations }
        procedure update_data(v:boolean);
    public
        { Public declarations }
        FParty: boolean;
        FBlock: integer;
    end;

var
    FormSelectBlock: TFormSelectBlock;

implementation

{$R *.dfm}

uses UnitFormLastParty, services;

procedure TFormSelectBlock.Button1Click(Sender: TObject);
begin
    update_data(true);
end;

procedure TFormSelectBlock.Button2Click(Sender: TObject);
begin
    update_data(false);
end;

procedure TFormSelectBlock.update_data(v:boolean);
begin
    if FParty then
    begin

        FormLastParty.SetProductionAll(v);
    end
    else
    begin

        FormLastParty.SetProductionBlock(FBlock, v);
    end;

end;

end.
