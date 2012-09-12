object dmFinger: TdmFinger
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 211
  Width = 430
  object aq_Finger: TADOQuery
    Connection = dmMain.ac_Local
    Parameters = <>
    Left = 42
    Top = 22
  end
  object am_Finger: TADOCommand
    Connection = dmMain.ac_Local
    Parameters = <>
    Left = 160
    Top = 18
  end
  object MyQ_Finger: TMyQuery
    Connection = dmMain.MyC_Server
    Left = 48
    Top = 112
  end
  object MyM_Finger: TMyCommand
    Connection = dmMain.MyC_Server
    Left = 152
    Top = 104
  end
end
