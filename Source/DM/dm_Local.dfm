object dmLocal: TdmLocal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 287
  Width = 489
  object aq_Staff: TADOQuery
    Connection = dmMain.ac_Local
    Parameters = <>
    Left = 42
    Top = 30
  end
  object aq_User: TADOQuery
    Connection = dmMain.ac_Local
    Parameters = <>
    Left = 42
    Top = 118
  end
end
