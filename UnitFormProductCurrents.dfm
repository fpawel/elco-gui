object FormProductCurrents: TFormProductCurrents
  Left = 0
  Top = 0
  Caption = 'FormProductCurrents'
  ClientHeight = 442
  ClientWidth = 635
  Color = clHighlightText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object StringGrid1: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 436
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
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    ExplicitHeight = 294
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
end
