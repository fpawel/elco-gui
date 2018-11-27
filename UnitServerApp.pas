unit UnitServerApp;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
    superobject, ujsonrpc, server_Data_types;

type
    TServerApp = class(TDataModule)
        procedure DataModuleCreate(Sender: TObject);
    private
        { Private declarations }

    public
        { Public declarations }
        function LastParty: TParty;
        function Party(partyID: int64): TParty;

        function GetJsonResult(const method: string; params: ISuperObject)
          : ISuperObject;
    end;

var
    ServerApp: TServerApp;

implementation

uses rest.json, pipe;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

var
    pipe_conn: TPipe;

procedure TServerApp.DataModuleCreate(Sender: TObject);
begin
    pipe_conn := TPipe.Create('\\.\pipe\elco');
end;

function TServerApp.Party(partyID: int64): TParty;
begin
    result := TParty.FromJsonString(Pipe_GetJsonrpcResult(pipe_conn,
      'PartiesCatalogue.Party', SA([partyID])).AsJson);
end;

function TServerApp.LastParty: TParty;
begin
    TParty.FromJsonString(Pipe_GetJsonrpcResult(pipe_conn, 'LastParty.Party',
      SO).AsJson);
end;

function TServerApp.GetJsonResult(const method: string; params: ISuperObject)
  : ISuperObject;
begin
    result := Pipe_GetJsonrpcResult(pipe_conn, method, params);
end;

end.
