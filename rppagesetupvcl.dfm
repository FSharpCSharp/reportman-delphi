object FRpPageSetupVCL: TFRpPageSetupVCL
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 471
  ClientWidth = 537
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PControl: TPageControl
    Left = 0
    Top = 0
    Width = 537
    Height = 430
    ActivePage = TabPage
    Align = alClient
    TabOrder = 0
    object TabPage: TTabSheet
      Caption = 'Page setup'
      DesignSize = (
        529
        402)
      object SColor: TShape
        Left = 160
        Top = 276
        Width = 33
        Height = 33
        OnMouseDown = SColorMouseDown
      end
      object LLinesperInch: TLabel
        Left = 4
        Top = 252
        Width = 66
        Height = 13
        Caption = 'Lines per inch'
      end
      object GUserDefined: TGroupBox
        Left = 184
        Top = 8
        Width = 340
        Height = 93
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Custom page size (Windows only)'
        TabOrder = 1
        Visible = False
        DesignSize = (
          340
          93)
        object LMetrics7: TLabel
          Left = 297
          Top = 24
          Width = 23
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'inch.'
        end
        object LMetrics8: TLabel
          Left = 297
          Top = 48
          Width = 23
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'inch.'
        end
        object LWidth: TLabel
          Left = 12
          Top = 24
          Width = 28
          Height = 13
          Caption = 'Width'
        end
        object LHeight: TLabel
          Left = 12
          Top = 48
          Width = 31
          Height = 13
          Caption = 'Height'
        end
        object LForceFormName: TLabel
          Left = 12
          Top = 72
          Width = 79
          Height = 13
          Caption = 'Force form name'
        end
        object EPageheight: TRpMaskEdit
          Left = 128
          Top = 44
          Width = 156
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          EditType = tecurrency
        end
        object EPageWidth: TRpMaskEdit
          Left = 128
          Top = 20
          Width = 156
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          EditType = tecurrency
        end
        object EForceFormName: TRpMaskEdit
          Left = 128
          Top = 68
          Width = 156
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
      end
      object RPageSize: TRadioGroup
        Left = 4
        Top = 8
        Width = 177
        Height = 93
        Caption = 'Page size'
        Items.Strings = (
          'Default'
          'Custom'
          'User defined')
        TabOrder = 0
        OnClick = RPageSizeClick
      end
      object GPageSize: TGroupBox
        Left = 184
        Top = 12
        Width = 339
        Height = 65
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Custom size'
        TabOrder = 2
        Visible = False
        object ComboPageSize: TComboBox
          Left = 4
          Top = 32
          Width = 269
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object RPageOrientation: TRadioGroup
        Left = 4
        Top = 104
        Width = 177
        Height = 67
        Caption = 'Page orientation'
        Items.Strings = (
          'Default'
          'Custom')
        TabOrder = 3
        OnClick = RPageOrientationClick
      end
      object RCustomOrientation: TRadioGroup
        Left = 188
        Top = 104
        Width = 336
        Height = 67
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Custom page orientation'
        Items.Strings = (
          'Portrait'
          'Landscape')
        TabOrder = 4
        Visible = False
      end
      object BBackground: TButton
        Left = 4
        Top = 276
        Width = 149
        Height = 33
        Caption = 'Background color'
        TabOrder = 7
        OnClick = BBackgroundClick
      end
      object GPageMargins: TGroupBox
        Left = 4
        Top = 172
        Width = 520
        Height = 69
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Page Margins'
        TabOrder = 5
        DesignSize = (
          520
          69)
        object LLeft: TLabel
          Left = 16
          Top = 16
          Width = 18
          Height = 13
          Caption = 'Left'
        end
        object LTop: TLabel
          Left = 16
          Top = 44
          Width = 19
          Height = 13
          Caption = 'Top'
        end
        object LMetrics3: TLabel
          Left = 168
          Top = 16
          Width = 23
          Height = 13
          Caption = 'inch.'
        end
        object LMetrics4: TLabel
          Left = 168
          Top = 40
          Width = 23
          Height = 13
          Caption = 'inch.'
        end
        object LMetrics5: TLabel
          Left = 471
          Top = 16
          Width = 23
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'inch.'
        end
        object LRight: TLabel
          Left = 244
          Top = 16
          Width = 25
          Height = 13
          Caption = 'Right'
        end
        object LBottom: TLabel
          Left = 244
          Top = 44
          Width = 33
          Height = 13
          Caption = 'Bottom'
        end
        object LMetrics6: TLabel
          Left = 471
          Top = 44
          Width = 23
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'inch.'
        end
        object ELeftMargin: TRpMaskEdit
          Left = 80
          Top = 12
          Width = 77
          Height = 21
          TabOrder = 0
          EditType = tecurrency
        end
        object ETopMargin: TRpMaskEdit
          Left = 80
          Top = 40
          Width = 77
          Height = 21
          TabOrder = 2
          EditType = tecurrency
        end
        object ERightMargin: TRpMaskEdit
          Left = 304
          Top = 12
          Width = 156
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          EditType = tecurrency
        end
        object EBottomMargin: TRpMaskEdit
          Left = 304
          Top = 40
          Width = 156
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          EditType = tecurrency
        end
      end
      object ELinesPerInch: TRpMaskEdit
        Left = 232
        Top = 248
        Width = 124
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 6
        EditType = tecurrency
      end
    end
    object TabPrint: TTabSheet
      Caption = 'Print setup'
      ImageIndex = 1
      DesignSize = (
        529
        402)
      object LSelectPrinter: TLabel
        Left = 8
        Top = 92
        Width = 63
        Height = 13
        Caption = 'Select Printer'
      end
      object LCopies: TLabel
        Left = 8
        Top = 212
        Width = 32
        Height = 13
        Caption = 'Copies'
      end
      object LPrinterFonts: TLabel
        Left = 8
        Top = 8
        Width = 158
        Height = 13
        Caption = 'Printer Fonts (Windows GDI Only)'
      end
      object LRLang: TLabel
        Left = 8
        Top = 36
        Width = 79
        Height = 13
        Caption = 'Report language'
      end
      object LPreview: TLabel
        Left = 8
        Top = 60
        Width = 126
        Height = 13
        Caption = 'Preview window and scale'
      end
      object LPaperSource: TLabel
        Left = 8
        Top = 120
        Width = 95
        Height = 13
        Caption = 'Select paper source'
      end
      object LDuplex: TLabel
        Left = 8
        Top = 148
        Width = 65
        Height = 13
        Caption = 'Duplex option'
      end
      object ComboSelPrinter: TComboBox
        Left = 252
        Top = 88
        Width = 272
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 0
        TabOrder = 3
      end
      object BConfigure: TButton
        Left = 8
        Top = 176
        Width = 213
        Height = 25
        Caption = 'Configure printers'
        TabOrder = 5
        OnClick = BConfigureClick
      end
      object CheckPrintOnlyIfData: TCheckBox
        Left = 8
        Top = 284
        Width = 209
        Height = 21
        Caption = 'Print only if data available'
        TabOrder = 9
      end
      object CheckTwoPass: TCheckBox
        Left = 8
        Top = 260
        Width = 209
        Height = 21
        Caption = 'Two pass report'
        TabOrder = 8
      end
      object ECopies: TRpMaskEdit
        Left = 152
        Top = 208
        Width = 69
        Height = 21
        TabOrder = 6
        EditType = teinteger
      end
      object CheckCollate: TCheckBox
        Left = 8
        Top = 236
        Width = 213
        Height = 21
        Caption = 'Collate copies'
        TabOrder = 7
      end
      object ComboPrinterFonts: TComboBox
        Left = 252
        Top = 4
        Width = 272
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'Default'
          'Always use printer fonts'
          'Never use printer fonts'
          'Recalculte report')
      end
      object ComboLanguage: TComboBox
        Left = 252
        Top = 32
        Width = 272
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 0
        TabOrder = 1
      end
      object ComboPreview: TComboBox
        Left = 252
        Top = 60
        Width = 118
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'Normal'
          'Maxmized')
      end
      object ComboStyle: TComboBox
        Left = 376
        Top = 60
        Width = 148
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'Wide'
          'Normal'
          'Page')
      end
      object CheckDrawerAfter: TCheckBox
        Left = 8
        Top = 332
        Width = 373
        Height = 21
        Caption = 'Open drawer after printing'
        TabOrder = 11
      end
      object CheckDrawerBefore: TCheckBox
        Left = 8
        Top = 308
        Width = 405
        Height = 21
        Caption = 'Open drawer before printing'
        TabOrder = 10
      end
      object CheckPreviewAbout: TCheckBox
        Left = 228
        Top = 232
        Width = 296
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Caption = 'About box in preview'
        TabOrder = 12
      end
      object CheckMargins: TCheckBox
        Left = 228
        Top = 256
        Width = 297
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Printable margins in preview'
        TabOrder = 13
      end
      object ComboPaperSource: TComboBox
        Left = 300
        Top = 116
        Width = 224
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 0
        TabOrder = 14
        OnClick = ComboPaperSourceClick
      end
      object ComboDuplex: TComboBox
        Left = 252
        Top = 144
        Width = 272
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 0
        TabOrder = 15
      end
      object EPaperSource: TRpMaskEdit
        Left = 252
        Top = 116
        Width = 45
        Height = 21
        TabOrder = 16
        OnChange = EPaperSourceChange
        EditType = teinteger
      end
      object CheckDefaultCopies: TCheckBox
        Left = 228
        Top = 208
        Width = 237
        Height = 21
        Caption = 'Default printer copies'
        TabOrder = 17
        OnClick = CheckDefaultCopiesClick
      end
    end
    object TabOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 2
      DesignSize = (
        529
        402)
      object LPreferedFormat: TLabel
        Left = 8
        Top = 12
        Width = 98
        Height = 13
        Caption = 'Prefered save format'
      end
      object ComboFormat: TComboBox
        Left = 184
        Top = 8
        Width = 336
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 0
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 430
    Width = 537
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BOK: TButton
      Left = 8
      Top = 8
      Width = 101
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = BOKClick
    end
    object BCancel: TButton
      Left = 116
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = BCancelClick
    end
  end
  object ColorDialog1: TColorDialog
    Left = 336
    Top = 288
  end
end
