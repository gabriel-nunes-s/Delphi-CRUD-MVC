object DataModule1: TDataModule1
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDQuerySearch: TFDQuery
    Connection = dmConnection.FDConnection
    SQL.Strings = (
      'select id, name, phone from customer where name containing :name'
      '')
    Left = 96
    Top = 80
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 80
        Value = Null
      end>
    object FDQuerySearchID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQuerySearchNAME: TStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 80
    end
    object FDQuerySearchPHONE: TStringField
      FieldName = 'PHONE'
      Origin = 'PHONE'
      Size = 10
    end
  end
  object FDQueryInsert: TFDQuery
    Connection = dmConnection.FDConnection
    SQL.Strings = (
      'insert into CUSTOMER (ID, NAME, "TYPE", DOCUMENT, PHONE)'
      'values (:ID, :NAME, :"TYPE", :DOCUMENT, :PHONE)')
    Left = 96
    Top = 168
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 80
        Value = Null
      end
      item
        Name = 'TYPE'
        IsCaseSensitive = True
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 1
      end
      item
        Name = 'DOCUMENT'
        DataType = ftString
        ParamType = ptInput
        Size = 15
      end
      item
        Name = 'PHONE'
        DataType = ftString
        ParamType = ptInput
        Size = 10
      end>
  end
  object FDQueryModify: TFDQuery
    Connection = dmConnection.FDConnection
    SQL.Strings = (
      'update CUSTOMER'
      'set NAME = :NAME,'
      '    "TYPE" = :"TYPE",'
      '    DOCUMENT = :DOCUMENT,'
      '    PHONE = :PHONE'
      'where (ID = :ID)')
    Left = 96
    Top = 256
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TYPE'
        IsCaseSensitive = True
        DataType = ftFixedChar
        ParamType = ptInput
      end
      item
        Name = 'DOCUMENT'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PHONE'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQueryDelete: TFDQuery
    Connection = dmConnection.FDConnection
    SQL.Strings = (
      'delete from CUSTOMER'
      'where (ID = :ID)')
    Left = 96
    Top = 344
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
