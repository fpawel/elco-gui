unit UnitDataModule1;

interface

uses
    System.SysUtils, System.Classes, inifiles, FireDAC.Stan.Intf,
    FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
    FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
    FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
    FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, dbutils,
    FireDAC.DApt;

type
    TQueryHandler = reference to procedure(q: TFDQuery);

    TDataModule1 = class(TDataModule)
        FDConnectionElcheseDB: TFDConnection;
        procedure DataModuleCreate(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
        FIni: TIniFile;
    end;

var
    DataModule1: TDataModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
    FIni := TIniFile.Create(ExtractFileDir(paramstr(0)) + '\main.ini');
end;


end.
