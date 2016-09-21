object FRpWizardVCL: TFRpWizardVCL
  Left = 193
  Top = 114
  Caption = 'New Report Wizard'
  ClientHeight = 487
  ClientWidth = 602
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PControl: TPageControl
    Left = 0
    Top = 0
    Width = 602
    Height = 451
    ActivePage = TabInstructions
    Align = alClient
    TabOrder = 0
    OnChange = PControlChange
    OnChanging = PControlChanging
    object TabInstructions: TTabSheet
      Caption = 'Instructions'
      ExplicitTop = 22
      ExplicitHeight = 425
      object LDesign: TLabel
        Left = 4
        Top = 12
        Width = 292
        Height = 13
        Caption = 'To design a report with this wizard you must follow this steps'
      end
      object LPass1: TLabel
        Left = 4
        Top = 35
        Width = 353
        Height = 13
        Caption = 
          '1. Open database connections, follow the instuctions in Connecti' +
          'os page.'
      end
      object LPass2: TLabel
        Left = 4
        Top = 55
        Width = 277
        Height = 13
        Caption = '2. Open datasets, follow the instuctions at datasets page'
      end
      object LPass3: TLabel
        Left = 4
        Top = 75
        Width = 340
        Height = 13
        Caption = 
          '3. Select dataset fields to print, follow instructions at select' +
          ' fields page'
      end
      object LBegin: TLabel
        Left = 4
        Top = 118
        Width = 177
        Height = 13
        Caption = 'To begin the wizard click Next button'
      end
      object BPageSetup: TButton
        Left = 8
        Top = 138
        Width = 91
        Height = 32
        Caption = 'Configure page'
        TabOrder = 0
        OnClick = BPageSetupClick
      end
    end
    object TabConnections: TTabSheet
      Caption = 'Connections'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabDatasets: TTabSheet
      Caption = 'Datasets'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object TabFields: TTabSheet
      Caption = 'Fields'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object PBottom3: TPanel
    Left = 0
    Top = 451
    Width = 602
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      602
      36)
    object BCancel: TButton
      Left = 4
      Top = 4
      Width = 95
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = BCancelClick
    end
    object BNext: TButton
      Left = 398
      Top = 4
      Width = 96
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Next'
      TabOrder = 1
      OnClick = BNext1Click
    end
    object BFinish: TButton
      Left = 500
      Top = 4
      Width = 96
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Finish'
      TabOrder = 2
      OnClick = BFinishClick
    end
    object BBack: TButton
      Left = 295
      Top = 4
      Width = 96
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Back'
      TabOrder = 3
      OnClick = BBackClick
    end
  end
end
