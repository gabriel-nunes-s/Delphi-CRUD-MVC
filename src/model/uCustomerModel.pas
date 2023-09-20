unit uCustomerModel;

interface
uses System.SysUtils;

type
  TCustomer = class
  private
    FType: String;
    FName: String;
    FDocument: String;
    FPhone: String;
    FID: Integer;
    procedure SetName(const Value: String);
  public
    // "getters" and "setters"
    property ID: Integer read FID write FID;
    property Name: String read FName write SetName;
    property TypeCustomer: String read FType write FType;
    property Document: String read FDocument write FDocument;
    property Phone: String read FPhone write FPhone;
  end;

implementation

{ TCustomer }

procedure TCustomer.SetName(const Value: String);
begin
  if Value = EmptyStr then //if Value is empty
    raise EArgumentException.Create('"Name" is a obrigatory field!');

  FName := Value;
end;

end.
