object FormAppConfig: TFormAppConfig
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 462
  ClientWidth = 699
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object Panel1: TPanel
    Left = 184
    Top = 0
    Width = 161
    Height = 357
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitHeight = 698
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 155
      Height = 21
      Align = alTop
      Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077
      ExplicitWidth = 88
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 62
      Width = 155
      Height = 21
      Align = alTop
      Caption = #1043#1057#1054'-'#1055#1043#1057'1'
      ExplicitWidth = 74
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 121
      Width = 155
      Height = 21
      Align = alTop
      Caption = #1043#1057#1054'-'#1055#1043#1057'2'
      ExplicitWidth = 74
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 180
      Width = 155
      Height = 21
      Align = alTop
      Caption = #1043#1057#1054'-'#1055#1043#1057'3'
      ExplicitWidth = 74
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 239
      Width = 155
      Height = 21
      Align = alTop
      Caption = #1055#1043#1057' '#1082#1086#1085#1094#1072' '#1096#1082#1072#1083#1099
      ExplicitWidth = 129
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 298
      Width = 155
      Height = 21
      Align = alTop
      Caption = #1056#1072#1089#1095#1105#1090' T '#8304'C'
      WordWrap = True
      ExplicitWidth = 80
    end
    object ComboBoxProductTypeName: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 155
      Height = 26
      Align = alTop
      Style = csOwnerDrawFixed
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 20
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'COM1'
      OnChange = ComboBoxProductTypeNameChange
      Items.Strings = (
        'COM1')
    end
    object EditC1: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 89
      Width = 155
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitTop = 186
      ExplicitWidth = 203
    end
    object EditC2: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 148
      Width = 155
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitTop = 201
      ExplicitWidth = 203
    end
    object EditC3: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 207
      Width = 155
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 0
      ExplicitTop = 266
      ExplicitWidth = 203
    end
    object ComboBoxEndScaleGas: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 266
      Width = 155
      Height = 26
      Align = alTop
      Style = csOwnerDrawFixed
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 20
      ItemIndex = 0
      ParentFont = False
      TabOrder = 4
      Text = #1055#1043#1057'2'
      OnChange = ComboBoxComportProductsChange
      Items.Strings = (
        #1055#1043#1057'2'
        #1055#1043#1057'3')
    end
    object ComboBoxPointsMethod: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 325
      Width = 155
      Height = 26
      Align = alTop
      Style = csOwnerDrawFixed
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 20
      ItemIndex = 0
      ParentFont = False
      TabOrder = 5
      Text = '2 '#1090#1086#1095#1082#1080
      OnChange = ComboBoxProductTypeNameChange
      Items.Strings = (
        '2 '#1090#1086#1095#1082#1080
        '3 '#1090#1086#1095#1082#1080)
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 357
    Width = 699
    Height = 105
    Align = alBottom
    Caption = #1058#1077#1082#1089#1090' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1069#1061#1071
    TabOrder = 1
    ExplicitLeft = 950
    ExplicitTop = 8
    ExplicitWidth = 145
    object Memo1: TMemo
      Left = 2
      Top = 23
      Width = 695
      Height = 80
      Align = alClient
      BorderStyle = bsNone
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      OnChange = ComboBoxProductTypeNameChange
      ExplicitWidth = 641
    end
  end
  object Panel2: TPanel
    Left = 345
    Top = 0
    Width = 176
    Height = 357
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    ExplicitLeft = 161
    ExplicitHeight = 698
    object Label14: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 94
      Height = 21
      Align = alTop
      Caption = #1060#1086#1085','#1084#1080#1085'.'#1084#1082#1040
      WordWrap = True
    end
    object Label23: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 62
      Width = 99
      Height = 21
      Align = alTop
      Caption = #1060#1086#1085','#1084#1072#1082#1089'.'#1084#1082#1040
      WordWrap = True
    end
    object Label17: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 121
      Width = 130
      Height = 21
      Align = alTop
      Caption = 'D.'#1092#1086#1085'20.'#1084#1072#1082#1089'.'#1084#1082#1040
      WordWrap = True
    end
    object Label24: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 180
      Width = 145
      Height = 21
      Align = alTop
      Caption = #1050#1095'20.'#1084#1080#1085'.'#1084#1082#1040'/'#1082#1086#1085#1094'.'
      WordWrap = True
    end
    object Label25: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 239
      Width = 150
      Height = 21
      Align = alTop
      Caption = #1050#1095'20.'#1084#1072#1082#1089'.'#1084#1082#1040'/'#1082#1086#1085#1094'.'
      WordWrap = True
    end
    object Label26: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 298
      Width = 145
      Height = 21
      Align = alTop
      Caption = #1050#1095'50.'#1084#1080#1085'.'#1084#1082#1040'/'#1082#1086#1085#1094'.'
      WordWrap = True
    end
    object Editfon20Min: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 170
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 38
      ExplicitWidth = 258
    end
    object Editfon20Max: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 89
      Width = 170
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 134
      ExplicitWidth = 258
    end
    object EditDfon20Max: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 148
      Width = 170
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 220
      ExplicitWidth = 258
    end
    object EditKch20Min: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 207
      Width = 170
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitTop = 220
      ExplicitWidth = 258
    end
    object EditKch20Max: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 266
      Width = 170
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitTop = 298
      ExplicitWidth = 258
    end
    object EditKch50Min: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 325
      Width = 170
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 19
      ExplicitTop = 372
      ExplicitWidth = 258
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 184
    Height = 357
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 3
    ExplicitLeft = -15
    ExplicitTop = -6
    ExplicitHeight = 379
    object Label15: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 178
      Height = 21
      Align = alTop
      Caption = #1057#1054#1052' '#1087#1086#1088#1090' '#1089#1090#1077#1085#1076#1072
      ExplicitWidth = 126
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 62
      Width = 178
      Height = 21
      Align = alTop
      Caption = #1057#1054#1052' '#1087#1086#1088#1090' '#1075#1072#1079#1086#1074#1086#1075#1086' '#1073#1083#1086#1082#1072
      ExplicitWidth = 186
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 121
      Width = 178
      Height = 21
      Align = alTop
      Caption = #1058#8304'C '#1086#1082#1088#1091#1078#1072#1102#1097#1077#1081' '#1089#1088#1077#1076#1099
      WordWrap = True
      ExplicitWidth = 173
    end
    object Label13: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 180
      Width = 178
      Height = 21
      Align = alTop
      Caption = #1055#1088#1086#1076#1091#1074#1082#1072' '#1075#1072#1079#1072', '#1084#1080#1085'.'
      WordWrap = True
      ExplicitWidth = 142
    end
    object Label16: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 239
      Width = 178
      Height = 21
      Align = alTop
      Caption = #1042#1099#1076#1077#1088#1078#1082#1072'  '#1058#8304'C, '#1084#1080#1085'.'
      WordWrap = True
      ExplicitWidth = 145
    end
    object Label9: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 298
      Width = 178
      Height = 21
      Align = alTop
      Caption = #1058#1080#1087' '#1084#1080#1082#1088#1086#1089#1093#1077#1084#1099' '#1087#1072#1084#1103#1090#1080
      WordWrap = True
      ExplicitWidth = 176
    end
    object ComboBoxComportProducts: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 178
      Height = 26
      Align = alTop
      Style = csOwnerDrawFixed
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 20
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'COM1'
      OnChange = ComboBoxComportProductsChange
      Items.Strings = (
        'COM1')
    end
    object ComboBoxComportGas: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 89
      Width = 178
      Height = 26
      Align = alTop
      Style = csOwnerDrawFixed
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 20
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = 'COM1'
      OnChange = ComboBoxComportProductsChange
      Items.Strings = (
        'COM1')
    end
    object EditAmbientTemp: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 148
      Width = 178
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'EditPgs1'
      OnChange = ComboBoxComportProductsChange
      ExplicitLeft = 19
      ExplicitTop = 220
      ExplicitWidth = 274
    end
    object EditDurMinutesBlowGas: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 207
      Width = 178
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'EditPgs1'
      OnChange = ComboBoxComportProductsChange
      ExplicitTop = 266
      ExplicitWidth = 274
    end
    object EditDurMinutesHoldTemperature: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 266
      Width = 178
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'EditPgs1'
      OnChange = ComboBoxComportProductsChange
      ExplicitLeft = 6
      ExplicitTop = 325
      ExplicitWidth = 274
    end
    object ComboBoxChipType: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 325
      Width = 178
      Height = 26
      Align = alTop
      Style = csOwnerDrawFixed
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      TabOrder = 5
      OnChange = ComboBoxComportProductsChange
      Items.Strings = (
        '24LC16'
        '24LC64'
        '24LC256')
    end
  end
  object Panel4: TPanel
    Left = 521
    Top = 0
    Width = 168
    Height = 357
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel4'
    ShowCaption = False
    TabOrder = 4
    ExplicitHeight = 379
    object Label27: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 150
      Height = 21
      Align = alTop
      Caption = #1050#1095'50.'#1084#1072#1082#1089'.'#1084#1082#1040'/'#1082#1086#1085#1094'.'
      WordWrap = True
    end
    object Label28: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 62
      Width = 125
      Height = 21
      Align = alTop
      Caption = 'D.'#1092#1086#1085'50.'#1084#1080#1085'.'#1084#1082#1040
      WordWrap = True
    end
    object Label29: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 121
      Width = 130
      Height = 21
      Align = alTop
      Caption = 'D.'#1092#1086#1085'50.'#1084#1072#1082#1089'.'#1084#1082#1040
      WordWrap = True
    end
    object Label30: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 180
      Width = 159
      Height = 21
      Align = alTop
      Caption = 'D.'#1092#1086#1085'.'#1085#1077#1080#1079#1084'.'#1084#1072#1082#1089'.'#1084#1082#1040
      WordWrap = True
    end
    object EditKch50Max: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 162
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 38
      ExplicitWidth = 210
    end
    object EditDfon50Min: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 89
      Width = 162
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 97
      ExplicitWidth = 210
    end
    object EditDfon50Max: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 148
      Width = 162
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 156
      ExplicitWidth = 210
    end
    object EditNotMeasuredMax: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 207
      Width = 162
      Height = 26
      Align = alTop
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'EditPgs1'
      OnChange = ComboBoxProductTypeNameChange
      ExplicitLeft = 6
      ExplicitTop = 215
      ExplicitWidth = 210
    end
  end
  object TimerDebounceParty: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerDebouncePartyTimer
    Left = 82
    Top = 416
  end
end
