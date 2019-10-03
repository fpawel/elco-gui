object FormAppConfig: TFormAppConfig
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 698
  ClientWidth = 645
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object GroupBox3: TGroupBox
    Left = 0
    Top = 281
    Width = 645
    Height = 312
    Align = alClient
    Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1082#1072#1095#1077#1089#1090#1074#1072' '#1069#1061#1071
    TabOrder = 0
    object GridPanel3: TGridPanel
      Left = 2
      Top = 23
      Width = 641
      Height = 287
      Align = alClient
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 120.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 120.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = Label10
          Row = 0
        end
        item
          Column = 1
          Control = Label11
          Row = 0
        end
        item
          Column = 2
          Control = Label12
          Row = 0
        end
        item
          Column = 0
          Control = Label14
          Row = 1
        end
        item
          Column = 1
          Control = Editfon20Min
          Row = 1
        end
        item
          Column = 2
          Control = Editfon20Max
          Row = 1
        end
        item
          Column = 0
          Control = Label17
          Row = 2
        end
        item
          Column = 2
          Control = EditDfon20Max
          Row = 2
        end
        item
          Column = 1
          Control = Label18
          Row = 2
        end
        item
          Column = 0
          Control = Label19
          Row = 3
        end
        item
          Column = 1
          Control = EditKch20Min
          Row = 3
        end
        item
          Column = 2
          Control = EditKch20Max
          Row = 3
        end
        item
          Column = 0
          Control = Label20
          Row = 4
        end
        item
          Column = 1
          Control = EditKch50Min
          Row = 4
        end
        item
          Column = 2
          Control = EditKch50Max
          Row = 4
        end
        item
          Column = 0
          Control = Label21
          Row = 5
        end
        item
          Column = 1
          Control = EditDfon50Min
          Row = 5
        end
        item
          Column = 2
          Control = EditDfon50Max
          Row = 5
        end
        item
          Column = 0
          Control = Label22
          Row = 6
        end
        item
          Column = 2
          Control = EditNotMeasuredMax
          Row = 6
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 40.000000000000000000
        end>
      TabOrder = 0
      object Label10: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taCenter
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088
        WordWrap = True
        ExplicitWidth = 71
      end
      object Label11: TLabel
        AlignWithMargins = True
        Left = 404
        Top = 3
        Width = 114
        Height = 21
        Align = alTop
        Caption = #1052#1080#1085#1080#1084#1091#1084
        WordWrap = True
        ExplicitWidth = 71
      end
      object Label12: TLabel
        AlignWithMargins = True
        Left = 524
        Top = 3
        Width = 114
        Height = 21
        Align = alTop
        Caption = #1052#1072#1082#1089#1080#1084#1091#1084
        WordWrap = True
        ExplicitWidth = 76
      end
      object Label14: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 43
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1060#1086#1085#1086#1074#1099#1081' '#1090#1086#1082', '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 267
        ExplicitWidth = 131
      end
      object Editfon20Min: TEdit
        AlignWithMargins = True
        Left = 404
        Top = 43
        Width = 114
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
      end
      object Editfon20Max: TEdit
        AlignWithMargins = True
        Left = 524
        Top = 43
        Width = 114
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
      end
      object Label17: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 83
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1059#1093#1086#1076' '#1092#1086#1085#1086#1074#1086#1075#1086' '#1090#1086#1082#1072' '#1087#1088#1080' +20'#8304'C, '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 138
        ExplicitWidth = 260
      end
      object EditDfon20Max: TEdit
        AlignWithMargins = True
        Left = 524
        Top = 83
        Width = 114
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
      end
      object Label18: TLabel
        AlignWithMargins = True
        Left = 404
        Top = 83
        Width = 114
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        WordWrap = True
        ExplicitLeft = 514
        ExplicitWidth = 4
      end
      object Label19: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 123
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1050#1095' '#1087#1088#1080' +20'#8304'C, '#1084#1082#1040'/'#1082#1086#1085#1094'.'
        WordWrap = True
        ExplicitLeft = 219
        ExplicitWidth = 179
      end
      object EditKch20Min: TEdit
        AlignWithMargins = True
        Left = 404
        Top = 123
        Width = 114
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
      end
      object EditKch20Max: TEdit
        AlignWithMargins = True
        Left = 524
        Top = 123
        Width = 114
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
      end
      object Label20: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 163
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1050#1095' '#1087#1088#1080' +50'#8304'C, '#1084#1082#1040'/'#1082#1086#1085#1094'.'
        WordWrap = True
        ExplicitLeft = 219
        ExplicitWidth = 179
      end
      object EditKch50Min: TEdit
        AlignWithMargins = True
        Left = 404
        Top = 163
        Width = 114
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
      end
      object EditKch50Max: TEdit
        AlignWithMargins = True
        Left = 524
        Top = 163
        Width = 114
        Height = 26
        Align = alTop
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = 'EditPgs1'
        OnChange = ComboBoxProductTypeNameChange
      end
      object Label21: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 203
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1059#1093#1086#1076' '#1092#1086#1085#1086#1074#1086#1075#1086' '#1090#1086#1082#1072' '#1087#1088#1080' +50'#8304'C, '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 138
        ExplicitWidth = 260
      end
      object EditDfon50Min: TEdit
        AlignWithMargins = True
        Left = 404
        Top = 203
        Width = 114
        Height = 26
        Align = alTop
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = 'EditPgs1'
        OnChange = ComboBoxProductTypeNameChange
      end
      object EditDfon50Max: TEdit
        AlignWithMargins = True
        Left = 524
        Top = 203
        Width = 114
        Height = 26
        Align = alTop
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Text = 'EditPgs1'
        OnChange = ComboBoxProductTypeNameChange
      end
      object Label22: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 243
        Width = 395
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1059#1093#1086#1076' '#1090#1086#1082#1072' '#1085#1072' '#1085#1077#1080#1079#1084#1077#1088#1103#1077#1084#1086#1084' '#1075#1072#1079#1077', '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 126
        ExplicitWidth = 272
      end
      object EditNotMeasuredMax: TEdit
        AlignWithMargins = True
        Left = 524
        Top = 243
        Width = 114
        Height = 26
        Align = alTop
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Text = 'EditPgs1'
        OnChange = ComboBoxProductTypeNameChange
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 281
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 354
      Height = 281
      Align = alClient
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      TabOrder = 0
      object GridPanel1: TGridPanel
        Left = 2
        Top = 23
        Width = 350
        Height = 256
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 100.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 120.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = Label15
            Row = 0
          end
          item
            Column = 1
            Control = ComboBoxComportProducts
            Row = 0
          end
          item
            Column = 0
            Control = Label1
            Row = 2
          end
          item
            Column = 1
            Control = EditAmbientTemp
            Row = 2
          end
          item
            Column = 0
            Control = Label13
            Row = 3
          end
          item
            Column = 1
            Control = EditDurMinutesBlowGas
            Row = 3
          end
          item
            Column = 1
            Control = EditDurMinutesHoldTemperature
            Row = 4
          end
          item
            Column = 0
            Control = Label16
            Row = 4
          end
          item
            Column = 0
            Control = Label2
            Row = 1
          end
          item
            Column = 1
            Control = ComboBoxComportGas
            Row = 1
          end
          item
            Column = 0
            Control = Label9
            Row = 5
          end
          item
            Column = 1
            Control = ComboBoxChipType
            Row = 5
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end>
        TabOrder = 0
        object Label15: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 224
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = '   '#1057#1054#1052' '#1087#1086#1088#1090' '#1089#1090#1077#1085#1076#1072
          ExplicitLeft = 89
          ExplicitWidth = 138
        end
        object ComboBoxComportProducts: TComboBox
          AlignWithMargins = True
          Left = 233
          Top = 3
          Width = 114
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
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 83
          Width = 224
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = '  '#1058#8304'C '#1086#1082#1088#1091#1078#1072#1102#1097#1077#1081' '#1089#1088#1077#1076#1099
          WordWrap = True
          ExplicitLeft = 46
          ExplicitWidth = 181
        end
        object EditAmbientTemp: TEdit
          AlignWithMargins = True
          Left = 233
          Top = 83
          Width = 114
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
          OnChange = ComboBoxComportProductsChange
        end
        object Label13: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 123
          Width = 224
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1055#1088#1086#1076#1091#1074#1082#1072' '#1075#1072#1079#1072', '#1084#1080#1085'.'
          WordWrap = True
          ExplicitLeft = 85
          ExplicitWidth = 142
        end
        object EditDurMinutesBlowGas: TEdit
          AlignWithMargins = True
          Left = 233
          Top = 123
          Width = 114
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
        end
        object EditDurMinutesHoldTemperature: TEdit
          AlignWithMargins = True
          Left = 233
          Top = 163
          Width = 114
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
        end
        object Label16: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 163
          Width = 224
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1042#1099#1076#1077#1088#1078#1082#1072'  '#1058#8304'C, '#1084#1080#1085'.'
          WordWrap = True
          ExplicitLeft = 82
          ExplicitWidth = 145
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 43
          Width = 224
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = '   '#1057#1054#1052' '#1087#1086#1088#1090' '#1075#1072#1079#1086#1074#1086#1075#1086' '#1073#1083#1086#1082#1072
          ExplicitLeft = 29
          ExplicitWidth = 198
        end
        object ComboBoxComportGas: TComboBox
          AlignWithMargins = True
          Left = 233
          Top = 43
          Width = 114
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
          Text = 'COM1'
          OnChange = ComboBoxComportProductsChange
          Items.Strings = (
            'COM1')
        end
        object Label9: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 203
          Width = 224
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1058#1080#1087' '#1084#1080#1082#1088#1086#1089#1093#1077#1084#1099' '#1087#1072#1084#1103#1090#1080' '#1069#1061#1071
          WordWrap = True
          ExplicitLeft = 19
          ExplicitWidth = 208
        end
        object ComboBoxChipType: TComboBox
          AlignWithMargins = True
          Left = 233
          Top = 203
          Width = 114
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
    end
    object GroupBox2: TGroupBox
      Left = 354
      Top = 0
      Width = 291
      Height = 281
      Align = alRight
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1069#1061#1071
      TabOrder = 1
      object GridPanel2: TGridPanel
        Left = 2
        Top = 23
        Width = 287
        Height = 256
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 100.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 120.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = Label3
            Row = 0
          end
          item
            Column = 1
            Control = ComboBoxProductTypeName
            Row = 0
          end
          item
            Column = 0
            Control = Label4
            Row = 1
          end
          item
            Column = 1
            Control = EditC1
            Row = 1
          end
          item
            Column = 0
            Control = Label5
            Row = 2
          end
          item
            Column = 1
            Control = EditC2
            Row = 2
          end
          item
            Column = 0
            Control = Label7
            Row = 3
          end
          item
            Column = 1
            Control = EditC3
            Row = 3
          end
          item
            Column = 0
            Control = Label8
            Row = 4
          end
          item
            Column = 0
            Control = Label6
            Row = 5
          end
          item
            Column = 1
            Control = ComboBoxPointsMethod
            Row = 5
          end
          item
            Column = 1
            Control = ComboBoxEndScaleGas
            Row = 4
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 40.000000000000000000
          end>
        TabOrder = 0
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 161
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077
          ExplicitLeft = 76
          ExplicitWidth = 88
        end
        object ComboBoxProductTypeName: TComboBox
          AlignWithMargins = True
          Left = 170
          Top = 3
          Width = 114
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
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 43
          Width = 161
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'1'
          ExplicitLeft = 90
          ExplicitWidth = 74
        end
        object EditC1: TEdit
          AlignWithMargins = True
          Left = 170
          Top = 43
          Width = 114
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
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 83
          Width = 161
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'2'
          ExplicitLeft = 90
          ExplicitWidth = 74
        end
        object EditC2: TEdit
          AlignWithMargins = True
          Left = 170
          Top = 83
          Width = 114
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
        end
        object Label7: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 123
          Width = 161
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'3'
          ExplicitLeft = 90
          ExplicitWidth = 74
        end
        object EditC3: TEdit
          AlignWithMargins = True
          Left = 170
          Top = 123
          Width = 114
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
        end
        object Label8: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 163
          Width = 161
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1055#1043#1057' '#1082#1086#1085#1094#1072' '#1096#1082#1072#1083#1099
          ExplicitLeft = 35
          ExplicitWidth = 129
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 203
          Width = 161
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1056#1072#1089#1095#1105#1090' T '#8304'C'
          WordWrap = True
          ExplicitLeft = 84
          ExplicitWidth = 80
        end
        object ComboBoxPointsMethod: TComboBox
          AlignWithMargins = True
          Left = 170
          Top = 203
          Width = 114
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
          Text = '2 '#1090#1086#1095#1082#1080
          OnChange = ComboBoxProductTypeNameChange
          Items.Strings = (
            '2 '#1090#1086#1095#1082#1080
            '3 '#1090#1086#1095#1082#1080)
        end
        object ComboBoxEndScaleGas: TComboBox
          AlignWithMargins = True
          Left = 170
          Top = 163
          Width = 114
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
          Text = #1055#1043#1057'2'
          OnChange = ComboBoxComportProductsChange
          Items.Strings = (
            #1055#1043#1057'2'
            #1055#1043#1057'3')
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 593
    Width = 645
    Height = 105
    Align = alBottom
    Caption = #1058#1077#1082#1089#1090' '#1087#1088#1080#1084#1077#1095#1072#1085#1080#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1069#1061#1071
    TabOrder = 2
    object Memo1: TMemo
      Left = 2
      Top = 23
      Width = 641
      Height = 80
      Align = alClient
      BorderStyle = bsNone
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      OnChange = ComboBoxProductTypeNameChange
    end
  end
  object TimerDebounceParty: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerDebouncePartyTimer
    Left = 362
    Top = 56
  end
end
