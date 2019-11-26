object FormFirmwareBytes: TFormFirmwareBytes
  Left = 0
  Top = 0
  Caption = #1041#1072#1081#1090#1099' '#1087#1072#1084#1103#1090#1080
  ClientHeight = 299
  ClientWidth = 787
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 18
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 674
    Height = 293
    Align = alClient
    BorderStyle = bsNone
    ColCount = 17
    DefaultColWidth = 30
    DefaultDrawing = False
    FixedColor = clBackground
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clBlack
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    ExplicitWidth = 629
    RowHeights = (
      24)
  end
  object Panel1: TPanel
    Left = 680
    Top = 0
    Width = 107
    Height = 299
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 16
      Width = 75
      Height = 25
      Caption = #1054#1082
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 16
      Top = 47
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
end
