; -- 32Bit.iss --
; Demonstrates installation of a program built for the x32 (a.k.a. AMD32)
; architecture.
; To successfully run this installation and the program it installs,
; you must have a "x32" edition of Windows.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=Report Manager Server and Tools(x86)
AppVersion=3.1.1
DefaultDirName={pf}\Report Manager
DefaultGroupName=Report Manager
UninstallDisplayIcon={app}\repmandxp.exe
Compression=lzma2
SolidCompression=yes
OutputDir=userdocs:prog\toni\reportman\install\Output
AppPublisher=Toni Martir
AppPublisherURL=http://reportman.sourceforge.net
VersionInfoProductName=Report Manager Tools
VersionInfoProductVersion=3.1.1
OutputBaseFilename=reportman_server_3_1_1tools_x86

[Files]
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\app\bin32\reportserverappxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\config\bin32\repserverconfigxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\metaview\bin32\metaviewxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\web\bin32\repwebexe.exe"; DestDir: "{app}\Web"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\web\bin32\repwebserver.dll"; DestDir: "{app}\Web"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\web\*.html"; DestDir: "{app}\Web\Templates"
Source: "C:\Users\toni\Documents\prog\toni\reportman\webactivex\reportman.htm"; DestDir: "{app}\Web\SamplePlugin"
Source: "C:\Users\toni\Documents\prog\toni\reportman\webactivex\bin32\WebReportManX.ocx"; DestDir: "{app}\Web"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\printreptopdf\bin32\printreptopdf.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\printrep\bin32\printrepxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\metaprint\bin32\metaprintxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\reportmanres.*"; DestDir: "{app}\Translation"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\rptranslator\bin32\rptranslate.exe"; DestDir: "{app}\Translation"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\rptranslator\rptranslateres.*"; DestDir: "{app}\Translation"
Source: "C:\Users\toni\Documents\prog\toni\reportman\activex\bin32\Reportman.ocx"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\compilerep\bin32\compilerep.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\upx.exe"; DestDir: "{app}"
; Api libraries
Source: C:\Users\toni\Documents\prog\toni\reportman\rpreportman.h; DestDir: {app}\api; Flags: ignoreversion
Source: C:\Users\toni\Documents\prog\toni\reportman\rpreportmanapi.bas; DestDir: {app}\api;  Flags: ignoreversion
Source: C:\Users\toni\Documents\prog\toni\reportman\tests\gcctest\Reportman.def; DestDir: {app}\api;  Flags: ignoreversion


[Icons]
Name: "{group}\Report Manager Server"; Filename: "{app}\reportserverappxp.exe"
Name: "{group}\Report Manager Server Configuration"; Filename: "{app}\repserverconfigxp.exe"
Name: "{group}\Report Manager Client"; Filename: "{app}\metaviewxp.exe"
Name: "{group}\Report Manager Translator"; Filename: "{app}\Translation\rptranslate.exe"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Registry]
Root: HKCR; Subkey: .rpmf; ValueType: string; ValueName: ; ValueData: Report Manager Client; Flags: uninsdeletevalue
Root: HKCR; Subkey: Report Manager Client; ValueType: string; ValueName: ; ValueData: Report Manager Metafile; Flags: uninsdeletekey
Root: HKCR; Subkey: Report Manager Client\DefaultIcon; ValueType: string; ValueName: ; ValueData: {app}\metaviewxp.exe,0
Root: HKCR; Subkey: Report Manager Client\shell\open\command; ValueType: string; ValueName: ; ValueData: """{app}\metaviewxp.exe"" ""%1"""
