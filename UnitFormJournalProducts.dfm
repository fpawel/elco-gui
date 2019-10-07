object FormJournalProducts: TFormJournalProducts
  Left = 0
  Top = 0
  Caption = 'FormJournalProducts'
  ClientHeight = 300
  ClientWidth = 1072
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1072
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 230
      Top = 5
      Width = 267
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = Edit1Change
      OnKeyDown = Edit1KeyDown
      ExplicitHeight = 24
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 60
      Height = 33
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 5
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      Caption = #1060#1080#1083#1100#1090#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      AlignWithMargins = True
      Left = 75
      Top = 5
      Width = 145
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      Style = csOwnerDrawFixed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 17
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      Items.Strings = (
        #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
        #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        #1053#1086#1084#1077#1088' '#1069#1061#1071
        #1053#1086#1084#1077#1088' '#1079#1072#1075#1088#1091#1079#1082#1080)
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 505
      Top = 3
      Width = 77
      Height = 27
      Align = alLeft
      Caption = #1087#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 36
    Width = 1066
    Height = 261
    Align = alClient
    BorderStyle = bsNone
    ColCount = 4
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    TabOrder = 1
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
    OnSelectCell = StringGrid1SelectCell
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
  object Timer1: TTimer
    Left = 352
    Top = 152
  end
end
