unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.CategoryButtons;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    GroupBox: TGroupBox;
    btnCustomers: TButton;
    Panel2: TPanel;
    Image1: TImage;
    btnProducts: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

end.
