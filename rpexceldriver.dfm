object FRpExcelProgress: TFRpExcelProgress
  Left = 156
  Top = 200
  Width = 731
  Height = 292
  HorzScrollBar.Range = 446
  VertScrollBar.Range = 107
  ActiveControl = BCancel
  BorderStyle = bsDialog
  Caption = 'Print progress'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LProcessing: TLabel
    Left = 8
    Top = 39
    Width = 52
    Height = 13
    Caption = 'Processing'
  end
  object LRecordCount: TLabel
    Left = 75
    Top = 39
    Width = 300
    Height = 21
    AutoSize = False
  end
  object LTitle: TLabel
    Left = 8
    Top = 4
    Width = 23
    Height = 13
    Caption = 'Tittle'
    Visible = False
  end
  object LTittle: TLabel
    Left = 75
    Top = 4
    Width = 367
    Height = 41
    AutoSize = False
  end
  object BCancel: TButton
    Left = 142
    Top = 122
    Width = 96
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
    OnClick = BCancelClick
  end
  object BOK: TButton
    Left = 7
    Top = 122
    Width = 76
    Height = 21
    Caption = 'OK'
    Default = True
    TabOrder = 1
    Visible = False
    OnClick = BOKClick
  end
  object GPrintRange: TGroupBox
    Left = 4
    Top = 4
    Width = 253
    Height = 111
    Caption = 'Print Range'
    TabOrder = 2
    Visible = False
    object LTo: TLabel
      Left = 134
      Top = 84
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object LFrom: TLabel
      Left = 14
      Top = 82
      Width = 23
      Height = 13
      Caption = 'From'
    end
    object EFrom: TEdit
      Left = 55
      Top = 78
      Width = 52
      Height = 21
      TabOrder = 0
    end
    object ETo: TEdit
      Left = 178
      Top = 80
      Width = 71
      Height = 21
      TabOrder = 1
    end
    object RadioAll: TRadioButton
      Left = 12
      Top = 20
      Width = 206
      Height = 24
      Caption = 'All pages'
      TabOrder = 2
    end
    object RadioRange: TRadioButton
      Left = 12
      Top = 47
      Width = 210
      Height = 25
      Caption = 'Range'
      TabOrder = 3
    end
  end
end
