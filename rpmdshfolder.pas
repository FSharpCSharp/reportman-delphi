{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdshfolder                                    }
{                                                       }
{                                                       }
{       An interface to user and system config files    }
{       to store information with a Windows 2000        }
{       compliant procedure (and LSB in Linux)          }
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

unit rpmdshfolder;

interface

{$I rpconf.inc}

uses
  SysUtils, Classes,
{$IFDEF LINUX}
  {$IFNDEF FPC}
//   Libc,
  {$ENDIF}
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFNDEF USEVARIANTS}
{$IFNDEF FPC}
  FileCtrl,
{$ENDIF}
{$ENDIF}
{$IFDEF DOTNETD}
  System.IO,
{$ENDIF}
  rpmdconsts;

{$IFDEF MSWINDOWS}
const
{$IFNDEF DOTNETD}
  {$EXTERNALSYM CSIDL_APPDATA}
  CSIDL_APPDATA              = $001A;  // Application Data, new for NT4
  {$EXTERNALSYM CSIDL_FLAG_CREATE}
  CSIDL_FLAG_CREATE          = $8000;  // new for Win2K, or this in to force
  {$EXTERNALSYM CSIDL_LOCAL_APPDATA}
  CSIDL_LOCAL_APPDATA        = $001C;  // non roaming,
  {$EXTERNALSYM CSIDL_COMMON_APPDATA}
  CSIDL_COMMON_APPDATA       = $0023;  // All Users\Application Data
{$ENDIF}

  shlwapi32 = 'shlwapi.dll';
  shfolder  = 'shfolder.dll';
{$ENDIF}
{$IFDEF LINUX}
const
 DIR_SEPARATOR='/';
{$ENDIF}
{$IFDEF MSWINDOWS}
 DIR_SEPARATOR='\';
{$ENDIF}


  function Obtainininameuserconfig (company, product, filename:string):string;
  function Obtainininamelocaluserconfig(company,product,filename:string):string;
  function Obtainininamelocalconfig (company, product, filename:string):string;
  function Obtainininamecommonconfig (company, product, filename:string):string;overload;
  function Obtainininamecommonconfig(company,product,filename:string;create:boolean):string;overload;
  function GetTheSystemDirectory:String;
{$IFDEF MSWINDOWS}
var SHGetFolderPathA:function (hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PAnsiChar): HResult; stdcall;
var SHGetFolderPathW:function (hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PWideChar): HResult; stdcall;
var HandleLib:THandle;
var PathAppendA:function (pszPath: PAnsiChar; pMore: PAnsiChar): BOOL; stdcall;
var PathAppendW:function (pszPath: PWideChar; pMore: PWideChar): BOOL; stdcall;
var HandleLib2:THandle;
{$ENDIF}

implementation

uses rptypes;


function Obtainininamelocaluserconfig(company,product,filename:string):string;
var
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
{$IFDEF LINUX}
 ap:PCHar;
 szAppdata:array [0..MAX_PATH] of AnsiChar;
{$ELSE}
szAppDataA:array [0..MAX_PATH] of AnsiChar;
szAppDataW:array [0..MAX_PATH] of WideChar;
{$ENDIF}
 nresult:THandle;
begin

{$IFDEF LINUX}
{$IFDEF FPC}
 ap:=PChar(Sysutils.GetEnvironmentVariable('HOME'));
{$ELSE}
 ap:=Pchar(System.SysUtils.GetEnvironmentVariable('HOME'));
{$ENDIF}
 if assigned(ap) then
 begin
  StrPCopy(szAppdata,ap);
  Result:=StrPas(szAppdata)+'/.'
 end
 else
  Result:='./.';
 if length(company)>0 then
  Result:=Result+company+'.';
 if length(product)>0 then
  Result:=Result+product+'.';
 Result:=Result+filename;
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
  nresult:=SHGetFolderPathW(0, CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wproduct)) then
    RaiseLastOSError;
  end;

  Result:=WideCharToString(szAppdataW);
 if (S_OK <>nresult) then
 begin
  Result:=Result+'Error in ShGetFolderPath(CSIDL_APPDATA or CSIDL_FLAG_CREATE)';
  exit;
 end;



 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
  if not PathAppendW(szAppdataW,PWidechar(WideString(filename+'.ini'))) then
    RaiseLastOSError;
  Result:=WideCharToString(szAppdataW);
{$ENDIF}
end;
function Obtainininameuserconfig(company,product,filename:string):string;
var
 szAppDataA:array [0..MAX_PATH] of AnsiChar;
 szAppDataW:array [0..MAX_PATH] of WideChar;
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
{$IFDEF LINUX}
 ap:PCHar;
{$ENDIF}
 nresult:THandle;
