{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdllutilqt                                     }
{       Exported functions for the Standarc C Libraary  }
{       Functions dependent on X Server running         }
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

unit rpdllutilqt;

{$I rpconf.inc}


interface


uses
{$IFDEF LINUX}
 ShareExcept,
{$ENDIF}
 SysUtils,Classes,rpreport,rpmdconsts,rppdfdriver,
{$IFDEF MSWINDOWS}
 Graphics,rpgdidriver,
 rpvpreview,rpvclreport,rppreviewcontrol,
{$ENDIF}
{$IFDEF LINUX}
 QGraphics,rpqtdriver,
 rppreview,rpclxreport,rppreviewcontrolclx,
{$ENDIF}
 rpdllutil;



function rp_print(hreport:integer;Title:PAnsiChar;
 showprogress,ShowPrintDialog:integer):integer;stdcall;
function rp_printw(hreport:integer;Title:PWideChar;
 showprogress,ShowPrintDialog:integer):integer;stdcall;
function rp_preview(hreport:integer;Title:PAnsiChar):integer;stdcall;
function rp_previeww(hreport:integer;Title:PWideChar):integer;stdcall;
function rp_previewremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar):integer;stdcall;
function rp_previewremotew(hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar):integer;stdcall;
function rp_printremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar;showprogress,showprintdialog:integer):integer;stdcall;
function rp_printremotew(hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar;showprogress,showprintdialog:integer):integer;stdcall;
function rp_previewremote_report(hreport:integer;hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar):integer;stdcall;
function rp_previewremote_reportw(hreport:integer;hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar):integer;stdcall;
function rp_printremote_report(hreport:integer;hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar;showprogress,showprintdialog:integer):integer;stdcall;
function rp_printremote_reportw(hreport:integer;hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar;showprogress,showprintdialog:integer):integer;stdcall;
function rp_bitmap(hreport:integer;outputfilename:PAnsiChar;ask,mono,vertres,horzres:integer):integer;stdcall;
function rp_bitmapw(hreport:integer;outputfilename:PWideChar;ask,mono,vertres,horzres:integer):integer;stdcall;

implementation

function rp_bitmap(hreport:integer;outputfilename:PAnsiChar;ask,mono,vertres,horzres:integer):integer;stdcall;
begin
 Result:=rp_bitmapw(hreport,PWidechar(WideString(outputfilename)),ask,mono,vertres,horzres);
end;

function rp_bitmapw(hreport:integer;outputfilename:PWideChar;ask,mono,vertres,horzres:integer):integer;stdcall;
var
 report:TRpReport;
 adriver:TRpPdfDriver;
 doexport:boolean;
 mon:boolean;
 abitmap:TBitmap;
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
  report:=FindReport(hreport);
  report.TwoPass:=true;
  adriver:=TRpPdfDriver.Create;
  try
   report.PrintAll(adriver);
   doexport:=true;
   mon:=mono=1;
   if ask=1 then
    doexport:=AskBitmapProps(horzres,vertres,mon);
   if doexport then
   begin
    abitmap:=MetafileToBitmap(report.Metafile,ask<>0,mon,horzres,vertres);
    try
     if assigned(abitmap) then
      abitmap.SaveToFile(StrPas(outputfilename));
    finally
     abitmap.free;
    end;
   end;
  finally
   adriver.free;
  end;
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;

function rp_print(hreport:integer;Title:PAnsiChar;
 showprogress,ShowPrintDialog:integer):integer;
begin
 Result:=rp_printw(hreport,PWidechar(WideString(Title)),showprogress,ShowPrintdialog);
end;


function rp_printw(hreport:integer;Title:PWideChar;
 showprogress,ShowPrintDialog:integer):integer;
var
 report:TRpReport;
 allpages,collate:boolean;
 frompage,topage,copies:integer;
 ashowprogress:boolean;
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
  ashowprogress:=true;
  if showprogress=0 then
   ashowprogress:=false;
  report:=FindReport(hreport);
  allpages:=true;
  collate:=report.CollateCopies;
  frompage:=1; topage:=999999;
  copies:=report.Copies;
  if ShowPrintDialog<>0 then
  begin
   if DoShowPrintDialog(allpages,frompage,topage,copies,collate) then
   begin
    if Not PrintReport(report,Title,aShowprogress,allpages,frompage,
     topage,copies,collate) then
     Result:=0;
   end
   else
    Result:=0;
  end
  else
  begin
   if not PrintReport(report,Title,aShowprogress,true,1,
     9999999,report.copies,report.collatecopies) then
    Result:=0;
  end;
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;

function rp_preview(hreport:integer;Title:PAnsiChar):integer;
begin
 Result:=rp_previeww(hreport,PWidechar(WideString(Title)));
end;

function rp_previeww(hreport:integer;Title:PWideChar):integer;
var
 report:TRpReport;
{$IFDEF MSWINDOWS}
 prcontrol:TRpPreviewControl;
{$ENDIF}
{$IFDEF LINUX}
 prcontrol:TRpPreviewControlCLX;
{$ENDIF}
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
  report:=FindReport(hreport);
{$IFDEF MSWINDOWS}
  prcontrol:=TRppreviewControl.Create(nil);
  try
   prcontrol.Report:=report;
   ShowPreview(prcontrol,Title);
  finally
   prcontrol.free;
  end;
{$ENDIF}
{$IFDEF LINUX}
  prcontrol:=TRppreviewControlCLX.Create(nil);
  try
   prcontrol.Report:=report;
   ShowPreview(prcontrol,Title,True);
  finally
   prcontrol.free;
  end;
{$ENDIF}
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;


