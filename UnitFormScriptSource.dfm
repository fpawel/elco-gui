object FormScriptSource: TFormScriptSource
  Left = 0
  Top = 0
  Caption = #1057#1094#1077#1085#1072#1088#1080#1081
  ClientHeight = 288
  ClientWidth = 269
  Color = clHighlightText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 18
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 267
    Width = 263
    Height = 18
    Align = alBottom
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 41
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 269
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clGradientInactiveCaption
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object ToolBar6: TToolBar
      Left = 0
      Top = 0
      Width = 269
      Height = 33
      Align = alClient
      ButtonHeight = 30
      ButtonWidth = 30
      Caption = 'ToolBarCancel'
      Color = clGradientInactiveCaption
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ImageList4
      ParentColor = False
      TabOrder = 0
      object ToolButtonStop: TToolButton
        Left = 0
        Top = 0
        Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1089#1094#1077#1085#1072#1088#1080#1081
        Caption = 'ToolButtonCancel'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonStopClick
      end
      object ToolButton1: TToolButton
        Left = 30
        Top = 0
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1094#1077#1085#1072#1088#1080#1081' '#1080#1079' '#1092#1072#1081#1083#1072
        Caption = 'ToolButton1'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 60
        Top = 0
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1094#1077#1085#1072#1088#1080#1081' '#1074' '#1092#1072#1081#1083
        Caption = #1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1094#1077#1085#1072#1088#1080#1081' '#1074' '#1092#1072#1081#1083
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton2Click
      end
    end
  end
  object RichEdit1: TRichEdit
    AlignWithMargins = True
    Left = 3
    Top = 36
    Width = 263
    Height = 225
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Zoom = 100
  end
  object ImageList4: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 20
    Width = 20
    Left = 104
    Top = 58
    Bitmap = {
      494C010103000800040014001400FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003828
      1785382817850000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A57441E4AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0A57441E40000
      000000000000000000000000000048352297A58C72DBA58C72DBA58C72DBA58C
      72DBA58C72DBA58C72DBA58C72DBAB8C6BE1C6A078F3F5EADEFFECD4BBFFEBB9
      85FFE9B682FE4A382697000000000000000000000000A1774AE0A58766DBCB9A
      65FBD7B694FAD7B694FAD7B694FAD7B694FAD7B694FAD7B694FAD7B694FAD7B6
      94FAD7B694FAD7B694FAD7B694FAD7B694FACB9A65FBA58766DBA1774AE00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E0CDFFE7B582FFFDCC
      98FFFDCC98FFDBA872FA140E08500000000000000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EADFFFE2AF7AFFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFAB7F51E00806033500000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFE5C8AAFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C0
      9DFFE1C09DFFE1C09DFFE5C8AAFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBD2B7FFE4C09BFFD6A26BFFFDCC
      98FFFDCC98FFC7935BF84E37219B23190E6A00000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDD5ABFFFDCE9CFFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFF4E8DBFFE1C0
      9DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFF4E8DBFFE2BD96FFFDCC
      98FFFDCC98FFBE956AEE000000000000000000000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFE5C8AAFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C0
      9DFFE1C09DFFE1C09DFFE5C8AAFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFAF4FFFEE0C1FFFDCD99FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2BD96FFFDCC
      98FFFDCC98FFBE956AEE000000000000000000000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFF5EBFFFDD9B2FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFF5EADEFFE5C7
      A9FFE5C7A9FFE5C7A9FFE5C7A9FFE5C7A9FFF5EADEFFFFFFFFFFE3BF9AFFE1AF
      79FFE1AF79FFBB936AEC000000000000000000000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFE5C8AAFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C0
      9DFFE1C09DFFE1C09DFFE5C8AAFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF1
      E4FFFDD5A9FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFF4E8DBFFE1C0
      9DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFF4E8DBFFFFFFFFFFFFFF
      FFFFFFFFFFFF9E9184D0000000000000000000000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFEFDFFFEEBD6FFFDD0A0FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF94724ED6000000000000000000000000AA8A67DFFEF0DFFFE3C1
      9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFEFDFFFEEBD6FFFDD0A0FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFF5EADEFFE5C7
      A9FFE5C7A9FFE5C7A9FFE5C7A9FFE5C7A9FFF5EADEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF644A2FB2000000000000000000000000AA8A67DFFEF0DFFFE4C1
      9BFFE4C19CFFE4C19CFFE4C19CFFE4C19CFFE4C19CFFE4C19CFFE4C19CFFE4C1
      9CFFE4C19CFFE4C19CFFE4C19CFFE4C19CFFE4C19BFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF1
      E4FFFDD5A9FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFF4E8DBFFE1C0
      9DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFE1C09DFFF4E8DBFFFFFF
      FFFFFFFFFFFF533E2AA0000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFFFFFFFFFFFFFFFFF5EBFFFDD9B2FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF533E2AA0000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0
      DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFEE6CCFFFFFAF4FFFEE0C1FFFDCD99FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF533E2AA0000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFD39C63FFD9A36BFFDCA871FFDCA871FFDCA871FFDCA871FFDCA8
      71FFDCA871FFE1B282FFEED0B1FFFEF0DFFFFEF0DFFFFEF0DFFFAA8A67DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDD5ABFFFDCE9CFFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C2A0FFE4C19DFFE4C19DFFE4C1
      9DFFD4A371FE61452BAF000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFCE9254FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFF0C7
      9AFFF0C79AFFFEDCB6FFE2B98EFFFEF0DFFFFEF0DFFFFEF0DFFFA78560DF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFFEF0DFFFEFD6
      BAFE936D46D500000000000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFCE9254FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFE2B2
      7EFFE2B27EFFFEDCB6FFE2B98EFFFEF0DFFFFEF0DFFFC6AB8FEB271D136F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFFEF0DFFFEFD6BAFE936D
      46D50000000000000000000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFCE9254FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFE2B2
      7EFFE2B27EFFFEDCB6FFE2B98EFFFEF0DFFFC6AB8FEB271D136F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AB7F51E0FDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC
      98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFFDCC98FFAB7F51E00000
      0000000000000000000000000000533E2AA0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3C19FFFEFD6BAFE936D46D50000
      00000000000000000000000000000000000000000000AA8A67DFFEF0DFFFFEF0
      DFFFFEF0DFFFCE9254FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFFEDCB6FFF0C7
      9AFFF0C79AFFFEDCB6FFE2B98EFFC6AB8FEB271D136F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A57441E4AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F
      51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0AB7F51E0A57441E40000
      000000000000000000000000000048352297A88C6CDFA88C6CDFA88C6CDFA88C
      6CDFA88C6CDFA88C6CDFA88C6CDFA88C6CDFC09364F38B6844D0000000000000
      00000000000000000000000000000000000000000000A57A49E4A88764DFA887
      64DFA88764DFC98D4CFFD7A167FFDAA56CFFDAA56CFFDAA56CFFDAA56CFFDAA5
      6CFFDAA56CFFD5A470FBBE8D5AF2251C126D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000140000000100010000000000F00000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000}
  end
end
