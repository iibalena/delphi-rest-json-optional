unit Model.Lancamento;

interface

uses
  System.Classes, API.Types.Optional;

type
  TLancamentoPayload = class(TPersistent)
  private
    FParceiroId: Integer;
    FEmpresaFilialUnidadeId: Integer;
    FClassificacaoId: Integer;
    FNumeroDocumento: string;
    FDataVencimento: string;
    FDataCompetencia: string;
    FValor: Double;
    FPago: Boolean;
    FContaBancariaId: TOptional<Integer>;
    FDataPagamento: TOptional<string>;
  published
    property ParceiroId: Integer read FParceiroId write FParceiroId;
    property FilialId: Integer read FEmpresaFilialUnidadeId write FEmpresaFilialUnidadeId;
    property ClassificacaoId: Integer read FClassificacaoId write FClassificacaoId;
    property NumeroDocumento: string read FNumeroDocumento write FNumeroDocumento;
    property DataVencimento: string read FDataVencimento write FDataVencimento;
    property DataCompetencia: string read FDataCompetencia write FDataCompetencia;
    property DataPagamento: TOptional<string> read FDataPagamento write FDataPagamento;
    property ContaBancariaId: TOptional<Integer> read FContaBancariaId write FContaBancariaId;
    property Valor: Double read FValor write FValor;
    property Pago: Boolean read FPago write FPago;
  end;

  TLancamentoResponse = class(TLancamentoPayload)
  private
    FId: Integer;
  published
    property Id: Integer read FId write FId;
  end;

implementation

end.
