{*******************************************************}
{                                                       }
{       Rpmregdesignvcl                                 }
{                                                       }
{       Units that registers the Report Manager Designer}
{       into the Delphi component palette               }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpmregdesignvcl;

interface

{$I rpconf.inc}

uses Classes,rpmdesignervcl,rprulervcl,rpwebmetaclient;

procedure Register;

implementation

procedure Register;
begin
 RegisterComponents('Reportman', [TRpDesignerVCL]);
{$IFNDEF DELPHI2007UP}
  RegisterComponents('Reportman', [TRpWebMetaPrint]);
{$ENDIF}
 RegisterComponents('Reportman', [TRpRulerVCL]);
end;

end.
