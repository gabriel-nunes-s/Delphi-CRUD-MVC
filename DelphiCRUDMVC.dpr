program DelphiCRUDMVC;

uses
  Vcl.Forms,
  uFrmMain in 'src\view\uFrmMain.pas' {FrmMain},
  uFrmBaseForm in 'src\view\uFrmBaseForm.pas' {FrmCustomerRegister},
  uFrmCustomers in 'src\view\uFrmCustomers.pas' {FrmCustomerRegister1},
  uCustomerModel in 'src\model\uCustomerModel.pas',
  uCustomerController in 'src\controller\uCustomerController.pas',
  uDmConnection in 'src\dao\uDmConnection.pas' {dmConnection: TDataModule},
  uDmCustomer in 'src\dao\uDmCustomer.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TdmConnection, dmConnection);
  Application.Run;
end.
