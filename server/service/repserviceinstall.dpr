{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       repserviceinstall                               }
{       Installation of Report Manager Service          }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2019 Toni Martir             }
{       toni@reportman.es                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

program repserviceinstall;

uses
  Graphics,
  Forms,
  uinstall in 'uinstall.pas' {FStartService},
  rpmdconsts in '..\..\rpmdconsts.pas';

{$R *.res}

begin
  Graphics.DefFontData.Name:=Screen.IconFont.Name;
  Application.Initialize;
  Application.CreateForm(TFStartService, FStartService);
  FStartService.Font.Assign(Screen.IconFont);
  Application.Run;
end.
