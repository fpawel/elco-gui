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

        function MustGetResult(const method: string; params: ISuperObject)
          : ISuperObject;

        function GetResponse(const method: string; params: ISuperObject)
          : IJsonRpcParsed;

        function LastParty: TParty;
        function Party(partyID: int64): TParty;
    end;

var
    ServerApp: TServerApp;

function formatMessagetype(mt: TJsonRpcObjectType): string;

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

    result := TParty.FromJsonString
      (ServerApp.MustGetResult('PartiesCatalogue.Party', SA([partyID])).AsJson);

end;

function TServerApp.LastParty: TParty;
begin
    exit(TParty.FromJsonString(ServerApp.MustGetResult('LastParty.Party',
      SO).AsJson));

end;

function TServerApp.GetResponse(const method: string; params: ISuperObject)
  : IJsonRpcParsed;
begin
    exit(pipe_conn.GetResponse(method, params));
end;

function formatMessagetype(mt: TJsonRpcObjectType): string;
begin
    case mt of
        jotInvalid:
            exit('jotInvalid');
        jotRequest:
            exit('jotRequest');
        jotNotification:
            exit('jotNotification');
        jotSuccess:
            exit('jotSuccess');
        jotError:
            exit('jotError');
    end;
end;

function TServerApp.MustGetResult(const method: string; params: ISuperObject)
  : ISuperObject;
var
    r: IJsonRpcParsed;
    mt: TJsonRpcObjectType;
    str_payload: string;
    rx: ISuperObject;
begin
    r := pipe_conn.GetResponse(method, params);
    if not Assigned(r) then
        raise Exception.Create(Format('%s%s: unexpected nil response',
          [method, params.AsString]));

    if not Assigned(r.GetMessagePayload) then
        raise Exception.Create(Format('%s%s: unexpected nil message payload',
          [method, params.AsString]));

    rx := r.GetMessagePayload.AsJsonObject;

    if not Assigned(r.GetMessagePayload) then
        raise Exception.Create
          (Format('%s%s: unexpected nil message json object',
          [method, params.AsString]));

    if Assigned(rx['result']) then
        exit(rx['result']);

    if Assigned(rx['error.message']) then
        raise Exception.Create(rx['error'].S['message']);

    str_payload := '';
    if Assigned(r.GetMessagePayload) then
        str_payload := r.GetMessagePayload.AsJson(true, true);

    raise Exception.Create(Format('%s%s'#13'%s'#13'%s',
      [method, params.AsString, str_payload, formatMessagetype(r.GetMessageType)]));

end;

end.
