object FormInterrogate: TFormInterrogate
  Left = 0
  Top = 0
  Caption = #1054#1087#1088#1086#1089' '#1089#1090#1077#1085#1076#1072
  ClientHeight = 300
  ClientWidth = 871
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 41
    Width = 865
    Height = 256
    Align = alClient
    BorderStyle = bsNone
    ColCount = 4
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 871
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 169
      Height = 38
      Align = alLeft
      Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1086#1087#1088#1086#1089
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
