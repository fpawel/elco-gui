object FormNewPartyDialog: TFormNewPartyDialog
  Left = 0
  Top = 0
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1087#1072#1088#1090#1080#1080'. '#1042#1074#1086#1076' '#1089#1077#1088#1080#1081#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074'.'
  ClientHeight = 394
  ClientWidth = 726
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 370
    Width = 706
    Height = 14
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alBottom
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 35
  end
  object Panel1: TPanel
    Left = 640
    Top = 0
    Width = 86
    Height = 360
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 80
      Height = 54
      Align = alTop
      Caption = #1053#1086#1074#1072#1103' '#1087#1072#1088#1090#1080#1103
      TabOrder = 0
      WordWrap = True
      OnClick = Button1Click
    end
  end
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 634
    Height = 354
    Align = alClient
    BorderStyle = bsNone
    ColCount = 4
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnDrawCell = StringGrid1DrawCell
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
  object PopupMenu1: TPopupMenu
    Left = 440
    Top = 176
    object N1: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ShortCut = 16451
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ShortCut = 16470
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      ShortCut = 16449
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      OnClick = N4Click
    end
  end
end
