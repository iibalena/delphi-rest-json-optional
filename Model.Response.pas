unit Model.Response;

interface

uses
  System.Classes;

type
  TResponseData = class
  public
    id: Integer;
    status: string;
  end;

  TAPIResponse = class
  public
    success: Boolean;
    message: string;
    body: TResponseData;
    destructor Destroy; override;
  end;

implementation

{ TAPIResponse }

destructor TAPIResponse.Destroy;
begin
  body.Free;
  inherited;
end;

end.
