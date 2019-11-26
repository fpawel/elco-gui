object FormFirmwareBytes: TFormFirmwareBytes
  Left = 0
  Top = 0
  Caption = 'FormFirmwareBytes'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    RowHeights = (
      24)
  end
end
