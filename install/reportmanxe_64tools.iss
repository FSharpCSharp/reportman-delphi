; -- 64Bit.iss --
; Demonstrates installation of a program built for the x64 (a.k.a. AMD64)
; architecture.
; To successfully run this installation and the program it installs,
; you must have a "x64" edition of Windows.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=Report Manager Server and Tools(x64)
AppVersion=3.4.6
DefaultDirName={pf}\Report Manager
DefaultGroupName=Report Manager
UninstallDisplayIcon={app}\repmandxp.exe
Compression=lzma2
SolidCompression=yes
OutputDir=userdocs:prog\toni\reportman\install\Output
; "ArchitecturesAllowed=x64" specifies that Setup cannot run on
; anything but x64.
ArchitecturesAllowed=x64
; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64
AppPublisher=Toni Martir
AppPublisherURL=http://reportman.sourceforge.net
VersionInfoProductName=Report Manager Tools
VersionInfoProductVersion=3.4.6
OutputBaseFilename=reportman_server_3_4_6tools_x64

[Files]
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\app\bin64\reportserverappxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\config\bin64\repserverconfigxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\metaview\bin64\metaviewxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\web\bin64\repwebexe.exe"; DestDir: "{app}\Web"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\web\bin64\repwebserver.dll"; DestDir: "{app}\Web"
Source: "C:\Users\toni\Documents\prog\toni\reportman\server\web\*.html"; DestDir: "{app}\Web\Templates"
;Source: "C:\Users\toni\Documents\prog\toni\reportman\webactivex\reportman.htm"; DestDir: "{app}\Web\SamplePlugin"
;Source: "C:\Users\toni\Documents\prog\toni\reportman\webactivex\bin64\WebReportManX.ocx"; DestDir: "{app}\Web"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\printreptopdf\bin64\printreptopdf.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\printrep\bin64\printrepxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\metaprint\bin64\metaprintxp.exe"; DestDir: "{app}"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\reportmanres.*"; DestDir: "{app}\Translation"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\rptranslator\bin64\rptranslate.exe"; DestDir: "{app}\Translation"
Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\rptranslator\rptranslateres.*"; DestDir: "{app}\Translation"
Source: "C:\Users\toni\Documents\prog\toni\reportman\activex\bin64\Reportman.ocx"; DestDir: "{app}"

;Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\utils\compilerep\bin64\compilerep.exe"; DestDir: "{app}"
;Source: "C:\Users\toni\Documents\prog\toni\reportman\repman\upx.exe"; DestDir: "{app}"

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
