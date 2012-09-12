object frm_FmMain: Tfrm_FmMain
  Left = 152
  Top = 216
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25351#32441#31649#29702
  ClientHeight = 528
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object RzGroupBar1: TRzGroupBar
    Left = 0
    Top = 0
    Width = 150
    Height = 509
    GradientColorStart = clBtnFace
    GradientColorStop = clBtnShadow
    GroupBorderSize = 8
    UniqueItemSelection = True
    VisualStyle = vsWinXP
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 0
    object grp_System: TRzGroup
      Items = <
        item
          Caption = #30331#24405
          Tag = 11
          Visible = False
          OnClick = ShowTagModule
        end
        item
          Caption = #31649#29702
          Tag = 12
          Visible = False
          OnClick = ShowTagModule
        end
        item
          Caption = #36864#20986
          Tag = 13
          OnClick = ShowTagModule
        end>
      Opened = True
      OpenedHeight = 48
      DividerVisible = False
      ShowItemSelection = True
      Caption = #31995#32479
      ParentColor = False
    end
    object grp_Data: TRzGroup
      Items = <
        item
          Caption = #23548#20986#25171#21345#25968#25454
          Tag = 41
          Visible = False
          OnClick = ShowTagModule
        end
        item
          Caption = #26356#26032#22522#30784#25968#25454
          Tag = 42
          OnClick = ShowTagModule
        end>
      Opened = True
      OpenedHeight = 48
      DividerVisible = False
      Caption = #25968#25454
      ParentColor = False
    end
    object grp_Finger: TRzGroup
      Items = <
        item
          Caption = #24405#20837
          Tag = 21
          OnClick = ShowTagModule
        end
        item
          Caption = #31649#29702
          Tag = 22
          OnClick = ShowTagModule
        end>
      Opened = True
      OpenedHeight = 68
      DividerVisible = False
      ShowItemSelection = True
      Caption = #25351#32441
      ParentColor = False
    end
    object RzGroup1: TRzGroup
      Items = <
        item
          Caption = #24215#38271
        end>
      Opened = True
      OpenedHeight = 48
      DividerVisible = False
      ShowItemSelection = True
      Caption = #29992#25143
      ParentColor = False
      Visible = False
    end
    object RzGroup3: TRzGroup
      Items = <
        item
          Caption = 'English'
          Tag = 31
          OnClick = ShowTagModule
        end
        item
          Caption = #31616#20307#20013#25991
          Tag = 32
          OnClick = ShowTagModule
        end
        item
          Caption = #32649#30768#12356#12421
          Tag = 33
          OnClick = ShowTagModule
        end>
      Opened = True
      OpenedHeight = 88
      DividerVisible = False
      Special = True
      Caption = #35821#35328
      ParentColor = False
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 509
    Width = 794
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 1
    object RzStatusPane1: TRzStatusPane
      Left = 150
      Top = 0
      Width = 150
      Height = 19
      Align = alLeft
      ExplicitLeft = 0
    end
    object sp_Message: TRzStatusPane
      Left = 300
      Top = 0
      Width = 200
      Height = 19
      Align = alLeft
      ExplicitLeft = 150
    end
    object RzVersionInfoStatus1: TRzVersionInfoStatus
      Left = 0
      Top = 0
      Width = 150
      Height = 19
      Align = alLeft
      FieldLabel = 'Version: '
      Field = vifFileVersion
      VersionInfo = RzVersionInfo1
    end
  end
  object pnl_Module: TRzPanel
    Left = 150
    Top = 0
    Width = 644
    Height = 509
    Align = alClient
    BorderOuter = fsButtonDown
    TabOrder = 2
    object tc_Login: TRzTabControl
      Left = 166
      Top = 144
      Width = 300
      Height = 161
      ParentColor = False
      TabIndex = 0
      TabOrder = 0
      Tabs = <
        item
          Caption = #30331#24405
        end>
      FixedDimension = 20
      object Label1: TLabel
        Left = 40
        Top = 44
        Width = 28
        Height = 14
        Caption = #29992#25143
      end
      object Label2: TLabel
        Left = 40
        Top = 80
        Width = 28
        Height = 14
        Caption = #23494#30721
      end
      object edt_User: TRzEdit
        Left = 112
        Top = 44
        Width = 120
        Height = 22
        TabOrder = 0
      end
      object btn_Login: TRzButton
        Left = 152
        Top = 112
        Caption = #30331#24405
        TabOrder = 2
        OnClick = btn_LoginClick
      end
      object edt_Pass: TRzEdit
        Left = 112
        Top = 70
        Width = 120
        Height = 22
        PasswordChar = '*'
        TabOrder = 1
        OnKeyPress = edt_PassKeyPress
      end
    end
  end
  object siLang: TsiLang
    Version = '6.1.0.1'
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
    Left = 184
    Top = 344
    TranslationData = {
      737443617074696F6E730D0A5466726D5F466D4D61696E0146696E6765724D61
      6E61676501D6B8CEC6B9DCC0ED01ABFCAFBEBADEB27A010D0A527A47726F7570
      42617231010101010D0A6772705F53797374656D0153797374656D01CFB5CDB3
      01A874B2CE010D0A6772705F46696E6765720146696E67657201D6B8CEC601AB
      FCAFBE010D0A527A47726F757033014C616E677561676501D3EFD1D401BB79A8
      A5010D0A527A53746174757350616E6531010101010D0A73705F4D6573736167
      65010101010D0A706E6C5F4D6F64756C65010101010D0A4C6162656C31015573
      65726E616D6501D3C3BBA701A5CEA4E1010D0A4C6162656C320150617373776F
      726401C3DCC2EB01B14BBD58010D0A62746E5F4C6F67696E014C6F67696E01B5
      C7C2BC01B56EBFFD010D0A6772705F44617461014461746101CAFDBEDD01BCC6
      D575010D0A527A47726F757031015573657201D3C3BBA701A5CEA4E1010D0A73
      7448696E74730D0A5466726D5F466D4D61696E010101010D0A527A47726F7570
      42617231010101010D0A6772705F53797374656D010101010D0A6772705F4669
      6E676572010101010D0A527A47726F757033010101010D0A527A537461747573
      42617231010101010D0A527A53746174757350616E6531010101010D0A73705F
      4D657373616765010101010D0A706E6C5F4D6F64756C65010101010D0A74635F
      4C6F67696E010101010D0A4C6162656C31010101010D0A4C6162656C32010101
      010D0A6564745F55736572010101010D0A62746E5F4C6F67696E010101010D0A
      6564745F50617373010101010D0A6772705F44617461010101010D0A527A4772
      6F757031010101010D0A7374446973706C61794C6162656C730D0A7374466F6E
      74730D0A5466726D5F466D4D61696E0154696D6573204E657720526F6D616E01
      CBCECCE501010D0A73744D756C74694C696E65730D0A7374446C677343617074
      696F6E730D0A5761726E696E67015761726E696E670101010D0A4572726F7201
      4572726F720101010D0A496E666F726D6174696F6E01496E666F726D6174696F
      6E0101010D0A436F6E6669726D01436F6E6669726D0101010D0A596573012659
      65730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63
      656C0143616E63656C0101010D0A41626F7274012641626F72740101010D0A52
      65747279012652657472790101010D0A49676E6F7265012649676E6F72650101
      010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F20746F
      20416C6C0101010D0A59657320546F20416C6C0159657320746F2026416C6C01
      01010D0A48656C70012648656C700101010D0A7374537472696E67730D0A7374
      4F74686572537472696E67730D0A5466726D5F466D4D61696E2E48656C704669
      6C65010101010D0A527A537461747573426172312E53696D706C654361707469
      6F6E010101010D0A6564745F557365722E54657874010101010D0A6564745F50
      6173732E54657874010101010D0A73744C6F63616C65730D0A7374436F6C6C65
      6374696F6E730D0A6772705F53797374656D2E4974656D735B305D2E43617074
      696F6E014C6F67696E01B5C7C2BC01B56EBFFD010D0A6772705F53797374656D
      2E4974656D735B305D2E48696E74010101010D0A6772705F53797374656D2E49
      74656D735B315D2E43617074696F6E014D616E61676501B9DCC0ED01BADEB27A
      010D0A6772705F53797374656D2E4974656D735B315D2E48696E74010101010D
      0A6772705F53797374656D2E4974656D735B325D2E43617074696F6E01457869
      7401CDCBB3F601B068A558010D0A6772705F53797374656D2E4974656D735B32
      5D2E48696E74010101010D0A6772705F46696E6765722E4974656D735B305D2E
      43617074696F6E01456E726F6C6C01C2BCC8EB01BFFDA44A010D0A6772705F46
      696E6765722E4974656D735B305D2E48696E74010101010D0A6772705F46696E
      6765722E4974656D735B315D2E43617074696F6E014D616E61676501B9DCC0ED
      01BADEB27A010D0A6772705F46696E6765722E4974656D735B315D2E48696E74
      010101010D0A527A47726F7570332E4974656D735B305D2E43617074696F6E01
      456E676C6973680101010D0A527A47726F7570332E4974656D735B305D2E4869
      6E74010101010D0A527A47726F7570332E4974656D735B315D2E43617074696F
      6E01BCF2CCE5D6D0CEC40101010D0A527A47726F7570332E4974656D735B315D
      2E48696E74010101010D0A527A47726F7570332E4974656D735B325D2E436170
      74696F6E01C163C5E9A4A4A4E50101010D0A527A47726F7570332E4974656D73
      5B325D2E48696E74010101010D0A74635F4C6F67696E2E546162735B305D2E43
      617074696F6E014C6F67696E01B5C7C2BC01010D0A74635F4C6F67696E2E5461
      62735B305D2E48696E74010101010D0A6772705F446174612E4974656D735B30
      5D2E43617074696F6E014578706F7274205369676E64657401B5BCB3F6B4F2BF
      A8CAFDBEDD01BEC9A558A5B4A564BCC6D575010D0A6772705F446174612E4974
      656D735B305D2E48696E74010101010D0A6772705F446174612E4974656D735B
      315D2E43617074696F6E015570646174652042617369634461746501B8FCD0C2
      BBF9B4A1CAFDBEDD01A7F3B773B0F2C2A6BCC6D575010D0A6772705F44617461
      2E4974656D735B315D2E48696E74010101010D0A527A47726F7570312E497465
      6D735B305D2E43617074696F6E0153686F706B656570657201B5EAB3A401A9B1
      AAF8010D0A527A47726F7570312E4974656D735B305D2E48696E74010101010D
      0A737443686172536574730D0A5466726D5F466D4D61696E01414E53495F4348
      41525345540144454641554C545F434841525345540144454641554C545F4348
      4152534554010D0A}
  end
  object RzVersionInfo1: TRzVersionInfo
    Left = 200
    Top = 408
  end
end
