unit API.Types.Optional;

interface

uses
  System.SysUtils,
  System.Rtti,
  System.Variants,
  System.TypInfo;

type
  TOptional<T> = record
  private
    FHasValue: Boolean;
    FValue: T;
  public
    class function Create(const AValue: T): TOptional<T>; static;
    class function Empty: TOptional<T>; static;
    function HasValue: Boolean;
    function GetValue: T;
    function ValueOrNull: Variant;

    class operator Implicit(const AValue: T): TOptional<T>;
    class operator Implicit(const AOptional: TOptional<T>): T;
  end;

implementation

{ TOptional<T> }

class function TOptional<T>.Create(const AValue: T): TOptional<T>;
var
  ctx: TRttiContext;
  rttiType: TRttiType;
begin
  Result.FValue := AValue;
  Result.FHasValue := True;

  ctx := TRttiContext.Create;
  try
    rttiType := ctx.GetType(TypeInfo(T));

    if rttiType.TypeKind = tkInteger then
    begin
      if TValue.From<T>(AValue).AsInteger = 0 then
        Result.FHasValue := False;
    end
    else if rttiType.TypeKind = tkFloat then
    begin
      if TValue.From<T>(AValue).AsExtended = 0 then
        Result.FHasValue := False;
    end
    else if rttiType.TypeKind = tkUString then
    begin
      if TValue.From<T>(AValue).AsString = '' then
        Result.FHasValue := False;
    end
    else if rttiType.TypeKind in [tkChar, tkWChar, tkString] then
    begin
      if TValue.From<T>(AValue).AsString = '' then
        Result.FHasValue := False;
    end
    else if rttiType.TypeKind = tkEnumeration then
    begin
      if (rttiType.Handle = TypeInfo(Boolean)) and (TValue.From<T>(AValue).AsBoolean = False) then
        Result.FHasValue := False;
    end;

  finally
    ctx.Free;
  end;
end;

class function TOptional<T>.Empty: TOptional<T>;
begin
  Result.FHasValue := False;
end;

function TOptional<T>.GetValue: T;
begin
  if not FHasValue then
    raise Exception.Create('TOptional: Valor não definido');
  Result := FValue;
end;

function TOptional<T>.HasValue: Boolean;
begin
  Result := FHasValue;
end;

class operator TOptional<T>.Implicit(const AValue: T): TOptional<T>;
begin
  Result := TOptional<T>.Create(AValue);
end;

class operator TOptional<T>.Implicit(const AOptional: TOptional<T>): T;
begin
  Result := AOptional.GetValue;
end;

function TOptional<T>.ValueOrNull: Variant;
begin
  if not FHasValue then
    Result := Null
  else
    Result := TValue.From<T>(FValue).AsVariant;
end;

end.
