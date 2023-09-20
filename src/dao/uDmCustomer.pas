unit uDmCustomer;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, Data.SqlExpr, uDmConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uCustomerModel;

type
  TDataModule1 = class(TDataModule)
    FDQuerySearch: TFDQuery;
    FDQueryInsert: TFDQuery;
    FDQueryModify: TFDQuery;
    FDQueryDelete: TFDQuery;
    FDQuerySearchID: TIntegerField;
    FDQuerySearchNAME: TStringField;
    FDQuerySearchPHONE: TStringField;
  private
    
  public
    function GenerateID: Integer;
    procedure Search (sNome: String);
    procedure LoadCustomer (oCustomer: TCustomer; iCode: Integer);
    function Insert(oCustomer: TCustomer; out sError: String): Boolean;
    function Modify(oCustomer: TCustomer; out sError: String): Boolean;
    function Delete(iCode: Integer; out sError: String): Boolean;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TDataModule1.Delete(iCode: Integer; out sError: String): Boolean;
begin
  with FDQueryDelete do
  begin
    Params[0].AsInteger := iCode;
    try
      ExecSQL();
      Result := False;
    except on E: Exception do
      begin
        sError := 'An error occured when deleting the customer: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;

  end;
end;

function TDataModule1.GenerateID: Integer;
var
  sqlSequencia: TFDQuery;
begin
  sqlSequencia := TFDQuery.Create(nil);
  try
    // Configurando o comando SQL para obter a próxima sequência numérica para um novo cliente na tabela CUSTOMER.
    // Calcula o valor máximo da coluna 'id' na tabela e adiciona 1
    with sqlSequencia do
    begin
      Connection := dmConnection.FDConnection;
      SQL.Text := 'select coalesce(max(id), 0) + 1 as seq from CUSTOMER';
      Open;
      Result := sqlSequencia.FieldByName('seq').AsInteger;
    end;
  finally
    FreeAndNil(sqlSequencia);
  end;
end;

function TDataModule1.Insert(oCustomer: TCustomer; out sError: String): Boolean;
begin
  with FDQueryInsert, oCustomer do
  begin
    Params[0].AsInteger := GenerateID;
    Params[1].AsString := Name;
    Params[2].AsString := TypeCustomer;
    Params[3].AsString := Document;
    Params[4].AsString := Phone;

    try
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sError := 'An error occured when inserting the customer: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;

  end;
end;

procedure TDataModule1.LoadCustomer(oCustomer: TCustomer; iCode: Integer);
var
  sqlCustomer: TFDQuery;
begin
  sqlCustomer := TFDQuery.Create(nil);
  try
    with sqlCustomer do
    begin
      Connection := dmConnection.FDConnection;
      SQL.Text := 'select * from CUSTOMER where (id = :code)';
      Params.ParamByName('code').AsInteger := iCode;
      Open;

      if not sqlCustomer.IsEmpty then
      begin
        //atribuindo dados ao objeto
        with oCustomer do
          begin
            ID := FieldByName('ID').AsInteger;
            Name := FieldByName('NAME').AsString;
            TypeCustomer := FieldByName('TYPE').AsString;
            Document := FieldByName('DOCUMENT').AsString;
            Phone := FieldByName('PHONE').AsString; 
          end;
      end;
      
    end;
  finally
    FreeAndNil(sqlCustomer);
  end;
end;

function TDataModule1.Modify(oCustomer: TCustomer; out sError: String): Boolean;
begin
  with FDQueryModify, oCustomer do
  begin
    Params[0].AsInteger := ID;
    Params[1].AsString := Name;
    Params[2].AsString := TypeCustomer;
    Params[3].AsString := Document;
    Params[4].AsString := Phone;

    try
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sError := 'An error occured when modifying the customer: ' + sLineBreak + E.Message;
      Result := False;
      end;
    end;

  end;
end;

procedure TDataModule1.Search(sNome: String);
begin
  if FDQuerySearch.Active then
    FDQuerySearch.Close;

  FDQuerySearch.Params[0].AsString := '%' + sNome + '%';
  FDQuerySearch.Open;
  FDQuerySearch.First;
end;

end.
