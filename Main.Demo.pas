unit Main.Demo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMainDemo = class(TForm)
    btnGerarJson: TButton;
    btnCarregarJson: TButton;
    MemoJSON: TMemo;
    MemoLog: TMemo;
    procedure btnGerarJsonClick(Sender: TObject);
    procedure btnCarregarJsonClick(Sender: TObject);
  private
    procedure Log(const AMsg: string);
  public
  end;

var
  FormMainDemo: TMainDemo;

implementation

uses
  Model.Lancamento, Service.JSONUtils, APi.Types.Optional;

{$R *.dfm}

procedure TMainDemo.Log(const AMsg: string);
begin
  MemoLog.Lines.Add(FormatDateTime('hh:nn:ss.zzz', Now) + ' - ' + AMsg);
end;

procedure TMainDemo.btnGerarJsonClick(Sender: TObject);
var
  Payload: TLancamentoPayload;
begin
  Payload := TLancamentoPayload.Create;
  try
    Payload.ParceiroId := 123;
    Payload.FilialId := 0;
    Payload.ClassificacaoId := 0;
    Payload.NumeroDocumento := 'ABC123';
    Payload.DataVencimento := '2025-01-15';
    Payload.DataCompetencia := '2025-01-01';
    Payload.Valor := 250.5;
    Payload.Pago := False;
    Payload.ContaBancariaId := TOptional<Integer>.Empty;
    Payload.DataPagamento := TOptional<string>.Empty;

    MemoJSON.Lines.Text := TJSONUtils.Serialize(Payload);
    Log('JSON gerado com sucesso.');
  finally
    Payload.Free;
  end;
end;

procedure TMainDemo.btnCarregarJsonClick(Sender: TObject);
var
  JSONStr: string;
  Lancamento: TLancamentoPayload;
begin
  JSONStr := MemoJSON.Lines.Text;
  Lancamento := TJSONUtils.Deserialize<TLancamentoPayload>(JSONStr);
  try
    Log('Leitura concluída. Documento: ' + Lancamento.NumeroDocumento);
  finally
    Lancamento.Free;
  end;
end;

end.
