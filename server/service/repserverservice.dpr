{*******************************************************}
{                                                       }
{       Report Manager Service Main project             }
{                                                       }
{       repserverservice                                }
{                                                       }
{       To install service run:                         }
{           repserverservice /INSTALL                   }
{       To uninstall service run:                       }
{           repserverservice /UNINSTALL                 }
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

program repserverservice;

uses
  midaslib,
  rpmdconsts,
  SysUtils,
  rptypes,
  urepservice in 'urepservice.pas' {ReportManServer: TService},
  SvcMgr,
  urepserver in '..\app\urepserver.pas' {modserver: TDataModule};

{$R *.RES}

begin
 Application.Initialize;
 Application.Title := 'Report Manager Service';
 Application.CreateForm(TReportManServer, ReportManServer);
  Application.Run;
end.
