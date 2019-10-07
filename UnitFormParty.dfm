object FormParty: TFormParty
  Left = 0
  Top = 0
  Caption = 'FormParty'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 293
    Align = alClient
    BorderStyle = bsNone
    ColCount = 4
    DefaultDrawing = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnDrawCell = StringGrid1DrawCell
    OnMouseDown = StringGrid1MouseDown
    OnSelectCell = StringGrid1SelectCell
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 96
    object MenuCheck: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      OnClick = MenuCheckClick
    end
    object MenuUncheck: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      OnClick = MenuCheckClick
    end
    object N1: TMenuItem
      Caption = #1055#1072#1089#1087#1086#1088#1090
      OnClick = N1Click
    end
  end
end
