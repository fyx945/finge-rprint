object FormUpdateData: TFormUpdateData
  Left = 197
  Top = 134
  BorderStyle = bsNone
  Caption = #22522#30784#25968#25454#26356#26032
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object pnlHeaderButtons: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 50
    Align = alTop
    TabOrder = 0
    object btnStart: TButton
      Left = 168
      Top = 14
      Width = 187
      Height = 25
      Caption = #24320#22987#26356#26032#22522#30784#25968#25454
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnDownloadStaff: TButton
      Left = 392
      Top = 14
      Width = 187
      Height = 25
      Caption = #24320#22987#19979#36733#21592#24037#25968#25454
      TabOrder = 1
      OnClick = btnDownloadStaffClick
    end
  end
  object pnlContent: TPanel
    Left = 0
    Top = 50
    Width = 640
    Height = 430
    Align = alClient
    TabOrder = 1
    object lblTotal: TLabel
      Left = 112
      Top = 176
      Width = 28
      Height = 14
      Caption = #36827#24230
    end
    object sp_Update: TLabel
      Left = 160
      Top = 232
      Width = 385
      Height = 14
    end
    object pbTotal: TProgressBar
      Left = 168
      Top = 176
      Width = 401
      Height = 17
      Step = 1
      TabOrder = 0
    end
  end
  object slngUpdateData: TsiLang
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
    Left = 96
    Top = 8
    TranslationData = {
      737443617074696F6E730D0A54466F726D557064617465446174610155706461
      746520426173656461746101BBF9B4A1CAFDBEDDB8FCD0C201B0F2C2A6BCC6D5
      75A7F3B773010D0A706E6C486561646572427574746F6E73010101010D0A6274
      6E537461727401537461727401BFAACABCB8FCD0C2BBF9B4A1CAFDBEDD01B67D
      A96C010D0A706E6C436F6E74656E74010101010D0A6C626C546F74616C015072
      6F677265737301BDF8B6C801B669ABD7010D0A62746E446F776E6C6F61645374
      61666601446F776E6C6F616420537461666601BFAACABCCFC2D4D8D4B1B9A4CA
      FDBEDD01010D0A737448696E74730D0A54466F726D5570646174654461746101
      0101010D0A706E6C486561646572427574746F6E73010101010D0A62746E5374
      617274010101010D0A706E6C436F6E74656E74010101010D0A6C626C546F7461
      6C010101010D0A7062546F74616C010101010D0A62746E446F776E6C6F616453
      74616666010101010D0A7374446973706C61794C6162656C730D0A7374466F6E
      74730D0A54466F726D5570646174654461746101CBCECCE501CBCECCE5010D0A
      73744D756C74694C696E65730D0A7374446C677343617074696F6E730D0A5761
      726E696E67015761726E696E670101010D0A4572726F72014572726F72010101
      0D0A496E666F726D6174696F6E01496E666F726D6174696F6E0101010D0A436F
      6E6669726D01436F6E6669726D0101010D0A59657301265965730101010D0A4E
      6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63656C0143616E6365
      6C0101010D0A41626F7274012641626F72740101010D0A526574727901265265
      7472790101010D0A49676E6F7265012649676E6F72650101010D0A416C6C0126
      416C6C0101010D0A4E6F20546F20416C6C014E266F20746F20416C6C0101010D
      0A59657320546F20416C6C0159657320746F2026416C6C0101010D0A48656C70
      012648656C700101010D0A7374537472696E67730D0A73744F74686572537472
      696E67730D0A54466F726D557064617465446174612E48656C7046696C650101
      01010D0A73744C6F63616C65730D0A7374436F6C6C656374696F6E730D0A7374
      43686172536574730D0A54466F726D5570646174654461746101414E53495F43
      4841525345540144454641554C545F434841525345540144454641554C545F43
      484152534554010D0A}
  end
end
