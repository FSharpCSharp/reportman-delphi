object FRpRTParams: TFRpRTParams
  Left = 18
  Top = 31
  Width = 589
  Height = 300
  VertScrollBar.Range = 41
  AutoScroll = False
  Caption = 'Report parameters'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PModalButtons: TPanel
    Left = 0
    Top = 220
    Width = 573
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BOK: TButton
      Left = 63
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = BOKClick
    end
    object BCancel: TButton
      Left = 203
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object MainScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 573
    Height = 220
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 1
    object PParent: TPanel
      Left = 0
      Top = 0
      Width = 573
      Height = 205
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter1: TSplitter
        Left = 260
        Top = 0
        Width = 8
        Height = 205
        Beveled = True
      end
      object PLeft: TPanel
        Left = 0
        Top = 0
        Width = 260
        Height = 205
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
      object PRight: TPanel
        Left = 268
        Top = 0
        Width = 305
        Height = 205
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
end
