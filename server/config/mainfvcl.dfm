object FMainVCL: TFMainVCL
  Left = 134
  Top = 83
  Width = 666
  Height = 510
  HorzScrollBar.Range = 389
  VertScrollBar.Range = 161
  ActiveControl = ComboHost
  Caption = 'Report Manager Server configuration'
  Color = clBtnFace
  ParentFont = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  DesignSize = (
    648
    463)
  TextHeight = 20
  object LHost: TLabel
    Left = 12
    Top = 12
    Width = 31
    Height = 20
    Caption = 'Host'
  end
  object LPort: TLabel
    Left = 513
    Top = 8
    Width = 26
    Height = 20
    Anchors = [akTop, akRight]
    Caption = 'Port'
    ExplicitLeft = 489
  end
  object GUser: TGroupBox
    Left = 8
    Top = 44
    Width = 639
    Height = 117
    Anchors = [akLeft, akTop, akRight]
    Caption = 'User information'
    TabOrder = 1
    ExplicitWidth = 615
    DesignSize = (
      639
      117)
    object LUserName: TLabel
      Left = 8
      Top = 24
      Width = 70
      Height = 20
      Caption = 'User name'
    end
    object LPassword: TLabel
      Left = 8
      Top = 52
      Width = 61
      Height = 20
      Caption = 'Password'
    end
    object EUserName: TEdit
      Left = 112
      Top = 20
      Width = 519
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'Admin'
      ExplicitWidth = 495
    end
    object EPassword: TEdit
      Left = 112
      Top = 48
      Width = 519
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      PasswordChar = '*'
      TabOrder = 2
      ExplicitWidth = 495
    end
    object BConnect: TButton
      Left = 8
      Top = 84
      Width = 113
      Height = 25
      Caption = 'Connect'
      TabOrder = 1
      OnClick = BConnectClick
    end
  end
  object GServerinfo: TGroupBox
    Left = 4
    Top = 44
    Width = 640
    Height = 325
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Server information'
    TabOrder = 2
    Visible = False
    ExplicitWidth = 616
    DesignSize = (
      640
      325)
    object BCloseConnection: TButton
      Left = 8
      Top = 285
      Width = 173
      Height = 33
      Caption = 'Close connection'
      TabOrder = 0
      OnClick = BCloseConnectionClick
    end
    object PControl: TPageControl
      Left = 8
      Top = 12
      Width = 629
      Height = 269
      ActivePage = TabUsers
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 605
      object TabUsers: TTabSheet
        Caption = 'Users'
        DesignSize = (
          621
          234)
        object GUsers: TGroupBox
          Left = 0
          Top = 0
          Width = 617
          Height = 105
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Users'
          TabOrder = 0
          ExplicitWidth = 593
          DesignSize = (
            617
            105)
          object LUsers: TListBox
            Left = 4
            Top = 12
            Width = 449
            Height = 85
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 20
            TabOrder = 0
            OnClick = LUsersClick
            ExplicitWidth = 425
          end
          object BDeleteUser: TButton
            Left = 456
            Top = 72
            Width = 153
            Height = 25
            Anchors = [akTop, akRight]
            Caption = 'Delete'
            TabOrder = 3
            OnClick = BDeleteUserClick
            ExplicitLeft = 432
          end
          object BAddUser: TButton
            Left = 456
            Top = 13
            Width = 153
            Height = 24
            Anchors = [akTop, akRight]
            Caption = 'Add'
            TabOrder = 1
            OnClick = BAddUserClick
            ExplicitLeft = 432
          end
          object BChangePassword: TButton
            Left = 456
            Top = 41
            Width = 153
            Height = 28
            Anchors = [akTop, akRight]
            Caption = 'Change Password'
            TabOrder = 2
            OnClick = BChangePasswordClick
            ExplicitLeft = 432
          end
        end
        object GGroups: TGroupBox
          Left = 0
          Top = 108
          Width = 233
          Height = 105
          Caption = 'Groups'
          TabOrder = 1
          object LGroups: TListBox
            Left = 104
            Top = 16
            Width = 121
            Height = 81
            ItemHeight = 20
            TabOrder = 0
          end
          object BAddGroup: TButton
            Left = 4
            Top = 16
            Width = 97
            Height = 25
            Caption = 'Add'
            TabOrder = 1
            OnClick = BAddGroupClick
          end
          object BDeleteGroup: TButton
            Left = 4
            Top = 48
            Width = 97
            Height = 25
            Caption = 'Delete'
            TabOrder = 2
            OnClick = BDeleteGroupClick
          end
        end
        object GUserGroups: TGroupBox
          Left = 236
          Top = 108
          Width = 381
          Height = 105
          Anchors = [akLeft, akTop, akRight]
          Caption = 'The user is member of this groups'
          TabOrder = 2
          ExplicitWidth = 357
          DesignSize = (
            381
            105)
          object LUserGroups: TListBox
            Left = 40
            Top = 20
            Width = 337
            Height = 77
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 20
            TabOrder = 0
            ExplicitWidth = 313
          end
          object BAddUserGroup: TBitBtn
            Left = 4
            Top = 24
            Width = 33
            Height = 33
            Glyph.Data = {
              AA040000424DAA04000000000000360000002800000013000000130000000100
              18000000000074040000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000}
            TabOrder = 1
            OnClick = BAddUserGroupClick
          end
          object BDeleteUserGroup: TBitBtn
            Left = 4
            Top = 60
            Width = 33
            Height = 33
            Glyph.Data = {
              AA040000424DAA04000000000000360000002800000013000000130000000100
              18000000000074040000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000000000000000000000FF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000}
            TabOrder = 2
            OnClick = BDeleteUserGroupClick
          end
        end
      end
      object TabAliases: TTabSheet
        Caption = 'Aliases'
        ImageIndex = 2
        DesignSize = (
          621
          234)
        object GReportDirectories: TGroupBox
          Left = 0
          Top = 0
          Width = 621
          Height = 133
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Report server directories'
          TabOrder = 0
          ExplicitWidth = 597
          DesignSize = (
            621
            133)
          object DBGrid1: TDBGrid
            Left = 4
            Top = 16
            Width = 613
            Height = 81
            Anchors = [akLeft, akTop, akRight]
            DataSource = SDirectories
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
          end
          object BAddAlias: TButton
            Left = 4
            Top = 99
            Width = 133
            Height = 30
            Caption = 'Add'
            TabOrder = 1
            OnClick = BAddAliasClick
          end
          object BDeleteAlias: TButton
            Left = 140
            Top = 99
            Width = 133
            Height = 30
            Caption = 'Delete'
            TabOrder = 2
            OnClick = BDeleteAliasClick
          end
          object BPreviewTree: TButton
            Left = 280
            Top = 99
            Width = 337
            Height = 30
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Preview Report Tree'
            TabOrder = 3
            OnClick = BPreviewTreeClick
          end
        end
        object GGroups2: TGroupBox
          Left = 0
          Top = 136
          Width = 197
          Height = 105
          Caption = 'Groups'
          TabOrder = 1
          object LGroups2: TListBox
            Left = 4
            Top = 16
            Width = 185
            Height = 81
            ItemHeight = 20
            TabOrder = 0
          end
        end
        object GAliasGroups: TGroupBox
          Left = 200
          Top = 136
          Width = 421
          Height = 105
          Anchors = [akLeft, akTop, akRight]
          Caption = 'This alias is accessible by this user groups'
          TabOrder = 2
          ExplicitWidth = 397
          DesignSize = (
            421
            105)
          object LAliasGroups: TListBox
            Left = 40
            Top = 20
            Width = 377
            Height = 77
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 20
            TabOrder = 0
            ExplicitWidth = 353
          end
          object BDeleteAliasGroup: TBitBtn
            Left = 4
            Top = 64
            Width = 33
            Height = 33
            Glyph.Data = {
              AA040000424DAA04000000000000360000002800000013000000130000000100
              18000000000074040000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000000000000000000000FF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000}
            TabOrder = 2
            OnClick = BDeleteAliasGroupClick
          end
          object BAddAliasGroup: TBitBtn
            Left = 4
            Top = 24
            Width = 33
            Height = 33
            Glyph.Data = {
              AA040000424DAA04000000000000360000002800000013000000130000000100
              18000000000074040000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF000000}
            TabOrder = 1
            OnClick = BAddAliasGroupClick
          end
        end
      end
      object TabConnections: TTabSheet
        Caption = 'Connections'
        ImageIndex = 2
        object PBotTasks: TPanel
          Left = 0
          Top = 205
          Width = 621
          Height = 29
          Align = alBottom
          TabOrder = 0
          object BRefresh: TButton
            Left = 8
            Top = 4
            Width = 125
            Height = 21
            Caption = 'Refresh'
            TabOrder = 0
            OnClick = BRefreshClick
          end
          object BStop: TButton
            Left = 144
            Top = 4
            Width = 113
            Height = 21
            Caption = 'Close connection'
            TabOrder = 1
            OnClick = BStopClick
          end
        end
        object GTasks: TDBGrid
          Left = 0
          Top = 0
          Width = 621
          Height = 205
          Align = alClient
          DataSource = SData
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Visible = False
        end
      end
    end
  end
  object ComboHost: TComboBox
    Left = 92
    Top = 8
    Width = 415
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Items.Strings = (
      'localhost')
    ExplicitWidth = 391
  end
  object LMessages: TListBox
    Left = 4
    Top = 372
    Width = 640
    Height = 97
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clInfoBk
    ItemHeight = 20
    TabOrder = 3
    ExplicitWidth = 616
    ExplicitHeight = 81
  end
  object ComboPort: TComboBox
    Left = 565
    Top = 8
    Width = 77
    Height = 28
    Anchors = [akTop, akRight]
    TabOrder = 4
    Text = '3060'
    Items.Strings = (
      '3060')
    ExplicitLeft = 541
  end
  object Trans: TRpTranslator
    Active = False
    Filename = 'reportmanres'
    Left = 352
    Top = 8
  end
  object DDirectories: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = DDirectoriesAfterScroll
    AfterScroll = DDirectoriesAfterScroll
    Left = 348
    Top = 276
    object DDirectoriesAlias: TStringField
      DisplayLabel = 'Server alias'
      DisplayWidth = 15
      FieldName = 'Alias'
      Size = 30
    end
    object DDirectoriesServerPath: TStringField
      DisplayLabel = 'Server Path'
      DisplayWidth = 50
      FieldName = 'ServerPath'
      Size = 250
    end
  end
  object SDirectories: TDataSource
    DataSet = DDirectories
    Left = 312
    Top = 272
  end
  object adata: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 116
    Top = 120
    object adataID: TIntegerField
      DisplayLabel = 'Id.'
      FieldName = 'ID'
    end
    object adataLASTOPERATION: TDateTimeField
      DisplayLabel = 'Last Operation'
      FieldName = 'LASTOPERATION'
    end
    object adataCONNECTIONDATE: TDateTimeField
      DisplayLabel = 'Conn.Date'
      FieldName = 'CONNECTIONDATE'
    end
    object adataUSERNAME: TStringField
      DisplayLabel = 'User Name'
      FieldName = 'USERNAME'
      Size = 40
    end
    object adataRUNNING: TBooleanField
      DisplayLabel = 'Running'
      FieldName = 'RUNNING'
    end
  end
  object SData: TDataSource
    DataSet = adata
    Left = 172
    Top = 124
  end
end
