{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rplclfonts                                      }
{       Utilities for FreePascal lcl fonts              }
{       allow the use of device dependent fonts         }
{       in a device independent way                     }
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

unit rplclfonts;

{$I rpconf.inc}

interface

uses SysUtils, Classes,
 Graphics, Controls,printers,
 rpmunits,Forms,
 rptypes,syncobjs;

type
  TPrinterFont=class(TObject)
   private
    FFont:TFont;
    procedure SetFont(Valor:TFont);
   public
    fstep:TRpFontStep;
    isred:boolean;
    constructor Create;virtual;
    destructor Destroy;override;
    property Font:TFont read FFont write SetFont;
   end;

   TGDIFontType=(tfontraster,tfonttruetype,tfontdevice,tfonttruetypedevice);
   TCaracfont=class(TObject)
    public
     name:string;
     sizes:TStringlist;
     ftype:TGDIFontType;
     fstep:TRpFontStep;
     fixed:boolean;
     constructor Create;
     destructor Destroy;override;
    end;



var
 PrinterFonts:TList;
 PrinterSorted:TStringList;
 caracfonts:TStringlist;
 ScreenSorted:TStringList;

implementation

var
 currentprinter:integer;
 idx:integer;
 sizestruetype:Tstringlist;


procedure lliberacaracfonts;
var
 i:integeR;
begin
 for i:=0 to caracfonts.count-1 do
 begin
  caracfonts.objects[i].free;
 end;
 caracfonts.clear;
end;

function CompareFonts(font1,font2:TPrinterFont):integer;
var
 log1,log2:TPrinterFont;
begin
 log1:=Font1;
 log2:=Font2;
 if log1.fstep>log2.fstep then
  Result:=1
 else
  if log1.fstep<log2.fstep then
   result:=-1
  else
  begin
   if log1.Font.Name>log2.Font.Name then
    Result:=-1
   else
    if log1.Font.Name>log2.Font.Name then
     Result:=1
    else
     Result:=0;
  end;
end;

constructor TPrinterFont.Create;
begin
 inherited Create;
 FFOnt:=TFont.Create;
end;

destructor TPrinterFont.Destroy;
begin
 FFont.free;
 inherited Destroy;
end;

procedure TPrinterFont.SetFont(Valor:TFont);
begin
 FFOnt.Assign(Valor);
end;




constructor TCaracfont.Create;
begin
 inherited Create;

 sizes:=TStringList.create;
 sizes.sorted:=true;
end;

destructor TCaracfont.destroy;
begin
 sizes.free;
 inherited destroy;
end;



initialization
PrinterSorted:=TStringList.Create;
PrinterSorted.Sorted:=True;
PrinterFonts:=TList.Create;
ScreenSorted:=TStringList.Create;
ScreenSorted.Sorted:=True;
caracfonts:=TStringlist.create;
caracfonts.sorted:=true;
ScreenSorted.Assign(Screen.Fonts);
currentprinter:=-1;
sizestruetype:=TStringlist.create;
with sizestruetype do
begin
 Add('  8');
 Add('  9');
 Add(' 10');
 Add(' 11');
 Add(' 12');
 Add(' 14');
 Add(' 16');
 Add(' 18');
 Add(' 20');
 Add(' 22');
 Add(' 24');
 Add(' 26');
 Add(' 28');
 Add(' 36');
 Add(' 48');
 Add(' 72');
end;


finalization
 idx:=0;
 while idx<PrinterFonts.Count do
 begin
  TPrinterFont(PrinterFonts.Items[idx]).Free;
  Inc(idx);
 end;
PrinterFonts.free;
PrinterSorted.free;
ScreenSorted.free;
lliberacaracfonts;
caracfonts.free;
sizestruetype.free;
end.
