{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpvclreport                                     }
{       Report component for vcl applications           }
{       Delphi 5 for example                            }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rplclreport;

{$I rpconf.inc}

interface

uses Classes,Sysutils,rpreport,rpmdconsts,rpcompobase,
 rpalias,dialogs,rppreviewcontrol,
 rptextdriver,rppdfdriver,
 {$IFDEF FPC}
 rplclgraphutils,rplcldriver,PrintersDlgs,rprflclparams,rplclpreview,
 {$ELSE}
 rpvgraphutils,rppreviewcontrol,rprfvparams,rpvpreview,
 rpexceldriver,rpgdidriver,
 {$ENDIF}
{$IFNDEF BUILDER4}
 {$IFDEF FPC}
  rppagesetuplcl,
 {$ELSE}
  rppagesetupvcl,
 {$ENDIF}
{$ENDIF}
{$IFDEF USEINDY}
 rpfmainmetaviewvcl,
{$ENDIF}
 rpmetafile,rptypes;

type
 TLCLReport=class(TCBaseReport)
  private
   prcontrol:TRpPreviewControl;
  protected
   procedure InternalExecuteRemote(metafile:TRpMetafileReport);override;
  public
   function Execute:boolean;override;
   procedure PrinterSetup;override;
   procedure PageSetup;
   function ShowParams:boolean;override;
   procedure SaveToPDF(filename:string;compressed:boolean=false);
   procedure SaveToMetafile(filename:string);
   procedure SaveToText(filename:string;textdriver:String='');override;
   procedure SaveToExcel(filename:string;onesheet:Boolean=false);
   function PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;override;
  published
   property Filename;
   property Preview;
   property ShowProgress;
   property Title;
   property ShowPrintDialog;
   property AliasList;
   property Language;
  end;

implementation

{$R 'rpvclreport.dcr'}

procedure TLCLReport.PrinterSetup;
var
 psetup:TPrinterSetUpDialog;
begin
 psetup:=TPRinterSetupDialog.Create(nil);
 try
  psetup.execute;
 finally
  psetup.free;
 end;
end;

function TLCLReport.ShowParams:boolean;
begin
 CheckLoaded;
 Result:=ShowUserParams(report.params);
end;





function TLCLReport.Execute:boolean;
var
 allpages,collate:boolean;
 frompage,topage,copies:integer;
 pconfig:TPrinterConfig;
begin
 inherited Execute;
 pconfig.Changed:=false;
{$IFDEF FPC}
rplcldriver.PrinterSelection(report.PrinterSelect,report.papersource,report.duplex,pconfig);
rplcldriver.OrientationSelection(report.PageOrientation);
{$ELSE}
rpgdidriver.PrinterSelection(report.PrinterSelect,report.papersource,report.duplex,pconfig);
rpgdidriver.OrientationSelection(report.PageOrientation);
{$ENDIF}
 try
 if Preview then
 begin
  prcontrol:=TRpPreviewControl.Create(nil);
  try
   prcontrol.Report:=Report;
   Result:=ShowPreview(prcontrol,Title);
  finally
   prcontrol.free;
  end;
 end
 else
 begin
  allpages:=true;
  collate:=report.CollateCopies;
  frompage:=1; topage:=MAX_PAGECOUNT;
  copies:=report.Copies;

  if ShowPrintDialog then
  begin
   if DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
   begin
    report.Metafile.BlockPrinterSelection:=true;
    try
     Result:=PrintReport(report,Title,Showprogress,allpages,frompage,
      topage,copies,collate);
    finally
     report.Metafile.BlockPrinterSelection:=false;
    end;
   end
   else
    Result:=false;
  end
  else
  begin
    report.Metafile.BlockPrinterSelection:=true;
    try
     Result:=PrintReport(report,Title,Showprogress,true,1,
      MAX_PAGECOUNT,report.copies,report.collatecopies);
    finally
     report.Metafile.BlockPrinterSelection:=false;
    end;
  end;
 end;
 finally
  //SetPrinterConfig(pconfig);
 end;
end;

function TLCLReport.PrintRange(frompage:integer;topage:integer;
    copies:integer;collate:boolean):boolean;
begin
 Result:=rplcldriver.PrintReport(Report,Title,ShowProgress,false,
  frompage,topage,copies,collate);
end;


procedure TLCLReport.SaveToPDF(filename:string;compressed:boolean=false);
begin
 CheckLoaded;
 rplcldriver.ExportReportToPDF(report,filename,ShowProgress,True,1,MAX_PAGECOUNT,1,
  false,filename,compressed,false)
end;

procedure TLCLReport.SaveToMetafile(filename:string);
var
 memstream:TMemoryStream;
begin
 CheckLoaded;
 memstream:=TMemoryStream.Create;
 try
  ExportReportToPDFMetaStream(report,filename,showprogress,true,1,MAX_PAGECOUNT,1,false,memstream,false,false,true);
  memstream.Seek(0,soFromBeginning);
  memstream.SaveToFile(filename);
 finally
  memstream.free;
 end;
end;

procedure TLCLReport.SaveToExcel(filename:string;onesheet:Boolean=false);
begin
// rplcldriver.CalcReportWidthProgress(report);
// rpexceldriver.ExportMetafileToExcel(report.metafile,filename,showprogress,false,
// true,1,999,onesheet);
end;

procedure TLCLReport.InternalExecuteRemote(metafile:TRpMetafileReport);
{$IFDEF USEINDY}
var
 allpages,collate:boolean;
 frompage,topage,copies:integer;
 doprint:boolean;
{$ENDIF}
begin
 inherited InternalExecuteRemote(metafile);

{$IFDEF USEINDY}
 if Preview then
 begin
  rpfmainmetaviewvcl.PreviewMetafile(metafile,nil,true,true);
 end
 else
 begin
  allpages:=true;
  collate:=false;
  frompage:=1; topage:=MAX_PAGECOUNT;
  copies:=1;
  doprint:=true;
  if ShowPrintDialog then
  begin
   if Not DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
    doprint:=false;
  end;
  if doprint then
  begin
   rpgdidriver.PrintMetafile(metafile,Title,ShowProgress,allpages,frompage,topage,copies,collate,GetDeviceFontsOption(metafile.PrinterSelect),metafile.PrinterSelect)
  end;
 end;
{$ENDIF}
end;

procedure TLCLReport.SaveToText(filename:string;textdriver:String='');
begin
 rptextdriver.PrintReportToText(report,'',false,true,1,999,
   1,filename,true,true,textdriver);
end;

procedure TLCLReport.PageSetup;
begin
{$IFNDEF BUILDER4}
 ExecutePageSetup(Report);
{$ENDIF}
{$IFDEF BUILDER4}
 Raise Exception.Create(SRpSFeaturenotsup);
{$ENDIF}
end;

end.
