unit API.Abstract.Service;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.JSON,
  Service.JSONUtils, System.Generics.Collections;

type
  TAPIBaseService<TRequest: class; TResponse: class, constructor> = class
  public
    class function Post(
      const AUrl: string;
      const AData: TRequest;
      const AHeaders: TDictionary<string, string> = nil;
      const ADirectoryFileName: String = '';
      const AFileName: String = ''
    ): TResponse;
  end;

implementation

{ TAPIBaseService<TRequest, TResponse> }

uses
  API.LoggerHelper;

class function TAPIBaseService<TRequest, TResponse>.Post(
  const AUrl: string;
  const AData: TRequest;
  const AHeaders: TDictionary<string, string>;
  const ADirectoryFileName: String;
  const AFileName: String
): TResponse;
var
  Client: THTTPClient;
  Response: IHTTPResponse;
  JsonRequest: string;
  JsonResponse: string;
  Stream: TStringStream;
  Header: TPair<string, string>;
begin
  Result := nil;
  Client := THTTPClient.Create;
  try
    JsonRequest := TJSONUtils.Serialize(AData);

    if (AFileName <> '') then
      SaveLogJSON(ADirectoryFileName, AFileName, 'req', JsonRequest, 'POST');

    Stream := TStringStream.Create(JsonRequest, TEncoding.UTF8);
    try
      if AHeaders <> nil then
        for Header in AHeaders do
          Client.CustomHeaders[Header.Key] := Header.Value;

      Response := Client.Post(AUrl, Stream);
      JsonResponse := Response.ContentAsString(TEncoding.UTF8);

      if (AFileName <> '') then
        SaveLogJSON(ADirectoryFileName, AFileName, 'res', JsonResponse, 'POST');

      if Response.StatusCode <> 200 then
        raise Exception.CreateFmt('Erro ao enviar requisição: %s', [Response.StatusText]);

      Result := TJSONUtils.Deserialize<TResponse>(JsonResponse);
    finally
      Stream.Free;
    end;
  finally
    Client.Free;
  end;
end;



end.

