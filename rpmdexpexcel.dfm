object FRpExpExcel: TFRpExpExcel
  Left = 201
  Top = 109
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  Caption = 'Progreso'
  ClientHeight = 190
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object LRegCopy: TLabel
    Left = 10
    Top = 94
    Width = 107
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Copiando registro'
  end
  object LCount: TLabel
    Left = 158
    Top = 94
    Width = 9
    Height = 16
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Animate1: TAnimate
    Left = 10
    Top = 10
    Width = 335
    Height = 74
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    CommonAVI = aviCopyFiles
    StopFrame = 34
  end
  object BCancelar: TButton
    Left = 158
    Top = 128
    Width = 163
    Height = 46
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Cancel'
    Default = True
    TabOrder = 1
    OnClick = BCancelarClick
  end
end
