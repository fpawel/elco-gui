object FormProductTypeDialog: TFormProductTypeDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1052#1077#1089#1090#1072' '#1089#1090#1077#1085#1076#1072': '#1089' 12 '#1087#1086' 45'
  ClientHeight = 79
  ClientWidth = 271
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 21
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 257
    Height = 65
    Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077':'
    TabOrder = 0
    object ComboBox1: TComboBox
      AlignWithMargins = True
      Left = 16
      Top = 25
      Width = 121
      Height = 29
      TabOrder = 0
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 143
      Top = 25
      Width = 105
      Height = 29
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
