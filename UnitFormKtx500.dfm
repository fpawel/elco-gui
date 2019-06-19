object FormKtx500: TFormKtx500
  Left = 0
  Top = 0
  Caption = 'FormKtx500'
  ClientHeight = 600
  ClientWidth = 946
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 946
    Height = 600
    Legend.Alignment = laBottom
    Legend.CheckBoxes = True
    Legend.DrawBehind = True
    Legend.Font.Charset = RUSSIAN_CHARSET
    Legend.Font.Height = -16
    Legend.Font.Name = 'Tahoma'
    Legend.FontSeriesColor = True
    Legend.Title.Font.Height = -16
    Legend.Title.Margins.Left = 0
    Legend.Title.Margins.Top = 0
    Legend.Title.Margins.Right = 0
    Legend.Title.Margins.Bottom = 0
    Legend.TopPos = 0
    MarginBottom = 0
    MarginLeft = 20
    MarginRight = 5
    MarginTop = 5
    MarginUnits = muPixels
    Title.Font.Charset = RUSSIAN_CHARSET
    Title.Font.Color = clBlack
    Title.Font.Height = -19
    Title.Font.Name = 'Consolas'
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Title.VertMargin = 0
    BottomAxis.Grid.SmallDots = True
    LeftAxis.Grid.Width = 0
    LeftAxis.Grid.SmallDots = True
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Grid.SmallDots = True
    RightAxis.Grid.Visible = False
    RightAxis.Maximum = 1.100000000000000000
    RightAxis.Minimum = -0.100000000000000000
    TopAxis.Visible = False
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    Color = clWindow
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object SeriesCurrentTemperature: TFastLineSeries
      SeriesColor = clBlue
      Title = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
      LinePen.Color = clBlue
      LinePen.Width = 0
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object SeriesDestinationTemperature: TFastLineSeries
      Active = False
      SeriesColor = clTeal
      Title = #1059#1089#1090#1072#1074#1082#1072
      LinePen.Color = clTeal
      LinePen.Width = 0
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object SeriesOnOff: TFastLineSeries
      Legend.Text = #1056#1077#1078#1080#1084
      LegendTitle = #1056#1077#1078#1080#1084
      Selected.Hover.Visible = True
      Marks.Callout.Length = 0
      PercentFormat = '##0.##,%'
      SeriesColor = clRed
      VertAxis = aRightAxis
      LinePen.Color = clRed
      TreatNulls = tnDontPaint
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object SeriesCoolOnOff: TFastLineSeries
      Legend.Text = #1050#1086#1084#1087#1088#1077#1089#1089#1086#1088
      LegendTitle = #1050#1086#1084#1087#1088#1077#1089#1089#1086#1088
      Selected.Hover.Visible = True
      Active = False
      Marks.Callout.Length = 0
      PercentFormat = '##0.##,%'
      SeriesColor = clMaroon
      VertAxis = aRightAxis
      LinePen.Color = clMaroon
      TreatNulls = tnDontPaint
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
