object FormJournalParties: TFormJournalParties
  Left = 0
  Top = 0
  Caption = 'FormJournalParties'
  ClientHeight = 557
  ClientWidth = 635
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 369
    Top = 0
    Width = 5
    Height = 557
    ExplicitLeft = 265
    ExplicitHeight = 300
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 557
    Align = alLeft
    BevelOuter = bvNone
    Constraints.MinWidth = 265
    TabOrder = 0
    OnResize = Panel1Resize
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 363
      Height = 520
      Align = alClient
      BorderStyle = bsNone
      ColCount = 4
      DefaultRowHeight = 22
      DefaultDrawing = False
      FixedColor = clBackground
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      GradientEndColor = clBlack
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDrawCell = StringGrid1DrawCell
      OnKeyDown = StringGrid1KeyDown
      OnSelectCell = StringGrid1SelectCell
      ColWidths = (
        64
        64
        64
        64)
      RowHeights = (
        22)
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 369
      Height = 31
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '   '#1044#1072#1090#1072
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object ComboBox1: TComboBox
        Left = 77
        Top = 2
        Width = 132
        Height = 26
        Style = csOwnerDrawFixed
        Color = clHighlightText
        ItemHeight = 20
        ItemIndex = 0
        TabOrder = 0
        Text = '11.11.2018'
        OnChange = ComboBox1Change
        Items.Strings = (
          '11.11.2018')
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 144
    object MenuDeleteItem: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1079#1072#1075#1088#1091#1079#1082#1080
      OnClick = MenuDeleteItemClick
    end
    object MenuCopyItem: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1079#1072#1075#1088#1091#1079#1082#1080
      OnClick = MenuCopyItemClick
    end
    object MenuPDF: TMenuItem
      Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1079#1072#1075#1088#1091#1079#1082#1077
      OnClick = MenuPDFClick
    end
  end
end
