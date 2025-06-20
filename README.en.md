# 🚀 Delphi REST JSON Optional

> 🇧🇷 [Leia este README em português](./README.md)

> Example project in Delphi demonstrating JSON serialization with optional fields and clean API architecture.

[![Delphi](https://img.shields.io/badge/Delphi-11.3-red.svg)](https://www.embarcadero.com/products/delphi)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](#)

---

## 📌 About the Project

This is a demo project using Delphi (VCL) that demonstrates how to:

- Use generic optional types (`TOptional<T>`) with serialization support
- Generate JSON including or omitting `null` fields
- Separate payload (request) and response models
- Use RTTI with `published` properties for serialization
- Integrate with a clean and reusable HTTP service layer

---

## 🗂 Structure

```
DelphiRestJsonOptional/
├── API.Abstract.Service.pas       # Base HTTP service
├── API.Lancamento.Service.pas     # Example for posting data
├── API.Types.Optional.pas         # Generic type definition: TOptional<T>
├── DelphiRestJsonOptional.dpr     # Main Delphi VCL project
├── README.md                      # This file (Portuguese)
├── README.en.md                   # English version
```

---

## ✅ How to use `TOptional<T>`

This project uses the generic type `TOptional<T>` to clearly and reliably handle optional fields.

### 📌 Examples:

```delphi
// Integer with value (will be serialized as a number)
Payload.ContaBancariaId := TOptional<Integer>.Create(123);

// Integer with no value (will be serialized as null)
Payload.ContaBancariaId := TOptional<Integer>.Create(0); // Interpreted as null
// or explicitly:
Payload.ContaBancariaId := TOptional<Integer>.Empty;

// String with value
Payload.NumeroDocumento := TOptional<string>.Create('ABC123');

// Empty string (will be serialized as null)
Payload.NumeroDocumento := TOptional<string>.Create('');
```

The type `TOptional<T>` automatically interprets the content:
- For numeric types: `0` is treated as no value
- For strings: `''` (empty string) is treated as no value
- You can use `TOptional<T>.Empty` to explicitly mark a value as `null`

---

## ✅ Features

1. The **"Generate JSON"** button creates an object with preset values  
2. Serializes it using RTTI + `TOptional<T>` handling  
3. The **"Load JSON"** button simulates API response reading  
4. Deserializes the JSON and fills the response object

---

## 🛠 Requirements

- Delphi **11.3** or higher
- VCL Forms Application project

---

## 🧪 How to run

1. Open the project `DelphiRestJsonOptional.dpr` in Delphi  
2. Compile and run  
3. Click **"Generate JSON"** to see the request payload  
4. Optionally edit the JSON and click **"Load JSON"**

---

## 💡 Why use this?

Many modern APIs differentiate between `0`, `''` and `null` values — and handling this properly in Delphi is often challenging.

This project provides a lightweight solution fully compatible with **Delphi Professional** (no `JSONInterceptor` needed), using RTTI and a generic optional wrapper type `TOptional<T>`.

---

## 📤 Example JSON Output

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

## 🤝 Contributions

Suggestions, feedback, and contributions are welcome!  
Feel free to open an issue or submit a pull request.

---

## 👤 Author

Created by [Ivonei Balena](mailto:iibalena@gmail.com)  
[LinkedIn](https://www.linkedin.com/in/ivonei-balena-a9a26465/)

---

## 📄 License

This project is licensed under the terms of the [MIT License](LICENSE).
