unit API.Types.Optional;

interface

uses
  System.SysUtils,
  System.Rtti,
  System.Variants;

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
begin
  Result.FHasValue := True;
  Result.FValue := AValue;
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
