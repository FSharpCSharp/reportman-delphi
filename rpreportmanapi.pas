{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpdllutil                                       }
{       Exported functions for the Standarc C Library   }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpreportmanapi;

interface

{$IFNDEF LINUX}
 {$DEFINE MSWINDOWS}
{$ENDIF}

const
{$IFDEF MSWINDOWS}
 REP_LIBNAME='ReportMan.ocx';
{$ENDIF}
{$IFDEF LINUX}
 REP_LIBNAME='reportmanapi.so';
{$ENDIF}

function rp_open(filename:PAnsiChar):integer;stdcall;external REP_LIBNAME;
function rp_openw(filename:PWideChar):integer;stdcall;external REP_LIBNAME;
function rp_execute(hreport:integer;outputfilename:PAnsiChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_executew(hreport:integer;outputfilename:PWideChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_close(hreport:integer):integer;stdcall;external REP_LIBNAME;
function rp_lasterror:PAnsiChar;stdcall;external REP_LIBNAME;
function rp_lasterrorw:PWideChar;stdcall;external REP_LIBNAME;
function rp_executeremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname:PAnsiChar;outputfilename:PAnsiChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_executeremotew(hostname:PWideChar;port:integer;user,password,aliasname,reportname:PWideChar;outputfilename:PWideChar;metafile,
 compressed:integer):integer;stdcall;external REP_LIBNAME;
function rp_setparamvalue(hreport:integer;paramname:pAnsichar;paramtype:integer;
 paramvalue:Pointer):integer;external REP_LIBNAME;
function rp_setparamvaluew(hreport:integer;paramname:pWidechar;paramtype:integer;
 paramvalue:Pointer):integer;external REP_LIBNAME;
function rp_getparamcount(hreport:integer;var paramcount:Integer):integer;external REP_LIBNAME;
function rp_getparamname(hreport:integer;index:integer;
 abuffer:PAnsiChar):integer;external REP_LIBNAME;
function rp_getparamnamew(hreport:integer;index:integer;
 abuffer:PWideChar):integer;external REP_LIBNAME;
{$IFDEF MSWINDOWS}
function rp_print(hreport:integer;Title:PAnsiChar;
 showprogress,ShowPrintDialog:integer):integer;stdcall;external REP_LIBNAME;
function rp_printw(hreport:integer;Title:PWideChar;
 showprogress,ShowPrintDialog:integer):integer;stdcall;external REP_LIBNAME;
function rp_preview(hreport:integer;Title:PAnsiChar):integer;stdcall;external REP_LIBNAME;
function rp_previeww(hreport:integer;Title:PWideChar):integer;stdcall;external REP_LIBNAME;
function rp_previewremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar):integer;stdcall;external REP_LIBNAME;
function rp_previewremotew(hostname:PWideChar;port:integer;user,password,aliasname,reportname,title:PWideChar):integer;stdcall;external REP_LIBNAME;
function rp_printremote(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PAnsiChar;showprogress,showprintdialog:integer):integer;external REP_LIBNAME;
function rp_printremotew(hostname:PAnsiChar;port:integer;user,password,aliasname,reportname,title:PWideChar;showprogress,showprintdialog:integer):integer;external REP_LIBNAME;
function rp_setparamvaluevar(hreport:integer;paramname:pAnsichar;
 paramvalue:OleVariant):integer;external REP_LIBNAME;
function rp_setparamvaluevarw(hreport:integer;paramname:pWidechar;
 paramvalue:OleVariant):integer;external REP_LIBNAME;
function rp_setadoconnectionstring(hreport:integer;conname:pAnsichar;
 constring:PAnsiChar):integer;external REP_LIBNAME;
function rp_setadoconnectionstringw(hreport:integer;conname:pWidechar;
 constring:PWideChar):integer;external REP_LIBNAME;
function rp_bitmap(hreport:integer;outputfilename:PAnsiChar;
 ask,mono,vertres,horzres:integer):integer;stdcall;external REP_LIBNAME;
function rp_bitmapw(hreport:integer;outputfilename:PWideChar;
 ask,mono,vertres,horzres:integer):integer;stdcall;external REP_LIBNAME;
function rp_getdefaultprinter:pAnsichar;stdcall;external REP_LIBNAME;
function rp_getdefaultprinterw:pWidechar;stdcall;external REP_LIBNAME;
function rp_getprinters:pAnsichar;stdcall;external REP_LIBNAME;
function rp_getprintersw:pWidechar;stdcall;external REP_LIBNAME;
function rp_setdefaultprinter(device:pansichar):integer;stdcall;external REP_LIBNAME;
function rp_setdefaultprinterw(device:pWidechar):integer;stdcall;external REP_LIBNAME;
{$ENDIF}

implementation

end.

