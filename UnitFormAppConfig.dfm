object FormAppConfig: TFormAppConfig
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 564
  ClientWidth = 689
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
    Width = 689
    Height = 283
    Align = alClient
    Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1082#1072#1095#1077#1089#1090#1074#1072' '#1069#1061#1071
    TabOrder = 0
    ExplicitLeft = 57
    ExplicitTop = 317
    ExplicitWidth = 651
    ExplicitHeight = 289
    object GridPanel3: TGridPanel
      Left = 2
      Top = 23
      Width = 685
      Height = 258
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
          Control = Edit7
          Row = 1
        end
        item
          Column = 2
          Control = Edit10
          Row = 1
        end
        item
          Column = 0
          Control = Label17
          Row = 2
        end
        item
          Column = 2
          Control = Edit11
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
          Control = Edit12
          Row = 3
        end
        item
          Column = 2
          Control = Edit13
          Row = 3
        end
        item
          Column = 0
          Control = Label20
          Row = 4
        end
        item
          Column = 1
          Control = Edit14
          Row = 4
        end
        item
          Column = 2
          Control = Edit15
          Row = 4
        end
        item
          Column = 0
          Control = Label21
          Row = 5
        end
        item
          Column = 1
          Control = Edit16
          Row = 5
        end
        item
          Column = 2
          Control = Edit17
          Row = 5
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 50.000000000000000000
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
      ExplicitWidth = 647
      ExplicitHeight = 290
      object Label10: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 439
        Height = 21
        Align = alTop
        Alignment = taCenter
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088
        WordWrap = True
        ExplicitWidth = 71
      end
      object Label11: TLabel
        AlignWithMargins = True
        Left = 448
        Top = 3
        Width = 114
        Height = 42
        Align = alTop
        Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
        WordWrap = True
        ExplicitLeft = 300
        ExplicitWidth = 106
      end
      object Label12: TLabel
        AlignWithMargins = True
        Left = 568
        Top = 3
        Width = 114
        Height = 42
        Align = alTop
        Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
        WordWrap = True
        ExplicitLeft = 420
        ExplicitWidth = 111
      end
      object Label14: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 53
        Width = 439
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1060#1086#1085#1086#1074#1099#1081' '#1090#1086#1082', '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 163
        ExplicitWidth = 131
      end
      object Edit7: TEdit
        AlignWithMargins = True
        Left = 448
        Top = 53
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
        ExplicitLeft = 300
      end
      object Edit10: TEdit
        AlignWithMargins = True
        Left = 568
        Top = 53
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
        ExplicitLeft = 420
      end
      object Label17: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 93
        Width = 439
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1059#1093#1086#1076' '#1092#1086#1085#1086#1074#1086#1075#1086' '#1090#1086#1082#1072' '#1087#1088#1080' +20'#8304'C, '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 34
        ExplicitWidth = 260
      end
      object Edit11: TEdit
        AlignWithMargins = True
        Left = 568
        Top = 93
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
        ExplicitLeft = 420
      end
      object Label18: TLabel
        AlignWithMargins = True
        Left = 448
        Top = 93
        Width = 114
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        WordWrap = True
        ExplicitLeft = 410
        ExplicitWidth = 4
      end
      object Label19: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 133
        Width = 439
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1050#1095' '#1087#1088#1080' +20'#8304'C, '#1084#1082#1040'/'#1082#1086#1085#1094'.'
        WordWrap = True
        ExplicitLeft = 115
        ExplicitWidth = 179
      end
      object Edit12: TEdit
        AlignWithMargins = True
        Left = 448
        Top = 133
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
        ExplicitLeft = 300
      end
      object Edit13: TEdit
        AlignWithMargins = True
        Left = 568
        Top = 133
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
        ExplicitLeft = 420
      end
      object Label20: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 173
        Width = 439
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1050#1095' '#1087#1088#1080' +50'#8304'C, '#1084#1082#1040'/'#1082#1086#1085#1094'.'
        WordWrap = True
        ExplicitLeft = 115
        ExplicitWidth = 179
      end
      object Edit14: TEdit
        AlignWithMargins = True
        Left = 448
        Top = 173
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
        ExplicitLeft = 300
      end
      object Edit15: TEdit
        AlignWithMargins = True
        Left = 568
        Top = 173
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
        ExplicitLeft = 420
      end
      object Label21: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 213
        Width = 439
        Height = 21
        Align = alTop
        Alignment = taRightJustify
        Caption = #1059#1093#1086#1076' '#1092#1086#1085#1086#1074#1086#1075#1086' '#1090#1086#1082#1072' '#1087#1088#1080' +50'#8304'C, '#1084#1082#1040
        WordWrap = True
        ExplicitLeft = 34
        ExplicitWidth = 260
      end
      object Edit16: TEdit
        AlignWithMargins = True
        Left = 448
        Top = 213
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
        ExplicitLeft = 300
      end
      object Edit17: TEdit
        AlignWithMargins = True
        Left = 568
        Top = 213
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
        ExplicitLeft = 420
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 281
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 1026
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 408
      Height = 281
      Align = alClient
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = -30
      ExplicitWidth = 376
      ExplicitHeight = 271
      object GridPanel1: TGridPanel
        Left = 2
        Top = 23
        Width = 404
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
            Control = Edit1
            Row = 2
          end
          item
            Column = 0
            Control = Label13
            Row = 3
          end
          item
            Column = 1
            Control = Edit8
            Row = 3
          end
          item
            Column = 1
            Control = Edit9
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
            Control = ComboBox3
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
        ExplicitLeft = 3
        ExplicitTop = 9
        ExplicitWidth = 633
        ExplicitHeight = 440
        object Label15: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 278
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = '   '#1057#1054#1052' '#1087#1086#1088#1090' '#1089#1090#1077#1085#1076#1072
          ExplicitLeft = 111
          ExplicitWidth = 138
        end
        object ComboBoxComportProducts: TComboBox
          AlignWithMargins = True
          Left = 287
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
          ExplicitLeft = 168
          ExplicitTop = 0
          ExplicitWidth = 145
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 83
          Width = 278
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = '  '#1058#8304'C '#1086#1082#1088#1091#1078#1072#1102#1097#1077#1081' '#1089#1088#1077#1076#1099
          WordWrap = True
          ExplicitLeft = 68
          ExplicitWidth = 181
        end
        object Edit1: TEdit
          AlignWithMargins = True
          Left = 287
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
          OnChange = ComboBoxProductTypeNameChange
          ExplicitLeft = 255
        end
        object Label13: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 123
          Width = 278
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1055#1088#1086#1076#1091#1074#1082#1072' '#1075#1072#1079#1072', '#1084#1080#1085'.'
          WordWrap = True
          ExplicitLeft = 107
          ExplicitWidth = 142
        end
        object Edit8: TEdit
          AlignWithMargins = True
          Left = 287
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
          OnChange = ComboBoxProductTypeNameChange
          ExplicitLeft = 255
        end
        object Edit9: TEdit
          AlignWithMargins = True
          Left = 287
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
          OnChange = ComboBoxProductTypeNameChange
          ExplicitLeft = 255
        end
        object Label16: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 163
          Width = 278
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1042#1099#1076#1077#1088#1078#1082#1072'  '#1058#8304'C, '#1084#1080#1085'.'
          WordWrap = True
          ExplicitLeft = 104
          ExplicitWidth = 145
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 43
          Width = 278
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = '   '#1057#1054#1052' '#1087#1086#1088#1090' '#1075#1072#1079#1086#1074#1086#1075#1086' '#1073#1083#1086#1082#1072
          ExplicitLeft = 51
          ExplicitWidth = 198
        end
        object ComboBoxComportGas: TComboBox
          AlignWithMargins = True
          Left = 287
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
          Items.Strings = (
            'COM1')
          ExplicitLeft = 372
          ExplicitTop = 42
          ExplicitHeight = 29
        end
        object Label9: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 203
          Width = 278
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1058#1080#1087' '#1084#1080#1082#1088#1086#1089#1093#1077#1084#1099' '#1087#1072#1084#1103#1090#1080' '#1069#1061#1071
          WordWrap = True
          ExplicitLeft = 41
          ExplicitWidth = 208
        end
        object ComboBox3: TComboBox
          AlignWithMargins = True
          Left = 287
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
          TabOrder = 5
          Text = '16'
          Items.Strings = (
            '16'
            '64'
            '256')
          ExplicitLeft = 372
          ExplicitTop = 42
          ExplicitHeight = 29
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 408
      Top = 0
      Width = 281
      Height = 281
      Align = alRight
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1069#1061#1071
      TabOrder = 1
      ExplicitLeft = 350
      object GridPanel2: TGridPanel
        Left = 2
        Top = 23
        Width = 277
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
            Control = ComboBox1
            Row = 0
          end
          item
            Column = 0
            Control = Label4
            Row = 1
          end
          item
            Column = 1
            Control = Edit3
            Row = 1
          end
          item
            Column = 0
            Control = Label5
            Row = 2
          end
          item
            Column = 1
            Control = Edit4
            Row = 2
          end
          item
            Column = 0
            Control = Label7
            Row = 3
          end
          item
            Column = 1
            Control = Edit5
            Row = 3
          end
          item
            Column = 0
            Control = Label8
            Row = 4
          end
          item
            Column = 1
            Control = Edit6
            Row = 4
          end
          item
            Column = 0
            Control = Label6
            Row = 5
          end
          item
            Column = 1
            Control = ComboBox2
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
        ExplicitWidth = 319
        ExplicitHeight = 246
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 151
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077
          ExplicitLeft = 66
          ExplicitWidth = 88
        end
        object ComboBox1: TComboBox
          AlignWithMargins = True
          Left = 160
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
          ExplicitLeft = 287
          ExplicitTop = 11
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 43
          Width = 151
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'1'
          ExplicitLeft = 80
          ExplicitWidth = 74
        end
        object Edit3: TEdit
          AlignWithMargins = True
          Left = 160
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
          Width = 151
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'2'
          ExplicitLeft = 80
          ExplicitWidth = 74
        end
        object Edit4: TEdit
          AlignWithMargins = True
          Left = 160
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
          Width = 151
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'3'
          ExplicitLeft = 80
          ExplicitWidth = 74
        end
        object Edit5: TEdit
          AlignWithMargins = True
          Left = 160
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
          Width = 151
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1043#1057#1054'-'#1055#1043#1057'4'
          ExplicitLeft = 80
          ExplicitWidth = 74
        end
        object Edit6: TEdit
          AlignWithMargins = True
          Left = 160
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
          TabOrder = 4
          Text = 'EditPgs1'
          OnChange = ComboBoxProductTypeNameChange
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 203
          Width = 151
          Height = 21
          Align = alTop
          Alignment = taRightJustify
          Caption = #1056#1072#1089#1095#1105#1090' T '#8304'C'
          WordWrap = True
          ExplicitLeft = 74
          ExplicitWidth = 80
        end
        object ComboBox2: TComboBox
          AlignWithMargins = True
          Left = 160
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
          TabOrder = 5
          Text = '2 '#1090#1086#1095#1082#1080
          OnChange = ComboBoxComportProductsChange
          Items.Strings = (
            '2 '#1090#1086#1095#1082#1080
            '3 '#1090#1086#1095#1082#1080)
          ExplicitLeft = 284
          ExplicitTop = 198
        end
      end
    end
  end
end