function rp_previewremote_report(hreport:integer;hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar):integer;stdcall;
begin
 Result:=rp_previewremote_reportw(hreport,PWidechar(WideString(hostname)),port,PWidechar(WideString(user)),PWidechar(WideString(password)),PWidechar(WideString(aliasname)),PWidechar(WideString(reportname)),PWidechar(WideString(title)));
end;

function rp_previewremote_reportw(hreport:integer;hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar):integer;stdcall;
var
{$IFDEF MSWINDOWS}
 rep:TVCLReport;
{$ENDIF}
{$IFDEF LINUX}
 rep:TCLXReport;
{$ENDIF}
 memstream:TMemoryStream;
 report:TRpReport;
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
{$IFDEF MSWINDOWS}
  rep:=TVCLReport.Create(nil);
{$ENDIF}
{$IFDEF LINUX}
  rep:=TCLXReport.Create(nil);
{$ENDIF}
  try
   rep.Preview:=true;
   rep.Title:=title;
   report:=FindReport(hreport);
   memstream:=TMemoryStream.Create;
   try
    report.SaveToStream(memstream);
    memstream.Seek(0,soFromBeginning);
    rep.LoadFromStream(memstream);
   finally
    memstream.free;
   end;
   rep.ExecuteRemote(hostname,port,user,password,aliasname,reportname);
  finally
   rep.free;
  end;
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;

function rp_printremote_report(hreport:integer;hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar;showprogress,showprintdialog:integer):integer;stdcall;
begin
 result:=rp_printremote_reportw(hreport,PWidechar(WideString(hostname)),port,PWidechar(WideString(user)),PWidechar(WideString(password)),PWidechar(WideString(aliasname)),PWidechar(WideString(reportname)),PWidechar(WideString(title)),showprogress,showprintdialog);
end;

function rp_printremote_reportw(hreport:integer;hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar;showprogress,showprintdialog:integer):integer;stdcall;
var
{$IFDEF MSWINDOWS}
 rep:TVCLReport;
{$ENDIF}
{$IFDEF LINUX}
 rep:TCLXReport;
{$ENDIF}
 memstream:TMemoryStream;
 report:TRpReport;
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
{$IFDEF MSWINDOWS}
  rep:=TVCLReport.Create(nil);
{$ENDIF}
{$IFDEF LINUX}
  rep:=TCLXReport.Create(nil);
{$ENDIF}
  try
   rep.Preview:=false;
   rep.Title:=title;
   rep.ShowPrintDialog:=(showprintdialog<>0);
   rep.ShowProgress:=(showprogress<>0);
   report:=FindReport(hreport);
   memstream:=TMemoryStream.Create;
   try
    report.SaveToStream(memstream);
    memstream.Seek(0,soFromBeginning);
    rep.LoadFromStream(memstream);
   finally
    memstream.free;
   end;
   rep.ExecuteRemote(hostname,port,user,password,aliasname,reportname);
  finally
   rep.free;
  end;
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;

function rp_previewremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar):integer;stdcall;
begin
 result:=rp_previewremotew(PWidechar(WideString(hostname)),port,PWidechar(WideString(user)),PWidechar(WideString(password)),PWidechar(WideString(aliasname)),PWidechar(WideString(reportname)),PWidechar(WideString(title)));
end;

function rp_previewremotew(hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar):integer;stdcall;
var
{$IFDEF MSWINDOWS}
 rep:TVCLReport;
{$ENDIF}
{$IFDEF LINUX}
 rep:TCLXReport;
{$ENDIF}
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
{$IFDEF MSWINDOWS}
  rep:=TVCLReport.Create(nil);
{$ENDIF}
{$IFDEF LINUX}
  rep:=TCLXReport.Create(nil);
{$ENDIF}
  try
   rep.Preview:=true;
   rep.Title:=title;
   rep.ExecuteRemote(hostname,port,user,password,aliasname,reportname);
  finally
   rep.free;
  end;
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;

function rp_printremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar;showprogress,showprintdialog:integer):integer;stdcall;
begin
 Result:=rp_printremotew(PWidechar(WideString(hostname)),port,PWidechar(WideString(user)),PWidechar(WideString(password)),PWidechar(WideString(aliasname)),PWidechar(WideString(reportname)),PWidechar(WideString(title)),showprogress,showprintdialog);
end;

function rp_printremotew(hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar;
 showprogress,showprintdialog:integer):integer;stdcall;
var
{$IFDEF MSWINDOWS}
 rep:TVCLReport;
{$ENDIF}
{$IFDEF LINUX}
 rep:TCLXReport;
{$ENDIF}
begin
 rplibdoinit;
 rplasterror:='';
 Result:=1;
 try
{$IFDEF MSWINDOWS}
  rep:=TVCLReport.Create(nil);
{$ENDIF}
{$IFDEF LINUX}
  rep:=TCLXReport.Create(nil);
{$ENDIF}
  try
   rep.Preview:=false;
   rep.Title:=title;
   rep.ShowPrintDialog:=(showprintdialog<>0);
   rep.ShowProgress:=(showprogress<>0);
   rep.ExecuteRemote(hostname,port,user,password,aliasname,reportname);
  finally
   rep.free;
  end;
 except
  on E:Exception do
  begin
   rplasterror:=E.Message;
   Result:=0;
  end;
 end;
end;

end.
