unit UnitFormProductTypeDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
    TFormProductTypeDialog = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Button1: TButton;
        procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    private
        { Private declarations }
        FPlace1, FPlace2: integer;
    public
        { Public declarations }
        procedure SetPlaces(APlace1, APlace2:integer);

    end;

var
    FormProductTypeDialog: TFormProductTypeDialog;

implementation

{$R *.dfm}

uses services, UnitFormLastParty;

function formatPlace(n:integer):string;
begin
    result := inttostr(n div 8 + 1) + '.' + inttostr(n mod 8 + 1);
end;


procedure TFormProductTypeDialog.SetPlaces(APlace1, APlace2:integer);
begin
    FPlace1 := APlace1;
    FPlace2 := APlace2;
    Caption := Format('Места стенда: с %s по %s', [formatPlace(FPlace1), formatPlace(FPlace2) ] );
end;

procedure TFormProductTypeDialog.Button1Click(Sender: TObject);
begin
    TLastPartySvc.SetProductTypeAtPlacesRange(FPlace1, FPlace2, ComboBox1.Text);
    FormLastParty.reload_data;
end;

procedure TFormProductTypeDialog.FormCreate(Sender: TObject);
var s:string;
begin
    ComboBox1.Items.Add('');
    for s in TProductTypesSvc.Names do
        ComboBox1.Items.Add(s);

end;

procedure TFormProductTypeDialog.FormDeactivate(Sender: TObject);
begin
    Hide;
end;

end.
