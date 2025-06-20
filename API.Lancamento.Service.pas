unit API.Lancamento.Service;

interface

uses
  System.Generics.Collections,
  API.Abstract.Service,
  Model.Lancamento,
  Model.Response;

type
  TAPILancamentoService = class
  public
    class function Cadastrar(const APayload: TLancamentoPayload): TAPIResponse;
  end;

implementation

uses
  System.SysUtils;

{ TAPILancamentoService }

class function TAPILancamentoService.Cadastrar(const APayload: TLancamentoPayload): TAPIResponse;
var
  FileName: string;
  Headers: TDictionary<string, string>;
  Token: string;
begin
  Token := 'XXXXXXX'; // Substitua pelo seu token real

  FileName := Format('lancamento-%s', [APayload.NumeroDocumento]);

  Headers := TDictionary<string, string>.Create;
  try
    // Ideal é que se tenha uma classe ainda intermediária que vai centralizar a lógica de headers e token
    Headers.Add('Authorization', 'Bearer ' + Token);
    Headers.Add('Content-Type', 'application/json');

    try
      Result := TAPIBaseService<TLancamentoPayload, TAPIResponse>.Post('https://httpbin.org/post',
        APayload, Headers, 'lancamentos', FileName);

    except
      on E: Exception do
        raise E;
    end;
  finally
    Headers.Free;
  end;
end;

end.
