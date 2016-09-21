{*******************************************************}
{                                                       }
{       Report Manager Server configuration             }
{                                                       }
{       repserverconfigxp                               }
{                                                       }
{       Main project to build repserverconfig           }
{                                                       }
{       Copyright (c) 1994-2012 Toni Martir             }
{       toni@reportman.es
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program repserverconfigxp;

{$I rpconf.inc}

uses
  Graphics,
  Forms,
  mainfvcl in 'mainfvcl.pas' {FMainVCL},
  unewuservcl in 'unewuservcl.pas' {FNewUserVCL},
  unewaliasvcl in 'unewaliasvcl.pas' {FNewAliasVCL},
{$IFDEF USEVARIANTS}
{$IFNDEF MIDASOUT}
  midaslib,
{$ENDIF}
{$ENDIF}
  rpmdrepclient in '..\..\rpmdrepclient.pas' {modclient: TDataModule},
  rpmdprotocol in '..\..\rpmdprotocol.pas',
  ureptreevcl in 'ureptreevcl.pas' {FReportTreeVCL};

{$R *.res}

begin
  Graphics.DefFontData.Name:=Screen.IconFont.Name;
  IsMultiThread:=True;
  Application.Initialize;
  Application.CreateForm(TFMainVCL, FMainVCL);
  FMainVCL.Font.Assign(Screen.IconFont);
  Application.Run;
end.
