unit Service.JSONUtils;

interface

uses
  System.JSON,
  System.Rtti,
  System.SysUtils,
  System.TypInfo,
  System.Variants,
  REST.JSON,
  API.Types.Optional;

type
  TJSONUtils = class
  public
    class function Serialize(const AObject: TObject): string; static;
    class function Deserialize<T: class, constructor>(const AJson: string): T; static;
  end;

implementation

{ TJSONUtils }

class function TJSONUtils.Serialize(const AObject: TObject): string;
var
  ctx: TRttiContext;
  rType: TRttiType;
  prop: TRttiProperty;
  val: TValue;
  JSON: TJSONObject;
  pair: TJSONPair;
  optVal: Variant;
  tmpInt: TOptional<Integer>;
  tmpStr: TOptional<string>;
  tmpDbl: TOptional<Double>;
  tmpBool: TOptional<Boolean>;
  isOptional: Boolean;
begin
  JSON := TJSONObject.Create;
  ctx := TRttiContext.Create;
  try
    rType := ctx.GetType(AObject.ClassType);

    for prop in rType.GetProperties do
    begin
      if not prop.IsReadable then
        Continue;

      val := prop.GetValue(AObject);
      isOptional := False;

      if val.TryAsType < TOptional < Integer >> (tmpInt) then
      begin
        optVal := tmpInt.ValueOrNull;
        isOptional := True;
      end
      else if val.TryAsType < TOptional < string >> (tmpStr) then
      begin
        optVal := tmpStr.ValueOrNull;
        isOptional := True;
      end
      else if val.TryAsType < TOptional < Double >> (tmpDbl) then
      begin
        optVal := tmpDbl.ValueOrNull;
        isOptional := True;
      end
      else if val.TryAsType < TOptional < Boolean >> (tmpBool) then
      begin
        optVal := tmpBool.ValueOrNull;
        isOptional := True;
      end;

      if isOptional then
      begin
        if VarIsNull(optVal) then
          pair := TJSONPair.Create(prop.Name, TJSONNull.Create)
        else if VarIsStr(optVal) then
          pair := TJSONPair.Create(prop.Name, TJSONString.Create(optVal))
        else if VarIsNumeric(optVal) then
          pair := TJSONPair.Create(prop.Name, TJSONNumber.Create(string(optVal)))
        else if VarType(optVal) = varBoolean then
          pair := TJSONPair.Create(prop.Name, TJSONBool.Create(optVal))
        else
          Continue;

        JSON.AddPair(pair);
        Continue;
      end;

      // Propriedades comuns
      case val.Kind of
        tkInteger:
          JSON.AddPair(prop.Name, TJSONNumber.Create(val.AsInteger));
        tkFloat:
          JSON.AddPair(prop.Name, TJSONNumber.Create(FloatToStr(val.AsExtended, TFormatSettings.Invariant)));
          // inclui TDateTime
        tkString, tkUString, tkWString:
          JSON.AddPair(prop.Name, TJSONString.Create(val.AsString));
        tkEnumeration:
          if val.TypeInfo = TypeInfo(Boolean) then
            JSON.AddPair(prop.Name, TJSONBool.Create(val.AsBoolean))
          else
            JSON.AddPair(prop.Name, TJSONString.Create(val.ToString));
      end;
    end;

    Result := JSON.ToJSON;
  finally
    ctx.Free;
    JSON.Free;
  end;
end;

class function TJSONUtils.Deserialize<T>(const AJson: string): T;
begin
  Result := TJson.JsonToObject<T>(AJson);
end;

end.
