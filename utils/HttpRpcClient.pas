unit HttpRpcClient;

interface

uses superobject, System.sysutils;

type

    ThttpRpcClient = record
        class procedure Call<T>(url, method: string; params: ISuperobject;
          var AResult: T); static;
        class function GetResponse(url, method: string; params: ISuperobject)
          : ISuperobject; static;
    end;

var

    { Timeout for operations }
    TIMEOUT_CONNECT : integer = 500;
    TIMEOUT_RECV : integer = 10000;

implementation

uses HttpExceptions, registry, winapi.windows,
    ujsonrpc, classes, System.Net.URLClient, Grijjy.Http,
    Grijjy.Bson.Serialization;



class procedure ThttpRpcClient.Call<T>(url, method: string; params: ISuperobject;
  var AResult: T);
var
    json: string;
begin
    json := ThttpRpcClient.GetResponse(url, method, params).AsJSon;
    TgoBsonSerializer.Deserialize(json, AResult);

end;

function formatMessagetype(mt: TJsonRpcObjectType): string;
begin
    case mt of
        jotInvalid:
            exit('invalid');
        jotRequest:
            exit('request');
        jotNotification:
            exit('notification');
        jotSuccess:
            exit('success');
        jotError:
            exit('error');
    end;
end;

class function ThttpRpcClient.GetResponse(url, method: string; params: ISuperobject)
  : ISuperobject;
var
    Http: TgoHttpClient;
    JsonRpcParsedResponse: IJsonRpcParsed;
    rx: ISuperobject;
    AResponse: TBytes;

begin
    Http := TgoHttpClient.Create(False, True);
    try
        Http.RequestHeaders.AddOrSet('Content-Type', 'application/json');
        Http.RequestHeaders.AddOrSet('Accept', 'application/json');
        Http.RequestBody := TJsonRpcMessage.request(0, method, params).AsJSon;

        if not Http.Post(url, AResponse, TIMEOUT_CONNECT,
          TIMEOUT_RECV) then
            raise ERpcNoResponseException.Create('��� ����� � ���� ���������');

        if Http.ResponseStatusCode <> 200 then
            raise ERpcHTTPException.Create
              ('HTTP: ' + Inttostr(Http.ResponseStatusCode));

        JsonRpcParsedResponse := TJsonRpcMessage.Parse
          (TEncoding.UTF8.GetString(AResponse));

        if not Assigned(JsonRpcParsedResponse) then
            raise ERpcWrongResponseException.Create
              (Format('%s%s: unexpected nil response',
              [method, params.AsString]));

        if not Assigned(JsonRpcParsedResponse.GetMessagePayload) then
            raise ERpcWrongResponseException.Create
              (Format('%s%s: unexpected nil message payload',
              [method, params.AsString]));

        rx := JsonRpcParsedResponse.GetMessagePayload.AsJsonObject;

        if Assigned(rx['result']) then
        begin
            result := rx['result'];
            exit;
        end;

        if Assigned(rx['error.message']) then
            raise ERpcRemoteErrorException.Create
            (Format('%s%s: %s',
              [method, params.AsString, rx['error'].S['message']]));

        raise ERpcWrongResponseException.Create
          (Format('%s%s'#13'%s'#13'message type: %s', [method, params.AsString,
          JsonRpcParsedResponse.GetMessagePayload,
          formatMessagetype(JsonRpcParsedResponse.GetMessageType)]));

    finally
        HttpClientManager.Release(Http);
    end;
end;

end.

// function GetResponse(method: string; params: ISuperobject): ISuperobject;
// var
// HttpClient: THTTPClient;
// requestStream: TStringStream;
// response: IHTTPResponse;
// headers: TNetHeaders;
// JsonRpcParsedResponse: IJsonRpcParsed;
// rx: ISuperObject;
// begin
// try
//
// HttpClient := THTTPClient.Create();
//
// SetLength(headers, 2);
// headers[0].Name := 'Content-Type';
// headers[0].Value := 'application/json';
// headers[1].Name := 'Accept';
// headers[1].Value := 'application/json';
//
// requestStream := TStringStream.Create(TJsonRpcMessage.request(0, method,
// params).AsJSon);
//
// response := HttpClient.Post(_httpaddr + '/rpc', requestStream,
// nil, headers);
//
// if response.StatusCode <> 200 then
// raise Exception.Create(Inttostr(response.StatusCode) + ': ' +
// response.StatusText);
//
// JsonRpcParsedResponse := TJsonRpcMessage.Parse
// (response.ContentAsString);
//
// if not Assigned(JsonRpcParsedResponse) then
// raise Exception.Create(Format('%s%s: unexpected nil response',
// [method, params.AsString]));
//
// if not Assigned(JsonRpcParsedResponse.GetMessagePayload) then
// raise Exception.Create
// (Format('%s%s: unexpected nil message payload',
// [method, params.AsString]));
//
// rx := JsonRpcParsedResponse.GetMessagePayload.AsJsonObject;
//
// if Assigned(rx['result']) then
// begin
// result := rx['result'];
// exit;
// end;
//
// if Assigned(rx['error.message']) then
// raise ERemoteError.Create(rx['error'].S['message']);
//
// raise Exception.Create(Format('%s%s'#13'%s'#13'message type: %s',
// [method, params.AsString, JsonRpcParsedResponse.GetMessagePayload,
// formatMessagetype(JsonRpcParsedResponse.GetMessageType)]));
//
// finally
// HttpClient.Free;
// requestStream.Free;
// end;
// end;

end.
