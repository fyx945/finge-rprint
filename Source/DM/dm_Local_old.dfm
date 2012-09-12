object dmLocal_old: TdmLocal_old
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Top = 133
  Height = 304
  Width = 533
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 30
  end
  object ADOQuery: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 130
    Top = 30
  end
  object IntraDateSet: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 122
    Top = 98
  end
  object ADOComm: TADOCommand
    Connection = ADOConn
    Parameters = <>
    Left = 40
    Top = 90
  end
  object ado_Data: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 202
    Top = 30
  end
  object aq_Staff: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 42
    Top = 182
  end
  object siLang: TsiLang
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    LangDelim = 1
    LangNames.Strings = (
      'Language N1')
    Language = 'Language N1'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    Left = 160
    Top = 184
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A73744D756C74694C696E65730D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E67010D0A45
      72726F72014572726F72010D0A496E666F726D6174696F6E01496E666F726D61
      74696F6E010D0A436F6E6669726D01436F6E6669726D010D0A59657301265965
      73010D0A4E6F01264E6F010D0A4F4B014F4B010D0A43616E63656C0143616E63
      656C010D0A41626F7274012641626F7274010D0A526574727901265265747279
      010D0A49676E6F7265012649676E6F7265010D0A416C6C0126416C6C010D0A4E
      6F20546F20416C6C014E266F20746F20416C6C010D0A59657320546F20416C6C
      0159657320746F2026416C6C010D0A48656C70012648656C70010D0A73745374
      72696E67730D0A73744F74686572537472696E67730D0A73744C6F63616C6573
      0D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A}
  end
  object cmdSigndet: TADOCommand
    Connection = ADOConn
    Parameters = <>
    Left = 248
    Top = 98
  end
  object qrySigndet: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 258
    Top = 190
  end
  object ADOQuery_MealTime: TADOQuery
    Connection = ADOConn
    Parameters = <
      item
        Name = 'pStaffID'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'pToday'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select '
      'max(SIGN_DATETIME) as SIGNDATETIME'
      ' from signdet '
      'where staffid = :pStaffID'
      ' and SIGN_DATETIME > :pToday'
      ' and sign_code = '#39'05'#39)
    Left = 418
    Top = 86
  end
  object ADOQry_SysTime: TADOQuery
    Connection = ADOConn
    Parameters = <
      item
        Name = 'pdLastsysTime'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'update LastTime set Lastsystime = :pdLastsysTime'
      '')
    Left = 386
    Top = 174
  end
end
