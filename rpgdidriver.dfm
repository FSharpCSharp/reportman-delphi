object FRpVCLProgress: TFRpVCLProgress
  Left = 667
  Top = 233
  Width = 703
  Height = 311
  HorzScrollBar.Range = 446
  VertScrollBar.Range = 107
  ActiveControl = BCancel
  Caption = 'Print progress'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    687
    272)
  PixelsPerInch = 96
  TextHeight = 13
  object LProcessing: TLabel
    Left = 8
    Top = 39
    Width = 458
    Height = 43
    AutoSize = False
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
    Width = 465
    Height = 31
    AutoSize = False
    Caption = 'Tittle'
    Visible = False
  end
  object LTittle: TLabel
    Left = 75
    Top = 4
    Width = 351
    Height = 31
    AutoSize = False
  end
  object BCancel: TButton
    Left = 118
    Top = 108
    Width = 175
    Height = 24
    Anchors = [akLeft, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
    OnClick = BCancelClick
  end
  object BOK: TButton
    Left = 8
    Top = 16
    Width = 80
    Height = 26
    Anchors = [akLeft, akBottom]
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
      Width = 12
      Height = 13
      Caption = 'To'
    end
    object LFrom: TLabel
      Left = 14
      Top = 82
      Width = 24
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
  object GBitmap: TGroupBox
    Left = 4
    Top = 8
    Width = 312
    Height = 103
    TabOrder = 3
    Visible = False
    object LHorzRes: TLabel
      Left = 12
      Top = 20
      Width = 184
      Height = 13
      Caption = 'Horizotal resolution in dots per inchess'
    end
    object LVertRes: TLabel
      Left = 12
      Top = 51
      Width = 184
      Height = 13
      Caption = 'Horizotal resolution in dots per inchess'
    end
    object EHorzRes: TEdit
      Left = 209
      Top = 16
      Width = 76
      Height = 21
      TabOrder = 0
      Text = '100'
    end
    object EVertRes: TEdit
      Left = 209
      Top = 47
      Width = 76
      Height = 21
      TabOrder = 1
      Text = '100'
    end
    object CheckMono: TCheckBox
      Left = 12
      Top = 78
      Width = 273
      Height = 17
      Caption = 'Monocrhome'
      TabOrder = 2
    end
  end
end