begin

{$IFDEF LINUX}
 ap:=PChar(System.SysUtils.GetEnvironmentVariable('HOME'));
 if assigned(ap) then
 begin
  StrPCopy(szAppdataA,ap);
  Result:=StrPas(szAppdataA)+'/.'
 end
 else
  Result:='./.';
 if length(company)>0 then
  Result:=Result+company+'.';
 if length(product)>0 then
  Result:=Result+product+'.';
 Result:=Result+filename;
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
  nresult:=SHGetFolderPathW(0, CSIDL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wproduct)) then
    RaiseLastOSError;
  end;

  Result:=WideCharToString(szAppdataW);
 if (S_OK <>nresult) then
 begin
  Result:=Result+'Error in ShGetFolderPath(CSIDL_APPDATA or CSIDL_FLAG_CREATE)';
  exit;
 end;



 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
  if not PathAppendW(szAppdataW,PWidechar(WideString(filename+'.ini'))) then
    RaiseLastOSError;
  Result:=WideCharToString(szAppdataW);
{$ENDIF}
end;



function Obtainininamecommonconfig(company,product,filename:string):string;
begin
 Result:=Obtainininamecommonconfig(company,product,filename,true);
end;

{$IFDEF MSWINDOWS}
function GetWebPath: string;
 var
 Path: array[0..MAX_PATH - 1] of Char;
 PathStr: string;
 begin
 Setstring(PathStr, Path, GetModuleFileName(HInstance, Path,
 SizeOf(Path)));
 result := ExtractFilePath ( PathStr ) ;
 if (Copy(result,1,4)='\\?\') then
  result:=Copy(result,5,Length(result));
 end;
{$ENDIF}

function Obtainininamecommonconfig(company,product,filename:string;create:boolean):string;
var
 nresult:THandle;
 szAppDataA:array [0..MAX_PATH] of AnsiChar;
 szAppDataW:array [0..MAX_PATH] of WideChar;
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
{$IFDEF MSWINDOWS}
 dwflags:Cardinal;
{$ENDIF}
hardcoded:boolean;
begin
 hardcoded:=false;
{$IFDEF LINUX}
 Result:='/etc/'+company+product+filename;
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
 Result:='';
  dwflags:=CSIDL_COMMON_APPDATA;
  if (create) then
    dwflags:=dwflags or CSIDL_FLAG_CREATE;
  nresult:=SHGetFolderPathW(0, dwflags, 0, 0, szAppDataW);
  Result:='';
  if ((nresult=S_OK)) then
   Result:=Trim(WideCharToString(szAppdataW));
  if ((nresult<>S_OK) or (Length(Result)=0)) then
  begin
   // Error in apache configuration
   dwflags:=CSIDL_LOCAL_APPDATA;
   if (create) then
     dwflags:=dwflags or CSIDL_FLAG_CREATE;
   nresult:=SHGetFolderPathW(0,  dwflags, 0, 0, szAppDataW);
   Result:=WideCharToString(szAppdataW);
   Result:='';
   if ((nresult<>S_OK)) then
    Result:=Trim(WideCharToString(szAppdataW));
   if ((nresult<>S_OK) or (Length(Result)=0)) then
   begin
    try
     if ((nresult<>S_OK)) then
      RaiseLastOsError
     else
     begin
      // Hard coded path to the application executable path
      Result:=GetWebPath;
      hardcoded:=true;
      //raise Exception.Create('Calls to SHGetFolderPathW '+
      // ' returns empty string ');
     end;
    except
     Result:=GetWebPath;
     hardcoded:=true;
(*     On E:Exception do
     begin
      raise Exception.Create('Error calling SHGetFolderPathW CSIDL_COMMON_APPDATA && CSIDL_LOCAL_APPDATA:'+
       'Error code:'+IntToStr(nresult)+' '+E.Message);
     end;*)
    end;
   end;
  end;
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   Result:=Result+'\'+wcompany;
//   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
//    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   Result:=Result+'\'+wproduct;
//   if not PathAppendW(szAppdataW,PWidechar(wproduct)) then
//    RaiseLastOSError;
  end;
//  Result:=WideCharToString(szAppdataW);
 //if (S_OK <>nresult) then
 //begin
  //Result:=Result+'Error in ShGetFolderPath(CSIDL_COMMON_APPDATA or CSIDL_FLAG_CREATE)';
  //exit;
 //end;

 if (hardcoded) then
 begin
  Result:=result+'\'+filename+'.ini';
  exit;
 end;

 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
  if not PathAppendW(szAppdataW,PWidechar(WideString(filename+'.ini'))) then
    RaiseLastOSError;
  Result:=WideCharToString(szAppdataW);
{$ENDIF}
end;


function Obtainininamelocalconfig(company,product,filename:string):string;
var
 nresult:THandle;
 szAppDataA:array [0..MAX_PATH] of AnsiChar;
 szAppDataW:array [0..MAX_PATH] of WideChar;
 wcompany:Widestring;
 wproduct:WideString;
 wfilename:WideString;
begin
{$IFDEF LINUX}
 Result:=Obtainininameuserconfig(company,product+'etc',filename);
{$ENDIF}
{$IFDEF MSWINDOWS}
 if length(filename)<1 then
  Raise Exception.Create(SRpFileNameRequired);
  nresult:=SHGetFolderPathW(0, CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE, 0, 0, szAppDataW);
  wcompany:=company;
  wproduct:=product;
  wfilename:=filename;
  if length(wcompany)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wcompany)) then
    RaiseLastOSError;
  end;
  if Length(wproduct)>0 then
  begin
   if not PathAppendW(szAppdataW,PWidechar(wproduct)) then
    RaiseLastOSError;
  end;
  Result:=WideCharToString(szAppdataW);
 if (S_OK <>nresult) then
 begin
  Result:=Result+'Error in ShGetFolderPath(CSIDL_LOCAL_APPDATA or CSIDL_FLAG_CREATE)';
  exit;
 end;



 if Not DirectoryExists(Result) then
 begin
{$IFDEF BUILDER4}
 ForceDirectories(Result);
{$ENDIF}
{$IFNDEF BUILDER4}
 try
  if not ForceDirectories(Result) then
   Result:='';
 except
   Result:='';
 end;
{$ENDIF}
 end;
  if not PathAppendW(szAppdataW,PWidechar(WideString(filename+'.ini'))) then
    RaiseLastOSError;
  Result:=WideCharToString(szAppdataW);
{$ENDIF}
end;

