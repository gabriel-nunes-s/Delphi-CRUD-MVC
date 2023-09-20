unit uFrmCustomers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBaseForm, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask,
  uCustomerController, uCustomerModel, uDmCustomer;

type
  TOperation = (opNew, opEdit, opNavigate);

  TFrmCustomerRegister1 = class(TFrmCustomerRegister)
    edtID: TLabeledEdit;
    edtName: TLabeledEdit;
    cbxType: TComboBox;
    edtDocument: TLabeledEdit;
    edtPhone: TLabeledEdit;
    lblType: TLabel;
    pnlBtnsCad: TPanel;
    btnEdit: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    btnList: TPanel;
    pnlReturn: TPanel;
    Image1: TImage;
    btnSearch: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDetailClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FOperation: TOperation;
    procedure New;
    procedure Detail;
    procedure Config;
    procedure Search;
    procedure LoadCustomer;
    procedure List;
    procedure Modify;
    procedure Delete;
    procedure Insert;
    procedure Rec;
    procedure EnableControls(aOperation: TOperation);
  end;

var
  FrmCustomerRegister1: TFrmCustomerRegister1;

implementation

{$R *.dfm}

{ TFrmCustomerRegister1 }

procedure TFrmCustomerRegister1.btnCancelClick(Sender: TObject);
begin
  inherited;
  EnableControls(opNavigate);
end;

procedure TFrmCustomerRegister1.btnDeleteClick(Sender: TObject);
begin
  inherited;
  Delete;
end;

procedure TFrmCustomerRegister1.btnDetailClick(Sender: TObject);
begin
  inherited;
  Detail;
end;

procedure TFrmCustomerRegister1.btnEditClick(Sender: TObject);
begin
  inherited;
  FOperation := opEdit;
  EnableControls(opEdit);
end;

procedure TFrmCustomerRegister1.btnNewClick(Sender: TObject);
begin
  inherited;
  New;
  EnableControls(opNew);
end;

procedure TFrmCustomerRegister1.btnSaveClick(Sender: TObject);
begin
  inherited;
  Rec;
  EnableControls(opNavigate);
end;

procedure TFrmCustomerRegister1.btnSearchClick(Sender: TObject);
begin
  inherited;
  Search;
end;

procedure TFrmCustomerRegister1.Config;
begin
  TabSearch.TabVisible := true;
  TabData.TabVisible := false;
  pgcMain.ActivePage := TabSearch;
end;

procedure TFrmCustomerRegister1.Delete;
var
  oCustomerController : TCustomerController;
  sError : String;
  
begin
  oCustomerController := TCustomerController.Create();
  try
    if (DataModule1.FDQuerySearch.Active) and (DataModule1.FDQuerySearch.RecordCount > 0) then
    begin
      if MessageDlg('Do you really want to delete this customer?', mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      begin
        if oCustomerController.Delete(DataModule1.FDQuerySearchID.AsInteger, sError) = False then
          raise Exception.Create('sError');
        oCustomerController.Search(edtSearch.Text);
      end;
    end
    else
    begin
      raise Exception.Create('There is no registers for being excluded');
    end;
  finally
    FreeAndNil(oCustomerController);
  end;
end;

procedure TFrmCustomerRegister1.Detail;
begin
  //It changes to Data tab for more details
  FOperation := opNavigate;
  pgcMain.ActivePage := TabData;
end;

procedure TFrmCustomerRegister1.EnableControls(aOperation: TOperation);
begin
  case aOperation of
    opNew, opEdit: 
    begin 
      edtName.Enabled := True;
      cbxType.Enabled := True;
      edtDocument.Enabled := True;
      edtPhone.Enabled := True;
      btnList.Enabled := False;
      btnClose.Enabled := False;
      btnEdit.Enabled := False;
      btnSave.Enabled := True;
      btnCancel.Enabled := True;
    end;
    opNavigate:
    begin
      edtName.Enabled := False;
      cbxType.Enabled := False;
      edtDocument.Enabled := False;
      edtPhone.Enabled := False;
      btnList.Enabled := True;
      btnClose.Enabled := True;
      btnEdit.Enabled := True;
      btnSave.Enabled := False;
      btnCancel.Enabled := False;
    end; 
  end;
end;

procedure TFrmCustomerRegister1.FormShow(Sender: TObject);
begin
  inherited;
  Config;
end;

procedure TFrmCustomerRegister1.Image1Click(Sender: TObject);
begin
  inherited;
  List;  
end;

procedure TFrmCustomerRegister1.Insert;
var
  oCustomer: TCustomer;
  oCustomerController: TCustomerController;
  sError: String;
begin
   oCustomer := TCustomer.Create();
   oCustomerController := oCustomerController.Create();
   try
    with oCustomer do
    begin
      ID := 0;
      Name := edtName.Text;
      TypeCustomer := cbxType.Text;
      Document := edtDocument.Text;
      Phone := edtPhone.Text;
    end;
    if oCustomerController.Insert(oCustomer, sError) = False then
      raise Exception.Create('sError');
    
   finally
     FreeAndNil(oCustomer);
     FreeAndNil(oCustomerController);
   end;
end;

procedure TFrmCustomerRegister1.List;
begin
  pgcMain.ActivePage := TabSearch;
  TabData.TabVisible := False;
end;

procedure TFrmCustomerRegister1.LoadCustomer;
var
  oCustomer : TCustomer;
  oCustomerController: TCustomerController;
begin
  oCustomer := TCustomer.Create;
  oCustomerController := TCustomerController.Create;
  try
    oCustomerController.LoadCustomer(oCustomer, dsSearch.DataSet.FieldByName('id').AsInteger);
    with oCustomer do
    begin
      edtID.Text := IntToStr(ID);
      edtName.Text := Name;
      edtDocument.Text := Document;
      edtPhone.Text := Phone;
      cbxType.Text := TypeCustomer;
    end;
  finally
    FreeAndNil(oCustomer);
    FreeAndNil(oCustomerController);
  end;
end;

procedure TFrmCustomerRegister1.Modify;
var
  oCustomer : TCustomer;
  oCustomerController: TCustomerController;
  sError : String;
begin
  oCustomer := TCustomer.Create();
  oCustomerController := oCustomerController.Create();
  try
    with oCustomer do
    begin
      ID := StrToIntDef(edtID.Text, 0);
      Name := edtName.Text;
      TypeCustomer := cbxType.Text;
      Document := edtDocument.Text;
      Phone := edtPhone.Text;
    end;

    if oCustomerController.Modify(oCustomer, sError) then
      raise Exception.Create('sError');
    
  finally
    FreeAndNil(oCustomer);
    FreeAndNil(oCustomerController);
  end;
end;

procedure TFrmCustomerRegister1.New;
begin
  FOperation := opNew; //The query will be "insert"
  pgcMain.ActivePage := TabData;
end;

procedure TFrmCustomerRegister1.Rec; //Record
var
oCustomerController : TCustomerController;
begin
  oCustomerController := TCustomerController.Create();
  try
    case FOperation of
      opNew: Insert;
      opEdit: Modify;
    end;
    oCustomerController.Search(edtSearch.Text);
  finally
    FreeAndNil(oCustomerController);
  end;
end;

procedure TFrmCustomerRegister1.Search;
var
  oCustomerController : TCustomerController;
begin
  oCustomerController := TCustomerController.Create();
  try
    oCustomerController.Search(edtSearch.text);
  finally
    FreeAndNil(oCustomerController);
  end;
end;

end.
