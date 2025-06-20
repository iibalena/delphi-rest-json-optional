# 🚀 Delphi REST JSON Optional

> 🇺🇸 [Read this in English](./README.en.md)

> Projeto de exemplo em Delphi demonstrando serialização JSON com campos opcionais e arquitetura limpa de API.

[![Delphi](https://img.shields.io/badge/Delphi-11.3-red.svg)](https://www.embarcadero.com/products/delphi)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](#)

---

## 📌 Sobre o projeto

Este é um projeto de demonstração em Delphi (VCL) que mostra como:

- Usar tipos opcionais (`TOptional<T>`) com suporte a serialização
- Gerar JSON ignorando ou incluindo campos `null`
- Separar modelos de payload (envio) e resposta (retorno da API)
- Utilizar RTTI com `published` para serialização
- Integrar com um serviço HTTP centralizado e reutilizável

---

## 🗂 Estrutura

```
DelphiRestJsonOptional/
├── API.Abstract.Service.pas       # Serviço base para requisições
├── API.Lancamento.Service.pas     # Exemplo de requisição de lançamento
├── API.Types.Optional.pas         # Tipagem genérica TOptional<T>
├── DelphiRestJsonOptional.dpr     # Projeto Delphi principal (VCL)
├── README.md                      # Este arquivo
```

---

## ✅ Como usar `TOptional<T>`
---

## 🔄 Conversão Implícita e Explícita com TOptional<T>

A classe `TOptional<T>` suporta conversões automáticas (implícitas) para facilitar seu uso no código:

### ✅ De valor comum para TOptional<T>

```delphi
Payload.ContaBancariaId := 123;
// Equivalente a:
Payload.ContaBancariaId := TOptional<Integer>.Create(123);
```

### ✅ De TOptional<T> para valor comum

```delphi
var
  id: Integer;
begin
  if Payload.ContaBancariaId.HasValue then
    id := Payload.ContaBancariaId;
// Equivalente a:
  id := Payload.ContaBancariaId.GetValue;
```

### ⚠️ Importante

Se `HasValue = False`, a conversão para tipo comum lança uma exceção.
Portanto, sempre valide com `HasValue` antes de acessar o valor diretamente.



Este projeto utiliza o tipo genérico `TOptional<T>` para indicar campos opcionais de forma clara e controlada.

### 📌 Exemplos:

```delphi
// Inteiro com valor (irá serializar como número)
Payload.ContaBancariaId := TOptional<Integer>.Create(123);

// Inteiro sem valor (irá serializar como null)
Payload.ContaBancariaId := TOptional<Integer>.Create(0); // Será tratado como null
// ou de forma explícita:
Payload.ContaBancariaId := TOptional<Integer>.Empty;

// String com valor (irá serializar normalmente)
Payload.NumeroDocumento := TOptional<string>.Create('ABC123');

// String vazia (irá serializar como null)
Payload.NumeroDocumento := TOptional<string>.Create('');
```

O tipo `TOptional<T>` é interpretado automaticamente com base no tipo e valor:
- Para inteiros e floats: `0` é tratado como ausência de valor
- Para strings: `''` é tratado como ausência de valor
- Também é possível usar `TOptional<T>.Empty` para expressar explicitamente que o valor é nulo

---
## ✅ Funcionalidades

1. O botão **"Gerar JSON"** cria um objeto com dados preenchidos
2. Serializa usando RTTI + suporte a campos opcionais (`TOptional<T>`)
3. O botão **"Carregar JSON"** simula a leitura de resposta da API
4. Desserializa o JSON e preenche o objeto de resposta

---

## 🛠 Requisitos

- Delphi **11.3** ou superior
- Projeto **VCL Forms Application**

---

## 🧪 Como executar

1. Abra o projeto `DelphiRestJsonOptional.dpr` no Delphi
2. Compile e execute
3. Clique em **"Gerar JSON"** para criar a estrutura de envio
4. Edite o JSON se desejar e clique em **"Carregar JSON"**

---

## 💡 Motivação

Muitas APIs modernas distinguem claramente campos com valor zero (`0`, `''`) de campos `null`, e isso nem sempre é fácil de lidar no Delphi.

Este projeto apresenta uma abordagem leve e compatível com edições **Professional** do Delphi (sem `JSONInterceptor`), usando RTTI e um tipo genérico `TOptional<T>` para controlar de forma explícita o que deve ou não ser serializado.

---

## 📤 Exemplo de saída JSON

```json
{
  "parceiro_id": 123,
  "empresa_filial_unidade_id": 0,
  "classificacao_id": 0,
  "numero_documento": "ABC123",
  "data_vencimento": "2025-01-15",
  "data_competencia": "2025-01-01",
  "valor": 250.5,
  "pago": false,
  "conta_bancaria_id": null,
  "data_pagamento": null
}
```

---

## 🤝 Contribuições

Contribuições, sugestões ou dúvidas são muito bem-vindas!  
Sinta-se à vontade para abrir uma issue ou enviar um pull request.

---

## 👤 Autor

Criado por [Ivonei Balena](mailto:iibalena@gmail.com)  
[LinkedIn](https://www.linkedin.com/in/ivonei-balena-a9a26465/)

---

## 📄 Licença

Este projeto está licenciado sob os termos da [MIT License](LICENSE).
