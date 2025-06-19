# Delphi REST JSON Optional

> Projeto de exemplo em Delphi demonstrando serialização JSON com campos opcionais e arquitetura limpa de API.  
> Example Delphi project demonstrating JSON serialization with optional fields and clean API architecture.

Este é um projeto de demonstração em Delphi (VCL) que mostra como:

- Usar tipos opcionais (`TOptional<T>`) com suporte a serialização
- Gerar JSON ignorando ou incluindo campos `null`
- Separar modelos de payload (envio) e resposta (retorno da API)
- Utilizar RTTI com `published` para serialização
- Integrar com um serviço HTTP centralizado e reutilizável

## 📁 Estrutura

```
Delphi-REST-JSON-Optional/
├── Source/
│   ├── Main.Demo.pas              # Formulário VCL de demonstração
│   ├── Model.Lancamento.pas      # Estrutura dos modelos base/payload/retorno
│   ├── Service.JSONUtils.pas     # Serialização/Deserialização
│   └── API.Abstract.Service.pas  # Serviço base com chamadas HTTP
```

## 🚀 Requisitos

- Delphi 11.3
- Projeto VCL Forms

## ✅ O que o exemplo faz

1. O botão "Gerar JSON" cria um objeto com dados preenchidos
2. Serializa usando RTTI + suporte a campos opcionais (TOptional)
3. O botão "Carregar JSON" simula a leitura de resposta da API
4. Desserializa o JSON e preenche o objeto de resposta

## 🔧 Como usar

1. Abra o projeto no Delphi
2. Compile e execute
3. Clique em "Gerar JSON" para gerar a estrutura de envio
4. Edite o JSON se desejar e clique em "Carregar JSON"

## 💡 Aprendizado

Este projeto também é voltado especialmente para desenvolvedores Delphi que já enfrentaram dificuldade em gerar JSON com campos nulos quando não há valor válido disponível — algo necessário em integrações com APIs que diferenciam entre "zero" e "null".

Além disso, a abordagem adotada aqui é compatível com edições como o Delphi Professional, que não possuem suporte a recursos como JSON Interceptors nativos (presentes apenas em versões Enterprise/Architect), oferecendo uma alternativa leve e compatível baseada em RTTI e lógica explícita.

Este projeto serve como referência para:

- Desenvolvedores Delphi que querem controlar serialização condicional
- APIs que precisam omitir campos em branco ou zerados
- Arquiteturas que separam DTOs de envio e retorno

## 🧾 Exemplo de saída JSON

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

📬 Contribuições, sugestões ou dúvidas são bem-vindas!

---

Criado por [Ivonei Balena](mailto:iibalena@gmail.com)
