unit UnitFormSelectProducts;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
    Vcl.ExtCtrls, UnitFormSelectBlock;

type

    TFormSelectProducts = class(TForm)
        Panel1: TPanel;
        procedure FormCreate(Sender: TObject);
        procedure FormDeactivate(Sender: TObject);
    private
        { Private declarations }
        FBlocks: array [-1 .. 11] of TFormSelectBlock;
        FParty: TFormSelectBlock;
    public
        { Public declarations }
    end;

var
    FormSelectProducts: TFormSelectProducts;

implementation

{$R *.dfm}


procedure TFormSelectProducts.FormCreate(Sender: TObject);
var
    i: integer;
begin
    FParty := TFormSelectBlock.Create(self);
    with FParty do
    begin
        Font.Assign(self.Font);
        Parent := self.Panel1;
        BorderStyle := bsNone;
        Align := alTop;
        self.Width := Width + 5;
        self.Height := Height * 13 + 50;
        FParty := true;
        Show;
    end;
    FBlocks[-1] := FParty;
    for i := 0 to 11 do
    begin
        FBlocks[i] := TFormSelectBlock.Create(self);
        with FBlocks[i] do
        begin
            Font.Assign(self.Font);
            Parent := self.Panel1;
            BorderStyle := bsNone;
            Align := alTop;
            Show;
            Top := 100500;
            Panel1.Caption := '���� ' + IntToStr(i + 1);
            FParty := false;
            FBlock := i;
        end;

    end;

end;

procedure TFormSelectProducts.FormDeactivate(Sender: TObject);
begin
    hide;
end;

end.
