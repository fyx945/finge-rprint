object freStroe: TfreStroe
  Left = 0
  Top = 0
  Width = 600
  Height = 30
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object RzToolbar1: TRzToolbar
    Left = 0
    Top = 0
    Width = 600
    Height = 29
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = [sdTop]
    BorderWidth = 0
    TabOrder = 0
    ToolbarControls = (
      RzSpacer2
      Label1
      RzSpacer1
      cb_AreaCode
      RzSpacer3
      Label2
      RzSpacer4
      cb_StoreCode)
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 24
      Height = 13
      Caption = #22320#21306
    end
    object RzSpacer1: TRzSpacer
      Left = 48
      Top = 2
      Width = 10
    end
    object Label2: TLabel
      Left = 308
      Top = 8
      Width = 24
      Height = 13
      Caption = #24215#38138
    end
    object RzSpacer2: TRzSpacer
      Left = 4
      Top = 2
      Width = 20
    end
    object RzSpacer3: TRzSpacer
      Left = 258
      Top = 2
      Width = 50
    end
    object RzSpacer4: TRzSpacer
      Left = 332
      Top = 2
      Width = 10
    end
    object cb_AreaCode: TRzComboBox
      Left = 58
      Top = 4
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cb_AreaCodeChange
    end
    object cb_StoreCode: TRzComboBox
      Left = 342
      Top = 4
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = cb_StoreCodeChange
    end
  end
  object slngFreStore: TsiLang
    Version = '6.0.2'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    ActiveLanguage = 2
    LangDispatcher = dmMain.siLangDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'ENG'
      'CHS'
      'GB5')
    Language = 'CHS'
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
    Left = 288
    TranslationData = {
      737443617074696F6E730D0A527A546F6F6C62617231010101010D0A4C616265
      6C31014172656101B5D8C7F801A661B0CF010D0A4C6162656C320153746F7265
      01B5EAC6CC01A9B1BE51010D0A737448696E74730D0A546672655374726F6501
      010D0A527A546F6F6C626172310101010D0A4C6162656C310101010D0A527A53
      7061636572310101010D0A4C6162656C320101010D0A527A5370616365723201
      01010D0A527A537061636572330101010D0A527A537061636572340101010D0A
      63625F41726561436F64650101010D0A63625F53746F7265436F64650101010D
      0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A5466726553
      74726F65015461686F6D6101010D0A73744D756C74694C696E65730D0A63625F
      41726561436F64652E4974656D730101010D0A63625F41726561436F64652E56
      616C7565730101010D0A63625F53746F7265436F64652E4974656D730101010D
      0A63625F53746F7265436F64652E56616C7565730101010D0A7374446C677343
      617074696F6E730D0A5761726E696E67015761726E696E670101010D0A457272
      6F72014572726F720101010D0A496E666F726D6174696F6E01496E666F726D61
      74696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D0A596573
      01265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A43
      616E63656C0143616E63656C0101010D0A41626F7274012641626F7274010101
      0D0A5265747279012652657472790101010D0A49676E6F7265012649676E6F72
      650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F
      20746F20416C6C0101010D0A59657320546F20416C6C0159657320746F202641
      6C6C0101010D0A48656C70012648656C700101010D0A7374537472696E67730D
      0A73744F74686572537472696E67730D0A63625F41726561436F64652E546578
      740101010D0A63625F53746F7265436F64652E546578740101010D0A73744C6F
      63616C65730D0A7374436F6C6C656374696F6E730D0A73744368617253657473
      0D0A546672655374726F650144454641554C545F434841525345540144454641
      554C545F434841525345540144454641554C545F434841525345540D0A}
  end
end
