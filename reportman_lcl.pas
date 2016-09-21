{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit reportman_lcl;

interface

uses
  rppreviewcontrol, rppreviewmetalcl, rpmaskedit, rpreglcl, rplclpreview, 
  rppagesetuplcl, rplclreport, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('rpreglcl', @rpreglcl.Register);
end;

initialization
  RegisterPackage('reportman_lcl', @Register);
end.
