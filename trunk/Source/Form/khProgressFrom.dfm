object ProgressForm: TProgressForm
  Left = 265
  Top = 265
  AutoSize = True
  BorderStyle = bsNone
  Caption = #36827#24230#26174#31034
  ClientHeight = 81
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object SpeedButton1: TSpeedButton
    Left = 0
    Top = 0
    Width = 297
    Height = 81
    Enabled = False
  end
  object lblTitle: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 12
    Caption = 'lblTitle'
  end
  object lab_Msg: TLabel
    Left = 8
    Top = 27
    Width = 84
    Height = 12
    Caption = 'Please wait...'
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 48
    Width = 281
    Height = 23
    Smooth = True
    TabOrder = 0
  end
end
