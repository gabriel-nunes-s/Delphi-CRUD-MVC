object dmConnection: TdmConnection
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 64
    Top = 40
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Gabriel\OneDrive\Documents\Embarcadero\Studio\' +
        'Projects\Win32\Debug\Delphi-CRUD-MVC\PROJECT_CRUD.FDB'
      'ConnectionDef=ProjectCRUD')
    LoginPrompt = False
    Left = 248
    Top = 40
  end
end
