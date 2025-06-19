unit API.Abstract.Service;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.JSON,
  Service.JSONUtils;

type
  TAPIBaseService<TRequest: class; TResponse: class, constructor> = class
  public
    class function Post(const AUrl: string; const AData: TRequest): TResponse;
  end;

implementation

{ TAPIBaseService<TRequest, TResponse> }

class function TAPIBaseService<TRequest, TResponse>.Post(const AUrl: string; const AData: TRequest): TResponse;
var
  Client: THTTPClient;
  Response: IHTTPResponse;
  JsonRequest: string;
  JsonResponse: string;
  RequestStream: TStringStream;
begin
  Result := nil;
  Client := THTTPClient.Create;
  RequestStream := nil;
  try
    JsonRequest := TJSONUtils.ObjectToJsonString(AData);
    RequestStream := TStringStream.Create(JsonRequest, TEncoding.UTF8);
    Client.CustomHeaders['Content-Type'] := 'application/json';

    Response := Client.Post(AUrl, RequestStream);

    if Response.StatusCode <> 200 then
      raise Exception.CreateFmt('Erro ao enviar requisição: %s', [Response.StatusText]);

    JsonResponse := Response.ContentAsString(TEncoding.UTF8);
    Result := TJSONUtils.Deserialize<TResponse>(JsonResponse);
  finally
    RequestStream.Free;
    Client.Free;
  end;
end;

end.
