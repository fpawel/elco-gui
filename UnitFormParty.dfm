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
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    ColWidths = (
      64
      64
      64
      64)
    RowHeights = (
      24)
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    BlendColor = clWindow
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Height = 20
    Width = 20
    Left = 536
    Top = 98
    Bitmap = {
      494C01010300E002440314001400FFFFFF002110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF0C08044038261488382614883826
      1488382614883826148838261488382614883826148838261488382614883826
      14883826148838261488382614883826148838261488382614886F4C26BF0705
      0232000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000010017000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFE5DFC8FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000407013649861EDC1D340B8A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFD3D9B1FF76BC40FFA5CA
      77FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      000000000000000000000000000000000000000000000C09053F362819820000
      0007000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000204012B48831DD770CC2DFF5BA624EC182D0A8000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFD9DABAFF7ABF44FF70CC2DFF74C4
      37FFAACB80FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      000000000000000000000000000000000000000000009F7B55DBF0D9BFFE3527
      1981000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000408
      01364B881EDB70CC2DFF68BD29FA70CC2DFF5EAB26EF1C320B88000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFD3DAB1FF79BF41FF70CC2DFF6FC52FFF70CC
      2DFF72C536FFA5CA79FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000C09
      053F3628198200000007000000000000000000000000674D32B29F7D58DC0D09
      0540000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000030601334984
      1DD870CC2DFF5EAB26F0223E0E974B881DDB70CC2DFF5CA524EC1A2F0A840000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFD5DAB4FF7BBF42FF70CC2DFF72C334FF9DC76EFF79BE
      41FF70CC2DFF75C437FFA8CB7CFFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000009F7B
      55DBF0D9BFFE3527198100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000205012B4A881EDB70CC
      2DFF5DAA26EE192E0A8200000000030601314A871DDA70CC2CFF5BA624EC1627
      0878000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFD9DCBAFF78BE41FF70CC2DFF74C636FFAACC7EFFF2E4D7FFD6DB
      B6FF7AC042FF70CC2CFF74C437FFAFCD85FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F780000000000000000674D
      32B29F7D58DC0D09054000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000030601304C8B1FDD70CC2DFF5CA5
      25EC152708770000000000000000000000000204012A48831DD770CC2DFF5EAA
      26EF1B310B860000000000000000000000000000000000000000000000000000
      0000D7DBB6FF79BF41FF70CC2DFF75C438FFB0CD85FFF2E4D7FFF2E4D7FFF2E4
      D7FFDADBBAFF7BBE43FF70CC2DFF73C435FFA6CA7AFFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000654C32B19F7C56DB0C09053F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000010015457E1CD35FAC26F11628
      097A00000000000000000000000000000000000000000205012B4B881DDB70CC
      2DFF5CA524EC192E0A8200000000000000000000000000000000000000000000
      0000E6E0C8FF7DBF46FF72C335FFAECE84FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFD9DCBAFF79BE41FF70CC2DFF75C437FFA9CB7DFFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A07D57DCF0D9BFFE35271981000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000100140E1A06620000
      00000000000000000000000000000000000000000000000000000204012A4883
      1DD770CC2DFF5EAA26EF1B300B85000000000000000000000000000000000000
      0000F2E4D7FFE7E0C9FFBBD194FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFDADBBAFF7BBE43FF70CC2DFF73C535FFA8CB7CFFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000D0906413628198200000008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000306
      013149861DD970CC2CFF5CA625ED162708780000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFD6DBB6FF7AC042FF70CC2CFF74C336FFAFCD
      85FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      00000000000000000007362819820C09053F0000000000000000000000000000
      000000000000000000000000000000000007362819820C09053F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000306013149861DD970CC2CFF5CA625ED1627087800000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFD6DBB6FF7AC042FF70CC2CFF74C3
      36FFAFCD85FFF2E4D7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      00000000000037281A83F0D9BFFE9F7C56DB0000000000000000000000000000
      000000000000000000000000000037281A83F0D9BFFE9F7C56DB000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000306013149861DD970CC2CFF5CA625ED15270877000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFD6DBB6FF7AC042FF70CC
      2CFF74C336FFAFCE86FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000D0905409F7D58DC674D32B20000000000000000000000000000
      00000000000000000000000000000D0905409F7D58DC674D32B2000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000306013149861DD970CC2CFF5CA625ED152708770000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFD6DBB6FF7AC0
      42FF70CC2CFF74C336FFAFCE86FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0007362819820C09053F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000204012948831DD770CB2DFF59A324ED060C
      0244F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFDADB
      BBFF7BBF43FF70CB2DFF71C036FFCCD7A9FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000003728
      1A83F0D9BFFE9F7C56DB00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000204012947811CD825430F9D0000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFDADBBBFF79BD42FF9AC66BFFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000D09
      05409F7D58DC674D32B200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000010016000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFE5DFC7FFF2E4D7FFF2E4D7FF2C1E0F7800000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000654C32B19F7C56DB0C09
      053F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF3F2B169000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A07D57DCF0D9BFFE3527
      1981000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4
      D7FFF2E4D7FFF2E4D7FFF2E4D7FFF2E4D7FF0604022E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000D090641362819820000
      0008000000000000000000000000000000000000000000000000000000000000
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
