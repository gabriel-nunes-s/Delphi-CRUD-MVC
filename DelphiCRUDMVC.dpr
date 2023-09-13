program DelphiCRUDMVC;

uses
  Vcl.Forms,
  uFrmMain in 'src\view\uFrmMain.pas' {FrmMain},
  uFrmBaseForm in 'src\view\uFrmBaseForm.pas' {FrmCustomerRegister};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmCustomerRegister, FrmCustomerRegister);
  Application.Run;
end.
