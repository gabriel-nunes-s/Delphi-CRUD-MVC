unit uFrmBaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.WinXCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrmCustomerRegister = class(TForm)
    pnlFooter: TPanel;
    btnClose: TButton;
    PageControl1: TPageControl;
    TabSearch: TTabSheet;
    TabData: TTabSheet;
    pnlSearch: TPanel;
    SearchBox1: TSearchBox;
    pnlButtons: TPanel;
    btnDelete: TButton;
    btnDetail: TButton;
    btnNew: TButton;
    DBGrid1: TDBGrid;
    dsSearch: TDataSource;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCustomerRegister: TFrmCustomerRegister;

implementation

{$R *.dfm}

procedure TFrmCustomerRegister.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCustomerRegister.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Perform (WM_NEXTDLGCTL, 0, 0);
    end;
end;

end.