function GetTheSystemDirectory:String;
{$IFDEF MSWINDOWS}
var
 pbuf:PChar;
 asize:Integer;
{$ENDIF}
begin
{$IFDEF LINUX}
 Result:='/lib';
{$ENDIF}
{$IFDEF MSWINDOWS}
 pbuf:=AllocMem(MAX_PATH+1);
 try
  asize:=GetSystemDirectory(pbuf,MAX_PATH);
  if asize=0 then
   RaiseLastOsError;
  if asize>MAX_PATH then
  begin
   asize:=GetSystemDirectory(pbuf,MAX_PATH);
   if asize=0 then
    RaiseLastOsError;
  end;
  result:=StrPas(pbuf);
 finally
  FreeMem(pbuf);
 end;
{$ENDIF}
end;



initialization

{$IFDEF MSWINDOWS}
HandleLib:=LoadLibrary(shfolder);
if HandleLib=0 then
 RaiseLastOSError;
HandleLib2:=LoadLibrary(shlwapi32);
if HandleLib=2 then
 RaiseLastOSError;
//{$IFDEF DELPHI2009UP
//SHGetFolderPath:=GetProcAddress(HandleLib,PChar('SHGetFolderPathW'));
//{$ENDIF}
//{$IFNDEF DELPHI2009UP}
 SHGetFolderPathW:=GetProcAddress(HandleLib,PChar('SHGetFolderPathW'));
 if Not Assigned(SHGetFolderPathW) then
  RaiseLastOSError;
//{$ENDIF}
//{$IFDEF DELPHI2009UP}
//PathAppend:=GetProcAddress(HandleLib2,PChar('PathAppendW'));
//{$ENDIF}
//{$IFNDEF DELPHI2009UP}
 PathAppendW:=GetProcAddress(HandleLib2,PChar('PathAppendW'));
 if Not Assigned(PathAppendW) then
  RaiseLastOSError;
//{$ENDIF}
{$ENDIF}

finalization

{$IFDEF MSWINDOWS}
if HandleLib<>0 then
 FreeLibrary(HandleLib);
if HandleLib2<>0 then
 FreeLibrary(HandleLib2);
{$ENDIF}

end.











