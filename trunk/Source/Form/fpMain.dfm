object frmFingerprint: TfrmFingerprint
  Left = 0
  Top = 0
  Caption = #25351#32441#25171#21345#31995#32479
  ClientHeight = 698
  ClientWidth = 952
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMinimized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object tbr_Main: TRzToolbar
    Left = 0
    Top = 0
    Width = 952
    Height = 124
    Cursor = crHandPoint
    AutoStyle = False
    Images = il_Tool
    RowHeight = 120
    ButtonLayout = blGlyphTop
    ButtonWidth = 168
    ButtonHeight = 120
    ShowButtonCaptions = True
    TextOptions = ttoCustom
    AutoSize = True
    BevelWidth = 2
    BorderInner = fsFlatBold
    BorderOuter = fsButtonDown
    BorderSides = [sdTop]
    BorderWidth = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = True
  end
  object pc_Staff: TRzPageControl
    Left = 0
    Top = 153
    Width = 952
    Height = 442
    ActivePage = ts_StaffInfo
    Align = alClient
    ParentColor = False
    TabIndex = 0
    TabOrder = 1
    FixedDimension = 20
    object ts_StaffInfo: TRzTabSheet
      Caption = #31614#21040#20449#24687
      object lab_Employee: TLabel
        Left = 25
        Top = 30
        Width = 180
        Height = 35
        Caption = #31614#21040#21592#24037#65306
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_Time: TLabel
        Left = 25
        Top = 140
        Width = 180
        Height = 35
        Caption = #25171#21345#26102#38388#65306
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_Type: TLabel
        Left = 25
        Top = 200
        Width = 180
        Height = 35
        Caption = #25171#21345#31867#22411#65306
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_State: TLabel
        Left = 25
        Top = 320
        Width = 163
        Height = 35
        Caption = #36830#25509#29366#24577':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_eName: TLabel
        Left = 250
        Top = 30
        Width = 400
        Height = 35
        AutoSize = False
        Caption = '--------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_sName: TLabel
        Left = 250
        Top = 80
        Width = 400
        Height = 35
        AutoSize = False
        Caption = '--------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_SignTime: TLabel
        Left = 250
        Top = 140
        Width = 400
        Height = 35
        AutoSize = False
        Caption = '--------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_SignType: TLabel
        Left = 250
        Top = 200
        Width = 400
        Height = 35
        AutoSize = False
        Caption = '--------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_LinkState: TRzLabel
        Left = 250
        Top = 315
        Width = 400
        Height = 45
        AutoSize = False
        Caption = '--------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -48
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        TextStyle = tsRecessed
      end
      object lab_LateInfo: TLabel
        Left = 250
        Top = 260
        Width = 400
        Height = 35
        AutoSize = False
        Caption = '--------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lab_delay: TLabel
        Left = 25
        Top = 260
        Width = 180
        Height = 35
        Caption = #36831#21040#32479#35745#65306
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -35
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RzPanel1: TRzPanel
        Left = 756
        Top = 0
        Width = 192
        Height = 418
        Align = alRight
        BorderOuter = fsNone
        TabOrder = 0
        object btn_Connect: TRzBitBtn
          Left = 32
          Top = 35
          Width = 148
          Height = 120
          Cursor = crHandPoint
          Caption = #36830#25509
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -35
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btn_ConnectClick
          ImageIndex = 7
          Images = il_Tool
          Layout = blGlyphTop
        end
        object btn_ClearInfo: TRzBitBtn
          Left = 32
          Top = 287
          Width = 148
          Height = 120
          Cursor = crHandPoint
          Caption = #28165#38500
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -35
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btn_ClearInfoClick
          ImageIndex = 6
          Images = il_Tool
          Layout = blGlyphTop
        end
        object btn_disconnect: TRzBitBtn
          Left = 32
          Top = 161
          Width = 148
          Height = 120
          Cursor = crHandPoint
          Caption = #26029#24320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -35
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btn_disconnectClick
          ImageIndex = 7
          Images = il_Tool
          Layout = blGlyphTop
        end
        object chkConFpForAll: TCheckBox
          Left = 32
          Top = 12
          Width = 148
          Height = 17
          Hint = #38750#26412#22320#21306#30340#21592#24037#35201#22312#27492#22788#25171#21345#65292#35831#21246#36873#27492#39033#65292#24182#37325#26032#36830#25509#65294
          Caption = #38750#26412#22320#21306#20154#21592#25171#21345
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
    object ts_StaffList: TRzTabSheet
      Caption = #25171#21345#21015#34920
      object dbg_Intra: TRzDBGrid
        Left = 0
        Top = 0
        Width = 948
        Height = 418
        Align = alClient
        DataSource = DataSource
        DefaultDrawing = True
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
    end
  end
  object sb_Main: TRzStatusBar
    Left = 0
    Top = 679
    Width = 952
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object sp_Update: TRzStatusPane
      Left = 200
      Top = 0
      Width = 310
      Height = 19
      Align = alLeft
      ExplicitLeft = 184
      ExplicitHeight = 0
    end
    object sp_Msg: TRzStatusPane
      Left = 665
      Top = 0
      Width = 287
      Height = 19
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 353
    end
    object vis_FileVer: TRzVersionInfoStatus
      Left = 0
      Top = 0
      Width = 200
      Height = 19
      Align = alLeft
      FieldLabel = 'Ver:'
      Field = vifFileVersion
    end
    object sp_StoreCode: TRzStatusPane
      Left = 510
      Top = 0
      Width = 155
      Height = 19
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 571
    end
  end
  object pan_Time: TRzPanel
    Left = 0
    Top = 595
    Width = 952
    Height = 84
    Align = alBottom
    TabOrder = 3
    object lab_STime: TLabel
      Left = 30
      Top = 27
      Width = 180
      Height = 35
      Caption = #29616#22312#26102#38388#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lab_NowTime: TLabel
      Left = 220
      Top = 27
      Width = 152
      Height = 35
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RzPanel3: TRzPanel
      Left = 695
      Top = 2
      Width = 255
      Height = 80
      Align = alRight
      BorderOuter = fsNone
      TabOrder = 0
      object lab_Language: TLabel
        Left = 39
        Top = 45
        Width = 51
        Height = 19
        Alignment = taRightJustify
        Caption = #35821#35328':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cb_Language: TRzComboBox
        Left = 96
        Top = 42
        Width = 146
        Height = 27
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ItemHeight = 19
        ParentFont = False
        TabOrder = 0
        OnChange = cb_LanguageChange
        Items.Strings = (
          'English'
          #31616#20307#20013#25991
          #32649#30768#12356#12421)
      end
      object RzButton1: TRzButton
        Left = 136
        Top = 4
        Width = 100
        Caption = #19978#20256#32771#21220#25968#25454
        TabOrder = 1
        OnClick = RzButton1Click
      end
      object RzButton2: TRzButton
        Left = 10
        Top = 4
        Width = 120
        Caption = #19979#36733#21592#24037#20449#24687
        TabOrder = 2
        OnClick = RzButton2Click
      end
    end
    object ZKEngine: TZKFPEngX
      Left = 571
      Top = 6
      Width = 24
      Height = 24
      OnCapture = ZKEngineCapture
      ControlData = {
        5450463008545A4B4650456E6700044C656674020003546F7002000557696474
        6802180648656967687402180B456E726F6C6C436F756E7402030B53656E736F
        72496E6465780200095468726573686F6C64020A114F6E65546F4F6E65546872
        6573686F6C64020A10466F7263655365636F6E644D61746368090C4175746F49
        64656E74696679080D4973496D6167654368616E6765080000}
    end
  end
  object rzpnl1: TRzPanel
    Left = 0
    Top = 124
    Width = 952
    Height = 29
    Align = alTop
    BorderInner = fsFlatRounded
    BorderOuter = fsPopup
    TabOrder = 4
    object lblBlt: TRzURLLabel
      Left = 200
      Top = 3
      Width = 749
      Height = 23
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      ParentFont = False
      ExplicitWidth = 10
      ExplicitHeight = 19
    end
    object lbl_freshblt: TRzLabel
      Left = 3
      Top = 3
      Width = 197
      Height = 23
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = #26368#26032#20844#21578#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object XPManifest: TXPManifest
    Left = 636
    Top = 536
  end
  object il_Tool: TImageList
    Height = 64
    Width = 64
    Left = 338
    Top = 536
  end
  object Timer_Update: TTimer
    Interval = 30000
    OnTimer = Timer_UpdateTimer
    Left = 446
    Top = 536
  end
  object ver_Main: TRzVersionInfo
    Left = 610
    Top = 470
  end
  object DataSource: TDataSource
    Left = 525
    Top = 401
  end
  object siLang: TsiLang
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    ActiveLanguage = 2
    LangDispatcher = siLangDispatcher
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
    Left = 700
    Top = 390
    TranslationData = {
      737443617074696F6E730D0A5466726D46696E6765727072696E740146696E67
      65727072696E742053797374656D01D6B8CEC6B4F2BFA8CFB5CDB301ABFCAFBE
      A6D2B6D4A874B2CE010D0A7462725F4D61696E010101010D0A74735F53746166
      66496E666F01496E666F01C7A9B5BDD0C5CFA201C3B1A8ECAB48AEA7A147010D
      0A6C61625F456D706C6F7965650153746166663A01C7A9B5BDD4B1B9A4A3BA01
      C3B1A8ECADFBA475A147010D0A6C61625F54696D650154696D653A01B4F2BFA8
      CAB1BCE4A3BA01A5B4A564AEC9B6A1A147010D0A6C61625F5479706501547970
      653A01B4F2BFA8C0E0D0CDA3BA01A5B4A564C3FEABACA147010D0A6C61625F53
      746174650153746174653A01C1ACBDD3D7B4CCAC3A01B373B1B5AAACBA41A147
      010D0A6C61625F654E616D65012D2D2D2D2D2D2D2D0101010D0A6C61625F734E
      616D65012D2D2D2D2D2D2D2D0101010D0A6C61625F5369676E54696D65012D2D
      2D2D2D2D2D2D0101010D0A6C61625F5369676E54797065012D2D2D2D2D2D2D2D
      0101010D0A6C61625F4C696E6B5374617465012D2D2D2D2D2D2D2D0101010D0A
      527A50616E656C31010101010D0A74735F53746166664C697374014C69737401
      B4F2BFA8C1D0B1ED01A5B4A564A643AAED010D0A73705F557064617465010101
      010D0A73705F4D7367010101010D0A70616E5F54696D65010101010D0A6C6162
      5F5354696D65014E6F772054696D653A01CFD6D4DACAB1BCE4A3BA01B27BA662
      AEC9B6A1A147010D0A6C61625F4E6F7754696D65012D2D2D2D2D2D2D2D010101
      0D0A527A50616E656C33010101010D0A6C61625F4C616E6775616765014C616E
      677561676501D3EFD1D43A01BB79A8A5010D0A6C61625F4C617465496E666F01
      2D2D2D2D2D2D2D2D0101010D0A6C61625F64656C6179014C6174653A01B3D9B5
      BDCDB3BCC6A3BA01BFF0A8ECB2CEAD70A147010D0A62746E5F436F6E6E656374
      01436F6E6E65637401C1ACBDD301B373B1B5010D0A62746E5F436C656172496E
      666F01436C65617201C7E5B3FD01B24DAAC5010D0A62746E5F646973636F6E6E
      65637401446973636F6E6E01B6CFBFAA01C25FB67D010D0A727A706E6C310101
      01010D0A6C626C426C74010101010D0A6C626C5F6672657368626C74014E6577
      6573742042756C6C6574696E3A01D7EED0C2B9ABB8E6A3BA01B3CCB773A4BDA7
      69A152010D0A63686B436F6E4670466F72416C6C01656E61626C6520666F7220
      616C6C20737461666601B7C7B1BEB5D8C7F8C8CBD4B1B4F2BFA801AB44A5BBA6
      61B0CFA448ADFBA5B4A564010D0A527A427574746F6E310155706C6F61642044
      61746101C9CFB4ABBFBCC7DACAFDBEDD01A457B6C7A6D2B6D4BCC6BEDA010D0A
      527A427574746F6E3201446F776E6C6F616420537461666601CFC2D4D8D4B1B9
      A4D0C5CFA201A455B8FCADFBA475AB48AEA7010D0A73705F53746F7265436F64
      65010101010D0A737448696E74730D0A5466726D46696E6765727072696E7401
      0101010D0A7462725F4D61696E010101010D0A70635F5374616666010101010D
      0A74735F5374616666496E666F010101010D0A6C61625F456D706C6F79656501
      0101010D0A6C61625F54696D65010101010D0A6C61625F54797065010101010D
      0A6C61625F5374617465010101010D0A6C61625F654E616D65010101010D0A6C
      61625F734E616D65010101010D0A6C61625F5369676E54696D65010101010D0A
      6C61625F5369676E54797065010101010D0A6C61625F4C696E6B537461746501
      0101010D0A527A50616E656C31010101010D0A74735F53746166664C69737401
      0101010D0A6462675F496E747261010101010D0A73625F4D61696E010101010D
      0A73705F557064617465010101010D0A73705F4D7367010101010D0A7669735F
      46696C65566572010101010D0A70616E5F54696D65010101010D0A6C61625F53
      54696D65010101010D0A6C61625F4E6F7754696D65010101010D0A527A50616E
      656C33010101010D0A6C61625F4C616E6775616765010101010D0A63625F4C61
      6E6775616765010101010D0A5A4B456E67696E65010101010D0A6C61625F4C61
      7465496E666F010101010D0A6C61625F64656C6179010101010D0A62746E5F43
      6F6E6E656374010101010D0A62746E5F436C656172496E666F010101010D0A62
      746E5F646973636F6E6E656374010101010D0A727A706E6C31010101010D0A6C
      626C426C74010101010D0A6C626C5F6672657368626C74010101010D0A63686B
      436F6E4670466F72416C6C010101010D0A527A427574746F6E31010101010D0A
      527A427574746F6E32010101010D0A73705F53746F7265436F6465010101010D
      0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A5466726D46
      696E6765727072696E7401CBCECCE501CBCECCE501CBCECCE5010D0A7462725F
      4D61696E01CBCECCE50101010D0A6C61625F456D706C6F79656501CBCECCE501
      01010D0A6C61625F54696D6501CBCECCE50101010D0A6C61625F5479706501CB
      CECCE50101010D0A6C61625F537461746501CBCECCE50101010D0A6C61625F65
      4E616D6501CBCECCE50101010D0A6C61625F734E616D6501CBCECCE50101010D
      0A6C61625F5369676E54696D6501CBCECCE50101010D0A6C61625F5369676E54
      79706501CBCECCE50101010D0A6C61625F4C696E6B537461746501CBCECCE501
      01010D0A73625F4D61696E01CBCECCE50101010D0A6C61625F5354696D6501CB
      CECCE50101010D0A6C61625F4E6F7754696D6501CBCECCE50101010D0A6C6162
      5F4C616E677561676501CBCECCE50101010D0A63625F4C616E677561676501CB
      CECCE50101010D0A6C61625F4C617465496E666F01CBCECCE50101010D0A6C61
      625F64656C617901CBCECCE50101010D0A62746E5F436F6E6E65637401CBCECC
      E50101010D0A62746E5F436C656172496E666F01CBCECCE50101010D0A62746E
      5F646973636F6E6E65637401CBCECCE50101010D0A6C626C426C7401CBCECCE5
      0101010D0A6C626C5F6672657368626C7401CBCECCE50101010D0A73705F5374
      6F7265436F646501CBCECCE50101010D0A73705F4D736701CBCECCE50101010D
      0A73744D756C74694C696E65730D0A63625F4C616E67756167652E4974656D73
      01456E676C6973682CBCF2CCE5D6D0CEC42CC163C5E9A4A4A4E50101010D0A63
      625F4C616E67756167652E56616C756573010101010D0A7374446C6773436170
      74696F6E730D0A5761726E696E67015761726E696E670101010D0A4572726F72
      014572726F720101010D0A496E666F726D6174696F6E01496E666F726D617469
      6F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D0A5965730126
      5965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E
      63656C0143616E63656C0101010D0A41626F7274012641626F72740101010D0A
      5265747279012652657472790101010D0A49676E6F7265012649676E6F726501
      01010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F2074
      6F20416C6C0101010D0A59657320546F20416C6C0159657320746F2026416C6C
      0101010D0A48656C70012648656C700101010D0A7374537472696E67730D0A4C
      41425F4C4154455F494E464F014C617465206672657175656E6379203A202564
      2C2054696D653A20256401B1BED4C2B3D9B5BD2564B4CEA3ACB9B22564B7D6D6
      D301A5BBA4EBBFF0A8EC2564A6B8A141A6402564A4C0C4C1010D0A4C41425F4C
      4154455F4E4F54014E6F204C617465205265636F726401B1BED4C2C3BBD3D0B3
      D9B5BDBCC7C2BC01A5BBA4EBA853A6B3BFF0A8ECB04FBFFD010D0A4C53303030
      014E6F726D616C01D5FDB3A301A5BFB160010D0A4C5330303101436F6E6E6563
      74205375636365656401B3C9B9A6C1ACBDD30120A6A8A55CB373B1B5010D0A4C
      5330303201436F6E6E65637420556E7375636365737366756C01C1ACBDD3CAA7
      B0DC01B373B1B5A5A2B1D1010D0A4C533030330146696E6765727072696E7420
      697320636C6F736501D6B8CEC6BBFAD2D1B9D8BBFA01ABFCAFBEBEF7A477C3F6
      BEF7010D0A4C5330303401526561642044617465204572726F7201B6C1C8A1CA
      FDBEDDCAA7B0DC01C5AAA8FABCC6BEDAA5A2B1D1010D0A4C5330303501537461
      72742072656164206461746101BFAACABCB6C1C8A1CAFDBEDD01B67DA96CC5AA
      A8FABCC6BEDA010D0A4D53303101506C65617365206E6F742072657065617465
      646C79207369676E2101C7EBB2BBD2AAD6D8B8B4B4F2BFA8A3A101BDD0A4A3AD
      6EADABB45FA5B4A564A149010D0A5354303031014F6E204475747901C9CFB0E0
      01A457AF5A010D0A5354303032014F6666204475747901CFC2B0E001A455AF5A
      010D0A5354303033014F7574676F696E6701CDE2B3F601A57EA558010D0A5354
      3030340152657475726E01CDE2B3F6BBD801A57EA558A65E010D0A5354303035
      014D65616C01D3C3B2CD01A5CEC05C010D0A5354303036014261636B2066726F
      6D204D65616C01D3C3B2CDBBD801A5CEC05CA65E010D0A4D5330320154696D65
      20696E74657276616C20697320696E76616C69642101CAB1BCE4BCE4B8F4B2BB
      D7E3A3A10154696D6520696E74657276616C20697320696E76616C696421010D
      0A73744F74686572537472696E67730D0A5466726D46696E6765727072696E74
      2E48656C7046696C65010101010D0A73625F4D61696E2E53696D706C65436170
      74696F6E010101010D0A7669735F46696C655665722E4669656C644C6162656C
      015665723A0101010D0A63625F4C616E67756167652E54657874010101010D0A
      5A4B456E67696E652E4650456E67696E6556657273696F6E01332E352E303020
      466F7220313A4E0101010D0A5A4B456E67696E652E52656754706C46696C654E
      616D65010101010D0A5A4B456E67696E652E53656E736F72534E010101010D0A
      5A4B456E67696E652E56657254706C46696C654E616D65010101010D0A766572
      5F4D61696E2E46696C6550617468010101010D0A527A4C61756E636865722E41
      6374696F6E014F70656E0101010D0A527A4C61756E636865722E506172616D65
      74657273010101010D0A527A4C61756E636865722E5374617274446972010101
      010D0A6C626C426C742E55524C010101010D0A63625F4C616E67756167652E54
      65787448696E74010101010D0A73744C6F63616C65730D0A7374436F6C6C6563
      74696F6E730D0A6462675F496E7472612E436F6C756D6E735B305D2E5469746C
      652E43617074696F6E010101010D0A737443686172536574730D0A5466726D46
      696E6765727072696E7401414E53495F434841525345540144454641554C545F
      434841525345540144454641554C545F43484152534554010D0A7462725F4D61
      696E01414E53495F434841525345540144454641554C545F4348415253455401
      44454641554C545F43484152534554010D0A6C61625F456D706C6F7965650141
      4E53495F434841525345540144454641554C545F434841525345540144454641
      554C545F43484152534554010D0A6C61625F54696D6501414E53495F43484152
      5345540144454641554C545F434841525345540144454641554C545F43484152
      534554010D0A6C61625F5479706501414E53495F434841525345540144454641
      554C545F434841525345540144454641554C545F43484152534554010D0A6C61
      625F537461746501414E53495F434841525345540144454641554C545F434841
      525345540144454641554C545F43484152534554010D0A6C61625F654E616D65
      01414E53495F434841525345540144454641554C545F43484152534554014445
      4641554C545F43484152534554010D0A6C61625F734E616D6501414E53495F43
      4841525345540144454641554C545F434841525345540144454641554C545F43
      484152534554010D0A6C61625F5369676E54696D6501414E53495F4348415253
      45540144454641554C545F434841525345540144454641554C545F4348415253
      4554010D0A6C61625F5369676E5479706501414E53495F434841525345540144
      454641554C545F434841525345540144454641554C545F43484152534554010D
      0A6C61625F4C696E6B537461746501414E53495F434841525345540144454641
      554C545F434841525345540144454641554C545F43484152534554010D0A7362
      5F4D61696E01414E53495F434841525345540144454641554C545F4348415253
      45540144454641554C545F43484152534554010D0A6C61625F5354696D650141
      4E53495F434841525345540144454641554C545F434841525345540144454641
      554C545F43484152534554010D0A6C61625F4E6F7754696D6501414E53495F43
      4841525345540144454641554C545F434841525345540144454641554C545F43
      484152534554010D0A6C61625F4C616E677561676501414E53495F4348415253
      45540144454641554C545F434841525345540144454641554C545F4348415253
      4554010D0A63625F4C616E6775616765014742323331325F4348415253455401
      44454641554C545F434841525345540144454641554C545F4348415253455401
      0D0A6C61625F4C617465496E666F0144454641554C545F434841525345540144
      454641554C545F434841525345540144454641554C545F43484152534554010D
      0A6C61625F64656C61790144454641554C545F43484152534554014445464155
      4C545F434841525345540144454641554C545F43484152534554010D0A62746E
      5F436F6E6E6563740144454641554C545F434841525345540144454641554C54
      5F434841525345540144454641554C545F43484152534554010D0A62746E5F43
      6C656172496E666F0144454641554C545F434841525345540144454641554C54
      5F434841525345540144454641554C545F43484152534554010D0A62746E5F64
      6973636F6E6E6563740144454641554C545F434841525345540144454641554C
      545F434841525345540144454641554C545F43484152534554010D0A6C626C42
      6C7401414E53495F434841525345540144454641554C545F4348415253455401
      44454641554C545F43484152534554010D0A6C626C5F6672657368626C740144
      454641554C545F434841525345540144454641554C545F434841525345540144
      454641554C545F43484152534554010D0A73705F53746F7265436F6465014445
      4641554C545F434841525345540144454641554C545F43484152534554014445
      4641554C545F43484152534554010D0A73705F4D73670144454641554C545F43
      4841525345540144454641554C545F434841525345540144454641554C545F43
      484152534554010D0A}
  end
  object siLangDispatcher: TsiLangDispatcher
    ActiveLanguage = 2
    NumOfLanguages = 3
    LangNames.Strings = (
      'ENG'
      'CHS'
      'GB5')
    Language = 'CHS'
    Left = 618
    Top = 390
  end
  object RzLauncher: TRzLauncher
    Action = 'Open'
    Timeout = -1
    Left = 701
    Top = 471
  end
  object timer_bbs: TTimer
    OnTimer = timer_bbsTimer
    Left = 552
    Top = 536
  end
  object Timer_LastSystime: TTimer
    Interval = 45000
    OnTimer = Timer_LastSystimeTimer
    Left = 424
    Top = 432
  end
  object Timer_ShowTime: TTimer
    OnTimer = Timer_ShowTimeTimer
    Left = 446
    Top = 608
  end
end
