object FormExpSigndet: TFormExpSigndet
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormExpSigndet'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMinimized
  PixelsPerInch = 96
  TextHeight = 14
  object pnlTopButtons: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 50
    Align = alTop
    TabOrder = 0
    object btnExp: TButton
      Left = 344
      Top = 13
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 0
      OnClick = btnExpClick
    end
    object btnSearch: TButton
      Left = 216
      Top = 13
      Width = 75
      Height = 25
      Hint = #25214#20986#25152#26377#26410#19978#20256#30340#25171#21345#25968#25454
      Caption = #26597#35810
      TabOrder = 1
      OnClick = btnSearchClick
    end
  end
  object pnlContent: TPanel
    Left = 0
    Top = 50
    Width = 640
    Height = 430
    Align = alClient
    TabOrder = 1
    object dbgSigndet: TDBGridEh
      Left = 1
      Top = 1
      Width = 638
      Height = 428
      Align = alClient
      DataGrouping.GroupLevels = <>
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -14
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      RowDetailPanel.Color = clBtnFace
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object dsSigndet: TDataSource
    Left = 88
    Top = 8
  end
  object dlgSaveSigndet: TSaveDialog
    DefaultExt = 'dat'
    Filter = '.dat|.dat'
    Title = 'signdet'
    Left = 464
    Top = 8
  end
  object slngExpSigndet: TsiLang
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
    Left = 208
    Top = 152
    TranslationData = {
      737443617074696F6E730D0A54466F726D4578705369676E64657401466F726D
      4578705369676E64657401466F726D4578705369676E64657401010D0A706E6C
      546F70427574746F6E73010101010D0A62746E457870014578706F727401B5BC
      B3F601BEC9A558010D0A62746E53656172636801517565727901B2E9D1AF01AC
      64B8DF010D0A706E6C436F6E74656E74010101010D0A737448696E74730D0A54
      466F726D4578705369676E64657401010D0A706E6C546F70427574746F6E7301
      0101010D0A62746E457870010101010D0A62746E53656172636801D5D2B3F6CB
      F9D3D0CEB4C9CFB4ABB5C4B4F2BFA8CAFDBEDD0101010D0A706E6C436F6E7465
      6E74010101010D0A6462675369676E646574010101010D0A7374446973706C61
      794C6162656C730D0A7374466F6E74730D0A54466F726D4578705369676E6465
      7401CBCECCE501CBCECCE501010D0A73744D756C74694C696E65730D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E670101010D
      0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01496E66
      6F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D
      0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101
      010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641626F72
      740101010D0A5265747279012652657472790101010D0A49676E6F7265012649
      676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C
      014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965732074
      6F2026416C6C0101010D0A48656C70012648656C700101010D0A737453747269
      6E67730D0A504C454153455F515545525901506C617365207175657279206669
      7273742101C7EBCFC8B2E9D1AF2101BDD0A5FDAC64B8DF21010D0A484156454E
      4F545F5349474E4445540148617665206E6F7420646174612074686174206172
      6520756E75706C6F616465642101C3BBD3D0CEB4C9CFB4ABB5C4B4F2BFA8CAFD
      BEDD2101A853A6B3A5BCA457B6C7AABAA5B4A564BCC6D57521010D0A4558504F
      52545F53554343455353014578706F727420737563636573732101B5BCB3F6B3
      C9B9A62101BEC9A558A6A8A55C21010D0A4558504F52545F4641494C45440145
      78706F7274206661696C2101B5BCB3F6CAA7B0DC2101BEC9A558A5A2B1D12101
      0D0A73744F74686572537472696E67730D0A54466F726D4578705369676E6465
      742E48656C7046696C65010101010D0A646C67536176655369676E6465742E46
      696C746572012E6461747C2E6461740101010D0A646C67536176655369676E64
      65742E5469746C65017369676E6465740101010D0A73744C6F63616C65730D0A
      7374436F6C6C656374696F6E730D0A6462675369676E6465742E436F6C756D6E
      735B305D2E466F6F7465722E56616C7565010101010D0A6462675369676E6465
      742E436F6C756D6E735B305D2E535446696C7465722E446174614669656C6401
      0101010D0A6462675369676E6465742E436F6C756D6E735B305D2E535446696C
      7465722E4B65794669656C64010101010D0A6462675369676E6465742E436F6C
      756D6E735B305D2E535446696C7465722E4C6973744669656C64010101010D0A
      6462675369676E6465742E436F6C756D6E735B305D2E5469746C652E43617074
      696F6E010101010D0A6462675369676E6465742E436F6C756D6E735B305D2E54
      69746C652E48696E74010101010D0A737443686172536574730D0A54466F726D
      4578705369676E64657401414E53495F434841525345540144454641554C545F
      434841525345540144454641554C545F43484152534554010D0A}
  end
end
