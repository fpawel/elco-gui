unit UnitFormSelectBlock;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
    Vcl.ExtCtrls;

type

    TFormSelectBlock = class(TForm)
        RadioButton1: TRadioButton;
        Panel14: TPanel;
        RadioButton2: TRadioButton;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
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

procedure TFormSelectBlock.RadioButton1Click(Sender: TObject);
begin
    RadioButton2.OnClick := nil;
    update_data(true);
    RadioButton2.OnClick := RadioButton2Click;

end;

procedure TFormSelectBlock.RadioButton2Click(Sender: TObject);
begin
    RadioButton1.OnClick := nil;
    update_data(false);
    RadioButton1.OnClick := RadioButton1Click;
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
