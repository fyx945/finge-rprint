object frmUser: TfrmUser
  Left = 397
  Top = 257
  BorderStyle = bsNone
  Caption = #29992#25143#31649#29702
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object RzPageControl1: TRzPageControl
    Left = 40
    Top = 56
    Width = 250
    Height = 265
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 0
    FixedDimension = 20
    object TabSheet1: TRzTabSheet
      Caption = #23494#30721#30331#24405
      object Label3: TLabel
        Left = 21
        Top = 47
        Width = 28
        Height = 14
        Caption = #29992#25143
      end
      object Label4: TLabel
        Left = 21
        Top = 83
        Width = 28
        Height = 14
        Caption = #23494#30721
      end
      object Label5: TLabel
        Left = 21
        Top = 111
        Width = 56
        Height = 14
        Caption = #30830#35748#23494#30721
      end
      object edt_User: TRzEdit
        Left = 96
        Top = 47
        Width = 120
        Height = 22
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 0
      end
      object btn_Confirm: TRzButton
        Left = 144
        Top = 160
        Caption = #30830#35748
        TabOrder = 1
        OnClick = btn_ConfirmClick
      end
      object edt_Password: TRzEdit
        Left = 96
        Top = 75
        Width = 120
        Height = 22
        PasswordChar = '*'
        TabOrder = 2
      end
      object edt_ConfirmPwd: TRzEdit
        Left = 96
        Top = 103
        Width = 120
        Height = 22
        PasswordChar = '*'
        TabOrder = 3
      end
    end
  end
  object RzPageControl2: TRzPageControl
    Left = 340
    Top = 56
    Width = 250
    Height = 270
    ActivePage = TabSheet2
    TabIndex = 0
    TabOrder = 1
    FixedDimension = 20
    object TabSheet2: TRzTabSheet
      Caption = #25351#32441#30331#24405
      object btn_Enroll: TRzButton
        Left = 32
        Top = 47
        Caption = #24405#21462
        TabOrder = 0
        OnClick = btn_EnrollClick
      end
      object RzButton2: TRzButton
        Left = 136
        Top = 47
        Caption = #21024#38500
        TabOrder = 1
      end
      object mem_FingerLog: TRzMemo
        Left = 0
        Top = 96
        Width = 246
        Height = 150
        Align = alBottom
        TabOrder = 2
      end
    end
  end
  inline freStroe: TfreStroe
    Left = 0
    Top = 0
    Width = 640
    Height = 30
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 640
    inherited RzToolbar1: TRzToolbar
      Width = 640
      ExplicitWidth = 640
      ToolbarControls = (
        RzSpacer2
        Label1
        RzSpacer1
        cb_AreaCode
        RzSpacer3
        Label2
        RzSpacer4
        cb_StoreCode)
      inherited cb_StoreCode: TRzComboBox
        OnChange = freStroecb_StoreCodeChange
      end
    end
  end
  object ZKEngine: TZKFPEngX
    Left = 544
    Top = 94
    Width = 24
    Height = 24
    OnFeatureInfo = ZKEngineFeatureInfo
    OnEnroll = ZKEngineEnroll
    ControlData = {
      5450463008545A4B4650456E6700044C656674020003546F7002000557696474
      6802180648656967687402180B456E726F6C6C436F756E7402030B53656E736F
      72496E6465780200095468726573686F6C64020A114F6E65546F4F6E65546872
      6573686F6C64020A10466F7263655365636F6E644D61746368090C4175746F49
      64656E74696679080D4973496D6167654368616E6765080000}
  end
  object siLang: TsiLang
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
    Left = 104
    Top = 248
    TranslationData = {
      737443617074696F6E730D0A5466726D55736572014D616E6167652055736572
      7301D3C3BBA7B9DCC0ED01A5CEA4E1BADEB27A010D0A62746E5F436F6E666972
      6D01436F6E6669726D01C8B7C8CF01DACCBB7B010D0A62746E5F456E726F6C6C
      015265636F726401C2BCC8A101BFFDA8FA010D0A4C6162656C3301557365726E
      616D6501D3C3BBA701A5CEA4E1010D0A4C6162656C340150617373776F726401
      C3DCC2EB01B14BBD58010D0A4C6162656C350150617373776F72642061676169
      6E01C8B7C8CFC3DCC2EB01DACCBB7BB14BBD58010D0A527A427574746F6E3201
      44656C65746501C9BEB3FD01A752B0A3010D0A546162536865657431014C6F67
      696E2042792050617373776F726401C3DCC2EBB5C7C2BC01B14BBD58B56EBFFD
      010D0A546162536865657432014C6F67696E2042792046696E6765726D61726B
      01D6B8CEC6B5C7C2BC01ABFCAFBEB56EBFFD010D0A737448696E74730D0A5466
      726D55736572010101010D0A62746E5F436F6E6669726D010101010D0A62746E
      5F456E726F6C6C010101010D0A6564745F436F6E6669726D507764010101010D
      0A6564745F50617373776F7264010101010D0A6564745F55736572010101010D
      0A6672655374726F65010101010D0A4C6162656C33010101010D0A4C6162656C
      34010101010D0A4C6162656C35010101010D0A6D656D5F46696E6765724C6F67
      010101010D0A527A427574746F6E32010101010D0A527A50616765436F6E7472
      6F6C31010101010D0A527A50616765436F6E74726F6C32010101010D0A546162
      536865657431010101010D0A546162536865657432010101010D0A5A4B456E67
      696E65010101010D0A7374446973706C61794C6162656C730D0A7374466F6E74
      730D0A5466726D5573657201CBCECCE501CBCECCE501010D0A73744D756C7469
      4C696E65730D0A6D656D5F46696E6765724C6F672E4C696E6573010101010D0A
      7374446C677343617074696F6E730D0A41626F7274012641626F72740101010D
      0A416C6C0126416C6C0101010D0A43616E63656C0143616E63656C0101010D0A
      436F6E6669726D01436F6E6669726D0101010D0A4572726F72014572726F7201
      01010D0A48656C70012648656C700101010D0A49676E6F7265012649676E6F72
      650101010D0A496E666F726D6174696F6E01496E666F726D6174696F6E010101
      0D0A4E6F01264E6F0101010D0A4E6F20546F20416C6C014E266F20746F20416C
      6C0101010D0A4F4B014F4B0101010D0A5265747279012652657472790101010D
      0A5761726E696E67015761726E696E670101010D0A5965730126596573010101
      0D0A59657320546F20416C6C0159657320746F2026416C6C0101010D0A737453
      7472696E67730D0A454E524F4C4C5F4641494C0153746F70207265636F726420
      66696E6765726D61726B01CDA3D6B9B5C7BCC7D6B8CEC6A1A301B0B1A4EEB56E
      B04FABFCAFBEA143010D0A454E524F4C4C5F46454154555245014E6565642074
      6F2072656164207468652073616D652066696E6765722025642074696D657301
      BBB9D0E8B6C1C8A1CDACD2BBCAD6D6B82564B4CE01C1D9BBDDC5AAA8FAA650A4
      40A4E2ABFC2564A6B8010D0A454E524F4C4C5F50555401506C65617365207072
      6573732066696E67657201C7EBB0B4CFC2CAD6D6B82E2E2E01BDD0ABF6A455A4
      E2ABFC2E2E2E010D0A454E524F4C4C5F53554343454544015265636F72642074
      68652066696E6765726D61726B207375636365737301B3C9B9A6D7A2B2E1D6B8
      CEC6A1A301A6A8A55CAA60A555ABFCAFBEA143010D0A5552555F43414E4E4F54
      5F4F50454E0143616E2274204F70656E2046696E6765727072696E7420617420
      552E522E5520343030302101B4F2BFAAD6B8CEC6C9E8B1B8CAA7B0DCA3A101A5
      B4B67DABFCAFBEB35DB3C6A5A2B1D1A154010D0A5552555F4F50454E5F455843
      4550540143616E277420636F6E6E6563742074686520552E522E552001C1ACBD
      D3D6B8CEC6C9E8B1B8B3F6B4EDA3A101B373B1B5ABFCAFBEB35DB3C6A558BFF9
      A154010D0A73744F74686572537472696E67730D0A6564745F436F6E6669726D
      5077642E54657874010101010D0A6564745F50617373776F72642E5465787401
      0101010D0A6564745F557365722E54657874010101010D0A5466726D55736572
      2E48656C7046696C65010101010D0A5A4B456E67696E652E4650456E67696E65
      56657273696F6E01332E352E303020466F7220313A4E0101010D0A5A4B456E67
      696E652E52656754706C46696C654E616D65010101010D0A5A4B456E67696E65
      2E53656E736F72534E010101010D0A5A4B456E67696E652E56657254706C4669
      6C654E616D65010101010D0A73744C6F63616C65730D0A7374436F6C6C656374
      696F6E730D0A737443686172536574730D0A5466726D5573657201414E53495F
      434841525345540144454641554C545F434841525345540144454641554C545F
      43484152534554010D0A}
  end
end
