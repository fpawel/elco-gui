object FormInterrogate: TFormInterrogate
  Left = 0
  Top = 0
  Caption = 'FormInterrogate'
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
    Top = 3
    Width = 865
    Height = 294
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
end
