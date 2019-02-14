{*******************************************************}
{                                                       }
{       Rpmregdesignvcl                                 }
{                                                       }
{       Units that registers the Report Manager Designer}
{       into the Delphi component palette               }
{                                                       }
{       Copyright (c) 1994-2019 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpmregdesignvcl;

interface

{$I rpconf.inc}

uses Classes,rpmdesignervcl,rprulervcl,rpwebmetaclient,rppanel,
  DesignIntf, DesignEditors,rpmdfmainvcl;

type
   TRpDesignerVCLEditor=class(TComponentEditor)
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
   end;
procedure Register;

implementation

function TRpDesignerVCLEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TRpDesignerVCLEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Launch Report Designer';
  end;
end;

procedure TRpDesignerVCLEditor.ExecuteVerb(Index: Integer);
var
 form:TFRpMainFVCL;
begin
  inherited;
  case Index of
    0:
     begin
      form := TFRpMainFVCL.Create(nil);
      form.Show;
     end;
  end;
end;

procedure Register;
begin
 RegisterComponents('Reportman', [TRpDesignerVCL]);
 RegisterComponents('Reportman', [TRpPanel]);
{$IFNDEF DELPHI2007UP}
  RegisterComponents('Reportman', [TRpWebMetaPrint]);
{$ENDIF}
 RegisterComponents('Reportman', [TRpRulerVCL]);
 RegisterComponentEditor(TRpDesignerVCL, TRpDesignerVCLEditor)
end;




end.
