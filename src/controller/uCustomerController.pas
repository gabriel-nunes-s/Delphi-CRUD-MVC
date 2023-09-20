unit uCustomerController;

interface

uses
  uCustomerModel, uDmCustomer, System.SysUtils;

type
  TCustomerController = class
  
  public
    constructor Create;
    destructor Destroy; override;
    procedure Search(sName: String);
    procedure LoadCustomer(oCustomer: TCustomer; iCode: Integer);
    function Insert(oCustomer: TCustomer; var sError: String): Boolean;
    function Modify(oCustomer: TCustomer; var sError: String): Boolean;
    function Delete(iCode: Integer; var sError: String): Boolean;
  end;

implementation

{ TCustomerController }

constructor TCustomerController.Create;
begin
  DataModule1 := TDataModule1.Create(nil);
end;

function TCustomerController.Delete(iCode: Integer;
  var sError: String): Boolean;
begin
  Result := DataModule1.Delete(iCode, sError);
end;

destructor TCustomerController.Destroy;
begin
  FreeAndNil(DataModule1);
  inherited;
end;

function TCustomerController.Insert(oCustomer: TCustomer;
  var sError: String): Boolean;

begin
  Result := DataModule1.Insert(oCustomer, sError);
end;

procedure TCustomerController.LoadCustomer(oCustomer: TCustomer;
  iCode: Integer);
begin
  DataModule1.LoadCustomer(oCustomer, iCode);
end;

function TCustomerController.Modify(oCustomer: TCustomer;
  var sError: String): Boolean;
begin
  Result := DataModule1.Modify(oCustomer, sError);
end;

procedure TCustomerController.Search(sName: String);
begin
  DataModule1.Search(sName);
end;

end.
