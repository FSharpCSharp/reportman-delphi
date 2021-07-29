// Report Manager
// Rpgdidriver
// TRpGDIDriver: Printer driver for  VCL Lib
// can be used only for windows }
// it includes printer and bitmap support
//
// Copyright (c) 1994-2019 Toni Martir
// toni@reportman.es
//
// This file is under the MPL license
// If you enhace this file you must provide
// source code

unit rpgdidriver;

interface

{$I rpconf.inc}

uses
  mmsystem, windows,
  Classes, sysutils, rpmetafile, rpmdconsts, Graphics, Forms,
  rpmunits, Printers, Dialogs, Controls, rpgdifonts, Math,
  StdCtrls, ExtCtrls, rppdffile, rpgraphutilsvcl, WinSpool, rpmdcharttypes,
{$IFDEF FIREDAC}
  Firedac.VCLUI.Wait,
{$ENDIF}
{$IFDEF VCLNOTATION}
  VCL.Imaging.jpeg, VCL.Imaging.pngimage, System.Win.registry,
{$ENDIF}
{$IFNDEF FORWEBAX}
  rpmdchart,
{$ENDIF}
{$IFDEF USEVARIANTS}
  types, Variants,
{$ENDIF}
{$IFDEF DOTNETD}
  System.ComponentModel,
{$ENDIF}
  rptypes, rpvgraphutils,
{$IFNDEF FORWEBAX}
  rpbasereport, rpreport,
{$IFDEF USETEECHART}
{$IFDEF VCLNOTATION}
  VCLTee.Chart, VCLTee.Series, rpdrawitem,
  VCLTee.teEngine, VCLTee.ArrowCha, VCLTee.BubbleCh, VCLTee.GanttCh,
  VCLTee.teeFunci, VCLTee.TeCanvas,
{$IFDEF TEECHARTPRO}
  VCLTee.statChar,
  VCLTee.CandleCh,VCLTee.TeePyramid,VCLTee.OHLChart,VCLTee.TeeFunnel,
  VCLTee.TeeKagiSeries,  VCLTee.TeeDonut,VCLTee.TeePolar,VCLTee.TeeRenkoSeries,
  VCLTee.ErrorBar,
{$ENDIF}

{$ENDIF}
{$IFNDEF VCLNOTATION}
  Chart, Series, rpdrawitem, teeFunci,
  teEngine, ArrowCha, BubbleCh, GanttCh,
  jpeg,registry,ErrorBar,
{$IFDEF TEECHARTPRO}
 StatChar,CandleCh,TeePyramid,TeePolar,OHLChart,TeeFunnel,TeeKagiSeries,
 TeeDonut,TeeRenkoSeries,
{$ENDIF}
{$IFDEF DELPHI2009UP}
  pngimage, VCLTee.TeCanvas, System.UITypes,
{$ELSE}
  TeCanvas,
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
  rpgraphicex,
{$ENDIF}
{$ENDIF}
  rppdfdriver, rptextdriver, Mask, rpmaskedit;


const
  METAPRINTPROGRESS_INTERVAL = 20;

type
  TRpGDIDriver = class;

  TFRpVCLProgress = class(TForm)
    BCancel: TButton;
    LProcessing: TLabel;
    LRecordCount: TLabel;
    LTitle: TLabel;
    LTittle: TLabel;
    BOK: TButton;
    GPrintRange: TGroupBox;
    EFrom: TRpMaskEdit;
    ETo: TRpMaskEdit;
    LTo: TLabel;
    LFrom: TLabel;
    RadioAll: TRadioButton;
    RadioRange: TRadioButton;
    GBitmap: TGroupBox;
    LHorzRes: TLabel;
    LVertRes: TLabel;
    EHorzRes: TRpMaskEdit;
    EVertRes: TRpMaskEdit;
    CheckMono: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    allpages, collate: boolean;
    frompage, topage, copies: integer;
    devicefonts: boolean;
    printerindex: TRpPrinterSelect;
    dook: boolean;
    MetaBitmap: TBitmap;
    bitresx, bitresy: integer;
    bitmono: boolean;
    procedure AppIdle(Sender: TObject; var done: boolean);
    procedure AppIdleBitmap(Sender: TObject; var done: boolean);
{$IFNDEF FORWEBAX}
    procedure AppIdleReport(Sender: TObject; var done: boolean);
    procedure RepProgress(Sender: TRpBaseReport; var docancel: boolean);
    procedure AppIdlePrintPDF(Sender: TObject; var done: boolean);
    procedure AppIdlePrintRange(Sender: TObject; var done: boolean);
    procedure AppIdlePrintRangeText(Sender: TObject; var done: boolean);
{$ENDIF}
  public
    { Public declarations }
    noenddoc: boolean;
    pdfcompressed: boolean;
    cancelled: boolean;
    oldonidle: TIdleEvent;
    tittle: string;
    filename: string;
    errorproces: boolean;
    ErrorMessage: String;
    usepdfdriver: boolean;
    metafile: TRpMetafileReport;
{$IFNDEF FORWEBAX}
    report: TRpReport;
{$ENDIF}
    nobegindoc: boolean;
  end;

  TRpGDIDriver = class(TRpPrintDriver)
  private
    FReport: TRpMetafileReport;
    BackColor: integer;
    intdpix, intdpiy: integer;
    metacanvas: TMetafilecanvas;
    meta: TMetafile;
    pagecliprec: TRect;
    onlycalc: boolean;
    selectedprinter: TRpPrinterSelect;
    DrawerBefore, DrawerAfter: boolean;
    npdfdriver: TRpPDFDriver;
    realdpix, realdpiy: integer;

    procedure PrintObject(Canvas: TCanvas; page: TRpMetafilePage;
      obj: TRpMetaObject; dpix, dpiy: integer; toprinter: boolean;
      pagemargins: TRect; devicefonts: boolean; offset: TPoint;
      selected: boolean);
    procedure SendAfterPrintOperations;
    function DoNewPage(aorientation: TRpOrientation;
      apagesizeqt: TPageSizeQt): boolean;
    procedure UpdateBitmapSize(report: TRpMetafileReport;
      apage: TRpMetafilePage);
  public
    offset: TPoint;
    showpagemargins: boolean;
    // CurrentPageSize:Tpoint;
    bitmap: TBitmap;
    dpi: integer;
    toprinter: boolean;
    scale: double;
    pagemargins: TRect;
    drawclippingregion: boolean;
    oldpagesize, pagesize: TGDIPageSize;
    oldorientation: TPrinterOrientation;
    orientationset: boolean;
    devicefonts: boolean;
    neverdevicefonts: boolean;
    bitmapwidth, bitmapheight: integer;
    PreviewStyle: TRpPreviewStyle;
    clientwidth, clientheight: integer;
    FontDriver: TRpPrintDriver;
    noenddoc: boolean;
    procedure NewDocument(report: TRpMetafileReport; hardwarecopies: integer;
      hardwarecollate: boolean); override;
    procedure EndDocument; override;
    procedure AbortDocument; override;
    procedure NewPage(metafilepage: TRpMetafilePage); override;
    procedure EndPage; override;
    procedure DrawObject(page: TRpMetafilePage; obj: TRpMetaObject); override;
    procedure IntDrawObject(page: TRpMetafilePage; obj: TRpMetaObject;
      selected: boolean);
    procedure DrawChart(Series: TRpSeries; ametafile: TRpMetafileReport;
      posx, posy: integer; achart: TObject); override;
{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}
    procedure FilterImage(memstream: TMemoryStream); override;
{$ENDIF}
{$ENDIF}
{$IFNDEF FORWEBAX}
{$IFDEF USETEECHART}
    procedure DoDrawChart(adriver: TRpPrintDriver; Series: TRpSeries;
      page: TRpMetafilePage; aposx, aposy: integer; xchart: TObject);
    procedure AddFunctionToChart(achart: TChart; functionName: string;
      functionParams: string; serieCaption: string);
{$ENDIF}
{$ENDIF}
    procedure DrawPage(apage: TRpMetafilePage); override;
    function AllowCopies: boolean; override;
    function GetPageSize(var PageSizeQt: integer): TPoint; override;
    function SetPagesize(PageSizeQt: TPageSizeQt): TPoint; override;
    procedure TextExtent(atext: TRpTextObject; var extent: TPoint); override;
    procedure TextRectJustify(Canvas: TCanvas; ARect: TRect; Text: Widestring;
      Alignment: integer; Clipping: boolean; Wordbreak: boolean;
      Rotation: integer; RightToLeft: boolean; drawbackground: boolean;
      BackColor: TColor);
    procedure GraphicExtent(Stream: TMemoryStream; var extent: TPoint;
      dpi: integer); override;
    procedure SetOrientation(Orientation: TRpOrientation); override;
    procedure SelectPrinter(printerindex: TRpPrinterSelect); override;
    function SupportsCopies(maxcopies: integer): boolean; override;
    function SupportsCollation: boolean; override;
    constructor Create;
    destructor Destroy; override;
    function GetFontDriver: TRpPrintDriver; override;
  end;

function PrintMetafile(metafile: TRpMetafileReport; tittle: string;
  showprogress, allpages: boolean; frompage, topage, copies: integer;
  collate: boolean; devicefonts: boolean;
  printerindex: TRpPrinterSelect = pRpDefaultPrinter;
  nobegindoc: boolean = false): boolean;
function MetafileToBitmap(metafile: TRpMetafileReport; showprogress: boolean;
  Mono: boolean; resx: integer = 200; resy: integer = 100): TBitmap;
function AskBitmapProps(var HorzRes, VertRes: integer;
  var Mono: boolean): boolean;

{$IFNDEF FORWEBAX}
function CalcReportWidthProgress(report: TRpReport;
  noenddoc: boolean = false): boolean;
function CalcReportWidthProgressPDF(report: TRpReport;
  noenddoc: boolean = false): boolean;
function PrintReport(report: TRpReport; Caption: string; progress: boolean;
  allpages: boolean; frompage, topage, copies: integer;
  collate: boolean): boolean;
function ExportReportToPDF(report: TRpReport; Caption: string;
  progress: boolean; allpages: boolean; frompage, topage, copies: integer;
  showprintdialog: boolean; filename: string; compressed: boolean;
  collate: boolean): boolean;
function ExportReportToPDFMetaStream(report: TRpReport; Caption: string;
  progress: boolean; allpages: boolean; frompage, topage, copies: integer;
  showprintdialog: boolean; Stream: TStream; compressed: boolean;
  collate: boolean; metafile: boolean): boolean;
{$ENDIF}
function DoShowPrintDialog(var allpages: boolean;
  var frompage, topage, copies: integer; var collate: boolean;
  disablecopies: boolean = false): boolean;
function PrinterSelection(printerindex: TRpPrinterSelect;
  papersource, duplex: integer; var pconfig: TPrinterConfig): TPoint;
procedure PageSizeSelection(rpPageSize: TPageSizeQt);
procedure OrientationSelection(neworientation: TRpOrientation);

{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}
procedure ExFilterImage(memstream: TMemoryStream);
{$ENDIF}
{$ENDIF}

implementation

{$R *.dfm}

const
  AlignmentFlags_SingleLine = 64;
  AlignmentFlags_AlignHCenter = 4 { $4 };
  AlignmentFlags_AlignHJustify = 1024 { $400 };
  AlignmentFlags_AlignTop = 8 { $8 };
  AlignmentFlags_AlignBottom = 16 { $10 };
  AlignmentFlags_AlignVCenter = 32 { $20 };
  AlignmentFlags_AlignLeft = 1 { $1 };
  AlignmentFlags_AlignRight = 2 { $2 };

function EqualsPageSizeQt(a, b: TPageSizeQt): boolean;
begin
  Result := true;
  if (a.Indexqt <> b.Indexqt) then
  begin
    Result := false;
    exit;
  end;
  if (a.Custom <> b.Custom) then
  begin
    Result := false;
    exit;
  end;
  if (a.CustomWidth <> b.CustomWidth) then
  begin
    Result := false;
    exit;
  end;
  if (a.CustomHeight <> b.CustomHeight) then
  begin
    Result := false;
    exit;
  end;
  if (a.papersource <> b.papersource) then
  begin
    Result := false;
    exit;
  end;
{$IFNDEF DOTNETD}
  if (a.ForcePaperName <> b.ForcePaperName) then
{$ENDIF}
{$IFDEF DOTNETD}
    if (String(a.ForcePaperName) <> String(b.ForcePaperName)) then
{$ENDIF}
    begin
      Result := false;
      exit;
    end;
  if (a.duplex <> b.duplex) then
  begin
    Result := false;
    exit;
  end;
end;

function TRpGDIDriver.DoNewPage(aorientation: TRpOrientation;
  apagesizeqt: TPageSizeQt): boolean;
begin
  Result := true;
  windows.EndPage(Printer.handle);
  SetOrientation(aorientation);
  SetPagesize(apagesizeqt);
  windows.StartPage(Printer.handle);
  Printer.Canvas.Refresh;
end;

function DoShowPrintDialog(var allpages: boolean;
  var frompage, topage, copies: integer; var collate: boolean;
  disablecopies: boolean = false): boolean;
var
  dia: TPrintDialog;
  diarange: TFRpVCLProgress;
begin
  Result := false;
  if disablecopies then
  begin
    diarange := TFRpVCLProgress.Create(Application);
    try
      diarange.BOK.Visible := true;
      diarange.GPrintRange.Visible := true;
      diarange.RadioAll.Checked := allpages;
      diarange.RadioRange.Checked := not allpages;
      diarange.ActiveControl := diarange.BOK;
      diarange.frompage := frompage;
      diarange.topage := topage;
      diarange.showmodal;
      if diarange.dook then
      begin
        frompage := diarange.frompage;
        topage := diarange.topage;
        allpages := diarange.RadioAll.Checked;
        Result := true;
      end
    finally
      diarange.free;
    end;
    exit;
  end;
  if (copies > 0) then
    SetPrinterCollation(collate);
  dia := TPrintDialog.Create(Application);
  try
    dia.Options := [poPageNums, poWarning, poPrintToFile];
    dia.MinPage := 1;
    dia.MaxPage := 65535;
    if copies = 0 then
    begin
      dia.copies := GetPrinterCopies;
      dia.collate := GetPrinterCollation;
    end
    else
    begin
      dia.copies := copies;
      dia.collate := collate;
    end;
    dia.frompage := frompage;
    dia.topage := topage;
    if dia.execute then
    begin
      allpages := false;
      collate := GetPrinterCollation;
      copies := GetPrinterCopies;
      frompage := dia.frompage;
      topage := dia.topage;
      Result := true;
    end;
  finally
    dia.free;
  end;
end;

constructor TRpGDIDriver.Create;
begin
  inherited Create;
  // By default 1:1 scale
  offset.X := 0;
  offset.Y := 0;
  dpi := Screen.PixelsPerInch;
  drawclippingregion := false;
  oldpagesize.PageIndex := -1;
  scale := 1;
end;

destructor TRpGDIDriver.Destroy;
begin
  if assigned(metacanvas) then
  begin
    metacanvas.free;
    metacanvas := nil;
  end;
  if assigned(meta) then
  begin
    meta.free;
    meta := nil;
  end;
  if assigned(bitmap) then
  begin
    bitmap.free;
    bitmap := nil;
  end;
  if assigned(npdfdriver) then
    npdfdriver.free;
  inherited Destroy;
end;

function TRpGDIDriver.SupportsCopies(maxcopies: integer): boolean;
begin
  Result := PrinterSupportsCopies(maxcopies);
end;

function TRpGDIDriver.SupportsCollation: boolean;
begin
  Result := PrinterSupportsCollation;
end;

procedure TRpGDIDriver.UpdateBitmapSize(report: TRpMetafileReport;
  apage: TRpMetafilePage);
var
  asize: TPoint;
  qtsize: integer;
  awidth, aheight: integer;
  rec: TRect;
  scale2: double;
  // aregion:HRGN;
  frompage: boolean;
begin
  // Offset is 0 in preview
  offset.X := 0;
  offset.Y := 0;
  // Sets Orientation
  BackColor := report.BackColor;
  frompage := false;
  if assigned(apage) then
    if apage.UpdatedPageSize then
      frompage := true;
  if not frompage then
  begin
    if drawclippingregion then
    begin
      SetOrientation(report.Orientation);
      // Gets pagesize
      asize := GetPageSize(qtsize);
      pagemargins := GetPageMarginsTWIPS;
      // CurrentPageSize:=asize;
    end
    else
    begin
      asize.X := report.CustomX;
      asize.Y := report.CustomY;
    end;
  end
  else
  begin
    if drawclippingregion then
    begin
      SetOrientation(apage.Orientation);
      pagemargins := GetPageMarginsTWIPS;
    end;
    asize.X := apage.PageSizeQt.PhysicWidth;
    asize.Y := apage.PageSizeQt.PhysicHeight;
  end;
  bitmapwidth := Round((asize.X / TWIPS_PER_INCHESS) * dpi);
  bitmapheight := Round((asize.Y / TWIPS_PER_INCHESS) * dpi);

  awidth := bitmapwidth;
  aheight := bitmapheight;

  if clientwidth > 0 then
  begin
    // Calculates the scale
    case PreviewStyle of
      spWide:
        begin
          // Adjust clientwidth to bitmap width
          scale := (clientwidth - GetSystemMetrics(SM_CYHSCROLL)) / bitmapwidth;
        end;
      spNormal:
        begin
          scale := 1.0;
        end;
      spEntirePage:
        begin
          // Adjust client to bitmap with an height
          scale := (clientwidth - 1) / bitmapwidth;
          scale2 := (clientheight - 1) / bitmapheight;
          if scale2 < scale then
            scale := scale2;
        end;
    end;
  end;
  if scale < 0.01 then
    scale := 0.01;
  if scale > 10 then
    scale := 10;
  if Not assigned(bitmap) then
  begin
    bitmap := TBitmap.Create;
{$IFNDEF DOTNETDBUGS}
    bitmap.PixelFormat := pf32bit;
    bitmap.HandleType := bmDIB;
{$ENDIF}
  end;
  (* end
    else
    begin
    if ((bitmap.Width<>bitmapwidth) or (bitmap.height<>bitmapheight)) then
    begin
    bitmap.free;
    bitmap:=nil;
    bitmap:=TBitmap.Create;
    {$IFNDEF DOTNETDBUGS}
    bitmap.PixelFormat:=pf32bit;
    bitmap.HandleType:=bmDIB;
    {$ENDIF}
    end;
    end;
  *)
  bitmap.Width := Round(awidth * scale);
  bitmap.Height := Round(aheight * scale);
  if bitmap.Width < 1 then
    bitmap.Width := 1;
  if bitmap.Height < 1 then
    bitmap.Height := 1;

  bitmap.Canvas.Brush.Style := bsSolid;
  bitmap.Canvas.Brush.Color := CLXColorToVCLColor(BackColor);
  rec.Top := 0;
  rec.Left := 0;
  rec.Right := bitmap.Width + 1;
  rec.Bottom := bitmap.Height + 1;
  bitmap.Canvas.FillRect(rec);
  // Define clipping region
  if drawclippingregion then
  begin
    rec.Left := Round((pagemargins.Left / TWIPS_PER_INCHESS) * dpi * scale);
    rec.Top := Round((pagemargins.Top / TWIPS_PER_INCHESS) * dpi * scale);
    rec.Right := Round((pagemargins.Right / TWIPS_PER_INCHESS) * dpi * scale);
    rec.Bottom := Round((pagemargins.Bottom / TWIPS_PER_INCHESS) * dpi * scale);
    pagecliprec := rec;
  end;
  { if (Not drawclippingregion) then
    begin
    aregion:=CreateRectRgn(rec.Left,rec.Top,rec.Right,rec.Bottom);
    SelectClipRgn(bitmap.Canvas.handle,aregion);
    end;
  }
end;

procedure TRpGDIDriver.NewDocument(report: TRpMetafileReport;
  hardwarecopies: integer; hardwarecollate: boolean);
var
  asize: TPoint;
  qtsize: integer;
  rpagesizeQt: TPageSizeQt;
begin
  FReport := report;
{$IFNDEF FORWEBAX}
{$IFDEF USETEECHART}
  report.OnDrawChart := Self.DoDrawChart;
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
  report.OnFilterImage := Self.FilterImage;
{$ENDIF}
{$ENDIF}
  DrawerBefore := report.OpenDrawerBefore;
  DrawerAfter := report.OpenDrawerAfter;
  if devicefonts then
  begin
    UpdatePrinterFontList;
  end;
  if toprinter then
  begin
    SetOrientation(report.Orientation);
    // Gets pagesize
    asize := GetPageSize(qtsize);
    pagemargins := GetPageMarginsTWIPS;
    if not noenddoc then
    begin
      SetPrinterCopies(hardwarecopies);
      SetPrinterCollation(hardwarecollate);
    end;

    if not noenddoc then
      if DrawerBefore then
        SendControlCodeToPrinter(GetPrinterRawOp(selectedprinter,
          rawopopendrawer));
    // Sets pagesize
    rpagesizeQt.papersource := report.papersource;
    SetForcePaperName(rpagesizeQt, report.ForcePaperName);
    rpagesizeQt.duplex := report.duplex;
    if report.pagesize < 0 then
    begin
      rpagesizeQt.Custom := true;
      rpagesizeQt.CustomWidth := report.CustomX;
      rpagesizeQt.CustomHeight := report.CustomY;
    end
    else
    begin
      rpagesizeQt.Indexqt := report.pagesize;
      rpagesizeQt.Custom := false;
    end;
    try
      SetPagesize(rpagesizeQt);
    except
      On E: Exception do
      begin
        rpgraphutilsvcl.RpMessageBox(E.Message);
      end;
    end;
    Printer.Title := report.Title;
    if Length(Printer.Title) < 1 then
    begin
      Printer.Title := SRpUntitled;
      if Length(Printer.Title) < 1 then
      begin
        Printer.Title := 'Untitled';
      end;
    end;
    Printer.BeginDoc;
    intdpix := GetDeviceCaps(Printer.Canvas.handle, LOGPIXELSX);
    // printer.XDPI;
    intdpiy := GetDeviceCaps(Printer.Canvas.handle, LOGPIXELSY);
    // printer.YDPI;
  end
  else
  begin
    UpdateBitmapSize(report, nil);
  end;
end;

procedure TRpGDIDriver.EndDocument;
begin
  if toprinter then
  begin
    if not noenddoc then
    begin
      Printer.EndDoc;
      if DrawerAfter then
        SendControlCodeToPrinter(GetPrinterRawOp(selectedprinter,
          rawopopendrawer));
      // Send Especial operations
      SendAfterPrintOperations;
    end;
  end
  else
  begin
    // Does nothing because the last bitmap can be usefull
  end;
  if oldpagesize.PageIndex <> -1 then
  begin
    SetCurrentPaper(oldpagesize);
    oldpagesize.PageIndex := -1;
  end;
  if orientationset then
  begin
    if Printer.printing then
      SetPrinterOrientation(oldorientation = poLandscape)
    else
      Printer.Orientation := oldorientation;
    orientationset := false;
  end;
end;

procedure TRpGDIDriver.AbortDocument;
begin
  if toprinter then
  begin
    Printer.Abort;
  end
  else
  begin
    if assigned(bitmap) then
      bitmap.free;
    bitmap := nil;
  end;
  if orientationset then
  begin
    SetPrinterOrientation(oldorientation = poLandscape);
    orientationset := false;
  end;
  if oldpagesize.PageIndex <> -1 then
  begin
    SetCurrentPaper(oldpagesize);
    oldpagesize.PageIndex := -1;
  end;
end;

procedure TRpGDIDriver.NewPage(metafilepage: TRpMetafilePage);
begin
  if toprinter then
  begin
    if metafilepage.UpdatedPageSize then
      DoNewPage(metafilepage.Orientation, metafilepage.PageSizeQt)
    else
      Printer.NewPage;
  end
  else
  begin
    UpdateBitmapSize(FReport, metafilepage);
  end;
end;

procedure TRpGDIDriver.EndPage;
var
  rec: TRect;
begin
  // If drawclippingregion then
  if not toprinter then
  begin
    if Not assigned(bitmap) then
      exit;
    rec := pagecliprec;
    if drawclippingregion then
    begin
      bitmap.Canvas.Pen.Style := psSolid;
      bitmap.Canvas.Pen.Color := clBlack;
      bitmap.Canvas.Brush.Style := bsclear;
      bitmap.Canvas.rectangle(rec.Left, rec.Top, rec.Right, rec.Bottom);
    end
  end;
end;

procedure TRpGDIDriver.TextExtent(atext: TRpTextObject; var extent: TPoint);
var
  Canvas: TCanvas;
  dpix, dpiy: integer;
  aalign: Cardinal;
  aatext: Widestring;
  aansitext: string;
  arec: TRect;
  maxextent: TPoint;
begin
  if atext.FontRotation <> 0 then
    exit;
  // Justified text use pdf driver
  if (atext.Alignment AND AlignmentFlags_AlignHJustify) > 0 then
  // if true then
  begin
    if not assigned(npdfdriver) then
      npdfdriver := TRpPDFDriver.Create;
    atext.Type1Font := integer(poLinked);
    npdfdriver.TextExtent(atext, extent);
    exit;
  end;

  if atext.CutText then
  begin
    maxextent := extent;
  end;
  if (toprinter) then
  begin
    if not Printer.printing then
      Raise Exception.Create(SRpGDIDriverNotInit);
    dpix := intdpix;
    dpiy := intdpiy;
    Canvas := Printer.Canvas;
  end
  else
  begin
    if not assigned(bitmap) then
      Raise Exception.Create(SRpGDIDriverNotInit);
    if not assigned(metacanvas) then
    begin
      if assigned(meta) then
      begin
        meta.free;
        meta := nil;
      end;
      meta := TMetafile.Create;
      meta.Enhanced := true;
      meta.Width := bitmapwidth;
      meta.Height := bitmapheight;
      metacanvas := TMetafilecanvas.Create(meta, 0);
    end;
    Canvas := metacanvas;
    dpix := Screen.PixelsPerInch;
    dpiy := Screen.PixelsPerInch;
  end;
  Canvas.Font.Name := atext.WFontName;
  Canvas.Font.Style := CLXIntegerToFontStyle(atext.FontStyle);
  Canvas.Font.Size := atext.FontSize;
  Canvas.Font.Color := CLXColorToVCLColor(atext.FontColor);
  // Find device font
  if devicefonts then
    FindDeviceFont(Canvas.handle, Canvas.Font, FontSizeToStep(Canvas.Font.Size,
      atext.PrintStep));
  aalign := DT_NOPREFIX;
  if (atext.Alignment AND AlignmentFlags_AlignHCenter) > 0 then
    aalign := aalign or DT_CENTER;
  if (atext.Alignment AND AlignmentFlags_AlignVCenter) > 0 then
    aalign := aalign or DT_VCENTER;
  if (atext.Alignment AND AlignmentFlags_AlignTop) > 0 then
    aalign := aalign or DT_TOP;
  if (atext.Alignment AND AlignmentFlags_AlignBottom) > 0 then
    aalign := aalign or DT_BOTTOM;
  if (atext.Alignment AND AlignmentFlags_SingleLine) > 0 then
    aalign := aalign or DT_SINGLELINE;
  if (atext.Alignment AND AlignmentFlags_AlignLeft) > 0 then
    aalign := aalign or DT_LEFT;
  if (atext.Alignment AND AlignmentFlags_AlignRight) > 0 then
    aalign := aalign or DT_RIGHT;
  if atext.WordWrap then
    aalign := aalign or DT_WORDBREAK;
  if Not atext.CutText then
    aalign := aalign or DT_NOCLIP;
  if atext.RightToLeft then
    aalign := aalign or DT_RTLREADING;
  aatext := atext.Text;
  aansitext := aatext;
  arec.Left := 0;
  arec.Top := 0;
  arec.Bottom := 0;
  arec.Right := Round(extent.X * dpix / TWIPS_PER_INCHESS);
  // calculates the text extent
  // Win9x does not support drawing WideChars
  DrawTextW(Canvas.handle, PWideChar(aatext), Length(aatext), arec,
    aalign or DT_CALCRECT);
  // Transformates to twips
  extent.X := Round(arec.Right / dpix * TWIPS_PER_INCHESS);
  extent.Y := Round(arec.Bottom / dpiy * TWIPS_PER_INCHESS);
  if (atext.CutText) then
  begin
    if maxextent.Y < extent.Y then
      extent.Y := maxextent.Y;
  end;

end;

procedure TRpGDIDriver.PrintObject(Canvas: TCanvas; page: TRpMetafilePage;
  obj: TRpMetaObject; dpix, dpiy: integer; toprinter: boolean;
  pagemargins: TRect; devicefonts: boolean; offset: TPoint; selected: boolean);
var
  posx, posy: integer;
  rec, recsrc: TRect;
  X, Y, W, H, S: integer;
  Width, Height: integer;
  Stream: TMemoryStream;
  bitmap: TBitmap;
  aalign: Cardinal;
  abrushstyle: integer;
  atext: Widestring;
  aansitext: string;
  arec: TRect;
  calcrect: boolean;
  alvbottom, alvcenter: boolean;
  rotrad, fsize: double;
  oldrgn: HRGN;
  newrgn: HRGN;
  aresult: integer;
{$IFNDEF DOTNETD}
  jpegimage: TJPegImage;
{$ENDIF}
  bitmapwidth, bitmapheight: integer;
  astring: Widestring;
  drawbackground: boolean;
  oldhandle: THandle;
  format: string;
  newrec: TRect;
{$IFDEF DELPHI2009UP}
  npng: TPngImage;
{$ENDIF}
  propx, propy: double;
begin
  // Switch to device points
  oldhandle := 0;
  if toprinter then
  begin
    // If printer then must be displaced
    posx := Round((obj.Left - pagemargins.Left + offset.X) * dpix /
      TWIPS_PER_INCHESS);
    posy := Round((obj.Top - pagemargins.Top + offset.Y) * dpiy /
      TWIPS_PER_INCHESS);
  end
  else
  begin
    posx := Round(obj.Left * dpix / TWIPS_PER_INCHESS);
    posy := Round(obj.Top * dpiy / TWIPS_PER_INCHESS);
  end;
  case obj.Metatype of
    rpMetaText:
      begin
        Canvas.Font.Name := page.GetWFontName(obj);
        Canvas.Font.Color := CLXColorToVCLColor(obj.FontColor);
        Canvas.Font.Style := CLXIntegerToFontStyle(obj.FontStyle);
        Canvas.Font.Size := obj.FontSize;
        try
          if obj.FontRotation <> 0 then
          begin
            oldhandle := Canvas.Font.handle;
            // Find rotated font
            Canvas.Font.handle := FindRotatedFont(Canvas.handle, Canvas.Font,
              obj.FontRotation);
            // Moves the print position
            rotrad := obj.FontRotation / 10 * (2 * PI / 360);
            fsize := obj.FontSize / 72 * dpiy;
            posx := posx - Round(fsize * sin(rotrad));
            posy := posy + Round(fsize - fsize * cos(rotrad));
          end
          else
          begin
            // Find device font
            if devicefonts then
              FindDeviceFont(Canvas.handle, Canvas.Font,
                FontSizeToStep(Canvas.Font.Size, obj.PrintStep));
          end;
          // Justified text use pdf driver
          if (obj.Alignment AND AlignmentFlags_AlignHJustify) > 0 then
          // if true then
          begin
            astring := page.GetText(obj);
            rec.Left := Round(posx / dpix * TWIPS_PER_INCHESS);
            rec.Top := Round(posy / dpix * TWIPS_PER_INCHESS);
            rec.Right := rec.Left + obj.Width;
            rec.Bottom := rec.Top + obj.Height;
            if ((obj.Transparent) and (not selected)) then
            begin
              SetBkMode(Canvas.handle, Transparent);
              drawbackground := false;
            end
            else
            begin
              SetBkMode(Canvas.handle, OPAQUE);
              drawbackground := true;
            end;
            if selected then
            begin
              Canvas.Brush.Color := clHighlight;
              Canvas.Font.Color := clHighlightText;
            end;
            TextRectJustify(Canvas, rec, astring, obj.Alignment, obj.CutText,
              obj.WordWrap, obj.FontRotation, obj.RightToLeft, drawbackground,
              CLXColorToVCLColor(obj.BackColor));
          end
          else
          begin
            aalign := DT_NOPREFIX;
            if (obj.Alignment AND AlignmentFlags_AlignHCenter) > 0 then
              aalign := aalign or DT_CENTER;
            // Vertical alignment is not implemented by Windows GDI
            // on multiple lines, so it's calculated manually
            // if (obj.AlignMent AND AlignmentFlags_AlignVCenter)>0 then
            // aalign:=aalign or DT_VCENTER;
            // if (obj.AlignMent AND AlignmentFlags_AlignTop)>0 then
            // aalign:=aalign or DT_TOP;
            // if (obj.AlignMent AND AlignmentFlags_AlignBottom)>0 then
            // aalign:=aalign or DT_BOTTOM;
            if (obj.Alignment AND AlignmentFlags_SingleLine) > 0 then
              aalign := aalign or DT_SINGLELINE;
            if (obj.Alignment AND AlignmentFlags_AlignLeft) > 0 then
              aalign := aalign or DT_LEFT;
            if (obj.Alignment AND AlignmentFlags_AlignRight) > 0 then
              aalign := aalign or DT_RIGHT;
            if obj.WordWrap then
              aalign := aalign or DT_WORDBREAK;
            if Not obj.CutText then
              aalign := aalign or DT_NOCLIP;
            if obj.RightToLeft then
              aalign := aalign or DT_RTLREADING;
            rec.Left := posx;
            rec.Top := posy;
            rec.Right := posx + Ceil(obj.Width * dpix / TWIPS_PER_INCHESS);
            rec.Bottom := posy + Ceil(obj.Height * dpiy / TWIPS_PER_INCHESS);
            // rec.Right:=posx+Round(obj.Width*dpix/TWIPS_PER_INCHESS);
            // rec.Bottom:=posy+Round(obj.Height*dpiy/TWIPS_PER_INCHESS);
            atext := page.GetText(obj);
            aansitext := atext;
            alvbottom := (obj.Alignment AND AlignmentFlags_AlignBottom) > 0;
            alvcenter := (obj.Alignment AND AlignmentFlags_AlignVCenter) > 0;

            calcrect := (not obj.Transparent) or alvbottom or alvcenter;
            arec := rec;
            if calcrect then
            begin
              // First calculates the text extent
              // Win9x does not support drawing WideChars
              DrawTextW(Canvas.handle, PWideChar(atext), Length(atext), arec,
                aalign or DT_CALCRECT);
              Canvas.Brush.Style := bsSolid;
              Canvas.Brush.Color := CLXColorToVCLColor(obj.BackColor);
            end
            else
              Canvas.Brush.Style := bsclear;
            if alvbottom then
            begin
              rec.Top := rec.Top + (rec.Bottom - arec.Bottom)
            end;
            if alvcenter then
            begin
              rec.Top := rec.Top + ((rec.Bottom - arec.Bottom) div 2);
            end;
            if (obj.Transparent and (not selected)) then
              SetBkMode(Canvas.handle, Transparent)
            else
            begin
              // This does not work on XP?
              SetBkMode(Canvas.handle, OPAQUE);
              // SetBkColor(Canvas.Handle,Canvas.Brush.Color);
              // SelectObject(Canvas.Handle,Canvas.Font.Handle);
            end;
            if selected then
            begin
              Canvas.Brush.Color := clHighlight;
              Canvas.Font.Color := clHighlightText;
            end;
{$IFNDEF DOTNETD}
            DrawTextW(Canvas.handle, PWideChar(atext), Length(atext),
              rec, aalign);
          end;
{$ENDIF}
        finally
          if (obj.FontRotation <> 0) then
          begin
            Canvas.Font.handle := oldhandle;
          end;
        end;
      end;
    rpMetaDraw:
      begin
        Width := Round(obj.Width * dpix / TWIPS_PER_INCHESS);
        Height := Round(obj.Height * dpiy / TWIPS_PER_INCHESS);
        abrushstyle := obj.BrushStyle;
        if obj.BrushStyle > integer(bsDiagCross) then
          abrushstyle := integer(bsDiagCross);
        Canvas.Pen.Color := CLXColorToVCLColor(obj.Pencolor);
        Canvas.Pen.Style := TPenStyle(obj.PenStyle);
        Canvas.Brush.Color := CLXColorToVCLColor(obj.BrushColor);
        Canvas.Brush.Style := TBrushStyle(abrushstyle);
        Canvas.Pen.Width := Round(dpix * obj.PenWidth / TWIPS_PER_INCHESS);
        X := Canvas.Pen.Width div 2;
        Y := X;
        W := Width - Canvas.Pen.Width + 1;
        H := Height - Canvas.Pen.Width + 1;
        if Canvas.Pen.Width = 0 then
        begin
          Dec(W);
          Dec(H);
        end;
        if W < H then
          S := W
        else
          S := H;
        if TRpShapeType(obj.DrawStyle) in [rpsSquare, rpsRoundSquare, rpsCircle]
        then
        begin
          Inc(X, (W - S) div 2);
          Inc(Y, (H - S) div 2);
          W := S;
          H := S;
        end;
        case TRpShapeType(obj.DrawStyle) of
          rpsRectangle, rpsSquare:
            if (Canvas.Pen.Width = 0) then
            begin
              newrec.Left := X + posx;
              newrec.Top := Y + posy;
              newrec.Right := X + posx + W;
              newrec.Bottom := Y + posy + H;
              Canvas.FillRect(newrec);
            end
            else
            begin
              Canvas.rectangle(X + posx, Y + posy, X + posx + W, Y + posy + H);
            end;
          rpsRoundRect, rpsRoundSquare:
            Canvas.RoundRect(X + posx, Y + posy, X + posx + W, Y + posy + H,
              S div 4, S div 4);
          rpsCircle, rpsEllipse:
            Canvas.Ellipse(X + posx, Y + posy, X + posx + W, Y + posy + H);
          rpsHorzLine:
            begin
              Canvas.MoveTo(X + posx, Y + posy);
              Canvas.LineTo(X + posx + W, Y + posy);
            end;
          rpsVertLine:
            begin
              Canvas.MoveTo(X + posx, Y + posy);
              Canvas.LineTo(X + posx, Y + posy + H);
            end;
          rpsOblique1:
            begin
              Canvas.MoveTo(X + posx, Y + posy);
              Canvas.LineTo(X + posx + W, Y + posy + H);
            end;
          rpsOblique2:
            begin
              Canvas.MoveTo(X + posx, Y + posy + H);
              Canvas.LineTo(X + posx + W, Y + posy);
            end;
        end;
      end;
    rpMetaImage:
      begin
        if (Not(obj.PreviewOnly and toprinter)) then
        begin
          Width := Round(obj.Width * dpix / TWIPS_PER_INCHESS);
          Height := Round(obj.Height * dpiy / TWIPS_PER_INCHESS);
          rec.Top := posy;
          rec.Left := posx;
          rec.Bottom := rec.Top + Height - 1;
          rec.Right := rec.Left + Width - 1;

          Stream := page.GetStream(obj);
          bitmap := TBitmap.Create;
          try
{$IFNDEF DOTNETDBUGS}
            bitmap.PixelFormat := pf32bit;
            bitmap.HandleType := bmDIB;
{$ENDIF}
            format := '';
            GetJPegInfo(Stream, bitmapwidth, bitmapheight, format);
            if (format = 'JPEG') then
            begin
{$IFNDEF DOTNETD}
              jpegimage := TJPegImage.Create;
              try
                jpegimage.LoadFromStream(Stream);
                bitmap.Assign(jpegimage);
              finally
                jpegimage.free;
              end;
{$ENDIF}
{$IFDEF DOTNETD}
              bitmap.LoadFromStream(Stream);
{$ENDIF}
            end
            else
              // Looks if it's a jpeg image
{$IFDEF DELPHI2009UP}
              if (format = 'PNG') then
              begin
                npng := TPngImage.Create;
                npng.LoadFromStream(Stream);
                bitmap.Assign(npng);
                npng.free;
              end
              else
{$ENDIF}
                if (format = 'BMP') then
                  bitmap.LoadFromStream(Stream)
                else
                begin
                  FilterImage(Stream);
                  jpegimage := TJPegImage.Create;
                  try
                    jpegimage.LoadFromStream(Stream);
                    bitmap.Assign(jpegimage);
                  finally
                    jpegimage.free;
                  end;
                end;
            // Copy mode does not work for StretDIBBits
            // Canvas.CopyMode:=CLXCopyModeToCopyMode(obj.CopyMode);

            case TRpImageDrawStyle(obj.DrawImageStyle) of
              rpDrawFull:
                begin
                  rec.Bottom := rec.Top +
                    Round(bitmap.Height / obj.dpires * dpiy) - 1;
                  rec.Right := rec.Left +
                    Round(bitmap.Width / obj.dpires * dpix) - 1;
                  recsrc.Left := 0;
                  recsrc.Top := 0;
                  recsrc.Right := bitmap.Width - 1;
                  recsrc.Bottom := bitmap.Height - 1;
                  DrawBitmap(Canvas, bitmap, rec, recsrc);
                end;
              rpDrawStretch:
                begin
                  recsrc.Left := 0;
                  recsrc.Top := 0;
                  recsrc.Right := bitmap.Width - 1;
                  recsrc.Bottom := bitmap.Height - 1;
                  DrawBitmap(Canvas, bitmap, rec, recsrc);
                end;
              rpDrawCrop:
                begin
                  // recsrc.Left:=0;
                  // recsrc.Top:=0;
                  // recsrc.Right:=rec.Right-rec.Left;
                  // recsrc.Bottom:=rec.Bottom-rec.Top;
                  // DrawBitmap(Canvas,bitmap,rec,recsrc);
                  recsrc.Left := 0;
                  recsrc.Top := 0;
                  recsrc.Right := bitmap.Width - 1;
                  recsrc.Bottom := bitmap.Height - 1;
                  propx := (rec.Right - rec.Left) / bitmap.Width;
                  propy := (rec.Bottom - rec.Top) / bitmap.Height;
                  if (propy > propx) then
                  begin
                    H := Round((rec.Right - rec.Left) * propx / propy);
                    rec.Top := rec.Top + ((rec.Bottom - rec.Top) - H) div 2;
                    rec.Bottom := rec.Top + H;
                  end
                  else
                  begin
                    W := Round((rec.Right - rec.Left) * propy / propx);
                    rec.Left := rec.Left + ((rec.Right - rec.Left) - W) div 2;
                    rec.Right := rec.Left + W;
                  end;
                  DrawBitmap(Canvas, bitmap, rec, recsrc);

                end;
              rpDrawTile, rpDrawTiledpi:
                begin
                  // Set clip region
                  oldrgn := CreateRectRgn(0, 0, 2, 2);
                  aresult := GetClipRgn(Canvas.handle, oldrgn);
                  newrgn := CreateRectRgn(rec.Left, rec.Top, rec.Right,
                    rec.Bottom);
                  SelectClipRgn(Canvas.handle, newrgn);
                  if TRpImageDrawStyle(obj.DrawImageStyle) = rpDrawTile then
                    DrawBitmapMosaicSlow(Canvas, rec, bitmap, 0)
                  else
                    DrawBitmapMosaicSlow(Canvas, rec, bitmap, obj.dpires);
                  if aresult = 0 then
                    SelectClipRgn(Canvas.handle, 0)
                  else
                    SelectClipRgn(Canvas.handle, oldrgn);
                end;
            end;
          finally
            bitmap.free;
          end;
        end;
      end;
  end;
end;

procedure TRpGDIDriver.TextRectJustify(Canvas: TCanvas; ARect: TRect;
  Text: Widestring; Alignment: integer; Clipping: boolean; Wordbreak: boolean;
  Rotation: integer; RightToLeft: boolean; drawbackground: boolean;
  BackColor: TColor);
var
  recsize: TRect;
  i, index: integer;
  posx, posy, currpos, alinedif: integer;
  singleline: boolean;
  astring: Widestring;
  alinesize: integer;
  lwords: TRpWideStrings;
  lwidths: TStringList;
  arec, arec2: TRect;
  aword: Widestring;
  nposx, nposy: integer;
  aatext: Widestring;
  aansitext: string;
  aalign: Cardinal;
  aintdpix, aintdpiy: integer;
  lastword: boolean;
begin
  try
    if drawbackground then
    begin
      Canvas.Pen.Color := BackColor;
      Canvas.Brush.Color := BackColor;
    end;
    singleline := (Alignment AND AlignmentFlags_SingleLine) > 0;
    if singleline then
      Wordbreak := false;
    if toprinter then
    begin
      if intdpix = 0 then
      begin
        intdpix := GetDeviceCaps(Printer.Canvas.handle, LOGPIXELSX);
        // printer.XDPI;
        intdpiy := GetDeviceCaps(Printer.Canvas.handle, LOGPIXELSY);
        // printer.YDPI;
      end;
      aintdpix := intdpix;
      aintdpiy := intdpiy;
    end
    else
    begin
      aintdpix := dpi;
      aintdpiy := dpi;
    end;
    // Calculates text extent and apply alignment
    recsize := ARect;
    if not assigned(npdfdriver) then
      npdfdriver := TRpPDFDriver.Create;
    npdfdriver.PDFFile.Canvas.Font.Size := Canvas.Font.Size;
    npdfdriver.PDFFile.Canvas.Font.WFontName := Canvas.Font.Name;
    npdfdriver.PDFFile.Canvas.Font.Name := poLinked;
    npdfdriver.PDFFile.Canvas.Font.Color := Canvas.Font.Color;
    npdfdriver.PDFFile.Canvas.Font.Italic := fsItalic in Canvas.Font.Style;
    npdfdriver.PDFFile.Canvas.Font.Bold := fsBold in Canvas.Font.Style;

    npdfdriver.PDFFile.Canvas.TextExtent(Text, recsize, Wordbreak, singleline);
    // Align bottom or center
    posy := ARect.Top;
    if (Alignment AND AlignmentFlags_AlignBottom) > 0 then
    begin
      posy := ARect.Bottom - recsize.Bottom;
    end;
    if (Alignment AND AlignmentFlags_AlignVCenter) > 0 then
    begin
      posy := ARect.Top + (((ARect.Bottom - ARect.Top) - recsize.Bottom) div 2);
    end;

    for i := 0 to npdfdriver.PDFFile.Canvas.LineInfoCount - 1 do
    begin
      posx := ARect.Left;
      // Aligns horz.
      if ((Alignment AND AlignmentFlags_AlignRight) > 0) then
      begin
        // recsize.right contains the width of the full text
        posx := ARect.Right - npdfdriver.PDFFile.Canvas.LineInfo[i].Width;
      end;
      // Aligns horz.
      if (Alignment AND AlignmentFlags_AlignHCenter) > 0 then
      begin
        posx := ARect.Left +
          (((ARect.Right - ARect.Left) - npdfdriver.PDFFile.Canvas.LineInfo[i]
          .Width) div 2);
      end;
      astring := Copy(Text, npdfdriver.PDFFile.Canvas.LineInfo[i].Position,
        npdfdriver.PDFFile.Canvas.LineInfo[i].Size);
      if (((Alignment AND AlignmentFlags_AlignHJustify) > 0) AND
        (NOT npdfdriver.PDFFile.Canvas.LineInfo[i].LastLine)) then
      begin
        // Calculate the sizes of the words, then
        // share space between words
        lwords := TRpWideStrings.Create;
        try
          aword := '';
          index := 1;
          while index <= Length(astring) do
          begin
            if astring[index] <> ' ' then
            begin
              aword := aword + astring[index];
            end
            else
            begin
              if Length(aword) > 0 then
                lwords.Add(aword);
              aword := '';
            end;
            Inc(index);
          end;
          if Length(aword) > 0 then
            lwords.Add(aword);
          // Calculate all words size
          alinesize := 0;
          lwidths := TStringList.Create;
          try
            for index := 0 to lwords.Count - 1 do
            begin
              arec := ARect;
              npdfdriver.PDFFile.Canvas.TextExtent(lwords.Strings[index], arec,
                false, true);
              if RightToLeft then
                lwidths.Add(IntToStr(-(arec.Right - arec.Left)))
              else
                lwidths.Add(IntToStr(arec.Right - arec.Left));
              alinesize := alinesize + arec.Right - arec.Left;
            end;
            alinedif := ARect.Right - ARect.Left - alinesize;
            if alinedif > 0 then
            begin
              if lwords.Count > 1 then
                alinedif := alinedif div (lwords.Count - 1);
              if RightToLeft then
              begin
                currpos := ARect.Right;
                alinedif := -alinedif;
              end
              else
                currpos := posx;
              for index := 0 to lwords.Count - 1 do
              begin
                nposx := currpos;
                nposy := posy + npdfdriver.PDFFile.Canvas.LineInfo[i].TopPos;
                nposx := Round(nposx * aintdpix / 1440);
                nposy := Round(nposy * aintdpiy / 1440);
                arec2.Left := nposx;
                arec2.Top := nposy;
                arec2.Bottom := arec.Top +
                  Round(npdfdriver.PDFFile.Canvas.LineInfo[i].Height *
                  aintdpiy / 1440);
                arec2.Right := Round(ARect.Right * aintdpix / 1440);
                aalign := DT_NOPREFIX or DT_NOCLIP;
                lastword := ((index = lwords.Count - 1) AND (lwords.Count > 1));
                if lastword then
                  aalign := aalign OR DT_RIGHT
                else
                  aalign := aalign OR DT_LEFT;
                aatext := lwords.Strings[index];
                DrawTextW(Canvas.handle, PWideChar(aatext), Length(aatext),
                  arec2, aalign);
                // TextOutW(Canvas.Handle,nposx,nposy,PWideChar(lwords.strings[index]),
                // Length(lwords.strings[index]));
                // TextOut(currpos,PosY+npdfdriver.pdffile.Canvas.LineInfo[i].TopPos,lwords.strings[index],
                // npdfdriver.pdffile.Canvas.LineInfo[i].Width,Rotation,RightToLeft);
                currpos := currpos + StrToInt(lwidths.Strings[index]) +
                  alinedif;
                if (drawbackground) then
                begin
                  if lastword then
                    aalign := (aalign AND (NOT DT_RIGHT)) OR DT_LEFT;
                  DrawTextW(Canvas.handle, PWideChar(aatext), Length(aatext),
                    arec2, aalign or DT_CALCRECT);
                  arec2.Top := nposy;
                  arec2.Bottom := nposy +
                    Round(npdfdriver.PDFFile.Canvas.LineInfo[i].Height *
                    aintdpiy / 1440);
                  if (lastword) then
                  begin
                    arec2.Left := nposx - 1;
                    arec2.Right := Round(ARect.Right * aintdpix / 1440) -
                      (arec2.Right - arec2.Left) + 1;
                  end
                  else
                  begin
                    arec2.Left := arec2.Right - 1;
                    arec2.Right := Round(currpos * aintdpix / 1440) + 1;
                  end;
                  Canvas.rectangle(arec2.Left, arec2.Top, arec2.Right,
                    arec2.Bottom);
                end;
              end;
            end;
          finally
            lwidths.free;
          end;
        finally
          lwords.free;
        end;
      end
      else
      begin
        aalign := DT_NOPREFIX or DT_NOCLIP or DT_LEFT;
        nposx := posx;
        nposy := posy + npdfdriver.PDFFile.Canvas.LineInfo[i].TopPos;
        nposx := Round(nposx * aintdpix / 1440);
        nposy := Round(nposy * aintdpiy / 1440);
        arec2.Left := nposx;
        arec2.Top := nposy;
        arec2.Bottom := arec.Bottom + 100;
        arec2.Right := Round(ARect.Right * aintdpix / 1440);
        DrawTextW(Canvas.handle, PWideChar(astring), Length(astring),
          arec2, aalign);
        // TextOutW(Canvas.Handle,nposx,nposy,PWideChar(astring),
        // Length(astring))
      end;
      // TextOut(PosX,PosY+npdfdriver.pdffile.Canvas.LineInfo[i].TopPos,astring,npdfdriver.pdffile.Canvas.LineInfo[i].Width,Rotation,RightToLeft);
    end;
  finally
  end;
end;

procedure TRpGDIDriver.DrawPage(apage: TRpMetafilePage);
var
  j: integer;
  rec: TRect;
  dpix, dpiy: integer;
  selected: boolean;
  metadpix, metadpiy: integer;
  regx: TRegistry;
begin
  if toprinter then
  begin
    for j := 0 to apage.ObjectCount - 1 do
    begin
      IntDrawObject(apage, apage.Objects[j], false);
    end;
  end
  else
  begin
    UpdateBitmapSize(FReport, apage);
    if assigned(metacanvas) then
    begin
      metacanvas.free;
      metacanvas := nil;
    end;
    if assigned(meta) then
    begin
      meta.free;
      meta := nil;
    end;
    meta := TMetafile.Create;
    try
      meta.Enhanced := true;
      meta.Width := bitmapwidth;
      meta.Height := bitmapheight;

      metacanvas := TMetafilecanvas.Create(meta, 0);
      try
        metadpix := GetDeviceCaps(metacanvas.handle, LOGPIXELSX);
        metadpiy := GetDeviceCaps(metacanvas.handle, LOGPIXELSY);
        if (realdpix = 0) then
        begin
          regx := TRegistry.Create;
          regx.RootKey := HKEY_CURRENT_USER;
          if (regx.KeyExists('Control Panel\Desktop\WindowMetrics')) then
          begin
            regx.OpenKey('Control Panel\Desktop\WindowMetrics', false);
            if (regx.ValueExists('AppliedDPI')) then
            begin
              realdpix := regx.ReadInteger('AppliedDPI');
              realdpiy := realdpix;
            end
            else
            begin
              realdpix := metadpix;
              realdpiy := metadpiy;
            end
          end
          else
          begin
            realdpix := metadpix;
            realdpiy := metadpiy;
          end
        end;
        for j := 0 to apage.ObjectCount - 1 do
        begin
          selected := FReport.IsFound(apage, j);
          IntDrawObject(apage, apage.Objects[j], selected);
        end;
        // Draw page margins
        if (showpagemargins) then
        begin
          rec := rpvgraphutils.GetPageMarginsTWIPS;
          // transform to dpi device
          dpix := Screen.PixelsPerInch;
          dpiy := Screen.PixelsPerInch;

          rec.Left := Round(rec.Left * dpix / TWIPS_PER_INCHESS);
          rec.Top := Round(rec.Top * dpiy / TWIPS_PER_INCHESS);
          rec.Right := Round(rec.Right * dpix / TWIPS_PER_INCHESS);
          rec.Bottom := Round(rec.Bottom * dpiy / TWIPS_PER_INCHESS);
          metacanvas.Brush.Style := bsclear;
          metacanvas.Pen.Color := clBlack;
          metacanvas.Pen.Style := psSolid;

          metacanvas.rectangle(rec);
        end;
      finally
        metacanvas.free;
        metacanvas := nil;
      end;
      // Draws the metafile scaled
      if Round(scale * 1000) = 1000 then
      begin
        bitmap.Canvas.Draw(0, 0, meta);
      end
      else
      begin
        rec.Top := 0;
        rec.Left := 0;
        rec.Right := Round(bitmap.Width * realdpix / metadpix) - 1;
        rec.Bottom := Round(bitmap.Height * realdpix / metadpix) - 1;
        bitmap.Canvas.StretchDraw(rec, meta);
      end;
    finally
      meta.free;
      meta := nil;
    end;
  end;
end;

procedure TRpGDIDriver.DrawObject(page: TRpMetafilePage; obj: TRpMetaObject);
begin
  IntDrawObject(page, obj, false);
end;

procedure TRpGDIDriver.IntDrawObject(page: TRpMetafilePage; obj: TRpMetaObject;
  selected: boolean);
var
  dpix, dpiy: integer;
  Canvas: TCanvas;
begin
  if onlycalc then
    exit;
  if (toprinter) then
  begin
    if not Printer.printing then
      Raise Exception.Create(SRpGDIDriverNotInit);
    dpix := intdpix;
    dpiy := intdpiy;
    Canvas := Printer.Canvas;
  end
  else
  begin
    if not assigned(bitmap) then
      Raise Exception.Create(SRpGDIDriverNotInit);
    if not assigned(metacanvas) then
      Raise Exception.Create(SRpGDIDriverNotInit);
    Canvas := metacanvas;
    dpix := Screen.PixelsPerInch;
    dpiy := Screen.PixelsPerInch;
  end;
  PrintObject(Canvas, page, obj, dpix, dpiy, toprinter, pagemargins,
    devicefonts, offset, selected);
end;

function TRpGDIDriver.AllowCopies: boolean;
begin
  Result := false;
end;

function TRpGDIDriver.GetPageSize(var PageSizeQt: integer): TPoint;
var
  gdisize: TGDIPageSize;
  qtsize: TPageSizeQt;
  asize: TPoint;
begin
  gdisize := GetCurrentPaper;
  qtsize := GDIPageSizeToQtPageSize(gdisize);
  PageSizeQt := qtsize.Indexqt;
  asize := GetPhysicPageSizeTwips;
  { if ((asize.x<1) or (asize.y<1)) then
    begin
    gdisize.Width:=Round(gdisize.Width/100/CMS_PER_INCHESS*TWIPS_PER_INCHESS);
    gdisize.Height:=Round(gdisize.Height/100/CMS_PER_INCHESS*TWIPS_PER_INCHESS);

    if Printer.Orientation=poLandscape then
    begin
    asize.x:=gdisize.Height;
    asize.y:=gdisize.Width;
    end
    else
    begin
    asize.x:=gdisize.Width;
    asize.y:=gdisize.Height;
    end;
    end;
  } Result := asize;
end;

function TRpGDIDriver.SetPagesize(PageSizeQt: TPageSizeQt): TPoint;
var
  qtsize: integer;
begin
  pagesize := QtPageSizeToGDIPageSize(PageSizeQt);
  oldpagesize := GetCurrentPaper;
  SetCurrentPaper(pagesize);

  Result := GetPageSize(qtsize);
end;

procedure TRpGDIDriver.SetOrientation(Orientation: TRpOrientation);
var
  currentorientation: TPrinterOrientation;
begin
  currentorientation := GetPrinterOrientation;
  // if Orientation=rpOrientationPortrait then
  if Orientation <> rpOrientationLandscape then
  begin
    if currentorientation <> poPortrait then
    begin
      if not orientationset then
      begin
        orientationset := true;
        oldorientation := currentorientation;
      end;
      if Printer.printing then
        SetPrinterOrientation(false)
      else
        Printer.Orientation := poPortrait;
    end;
  end
  else
  // if Orientation=rpOrientationLandscape then
  begin
    if currentorientation <> poLandscape then
    begin
      if not orientationset then
      begin
        orientationset := true;
        oldorientation := currentorientation;
      end;
      if Printer.printing then
        SetPrinterOrientation(true)
      else
        Printer.Orientation := poLandscape;
    end;
  end;
end;

procedure DoPrintMetafile(metafile: TRpMetafileReport; tittle: string;
  aform: TFRpVCLProgress; allpages: boolean; frompage, topage, copies: integer;
  collate: boolean; devicefonts: boolean;
  printerindex: TRpPrinterSelect = pRpDefaultPrinter;
  nobegindoc: boolean = false);
var
  i: integer;
  j: integer;
  apage: TRpMetafilePage;
  pagecopies: integer;
  reportcopies: integer;
  dpix, dpiy: integer;
  count1, count2: integer;
  mmfirst, mmlast: DWORD;
  difmilis: int64;
  totalcount: integer;
  pagemargins: TRect;
  offset: TPoint;
  istextonly: boolean;
  drivername, S: String;
  memstream: TMemoryStream;
  rpagesizeQt: TPageSizeQt;
  gdidriver: TRpGDIDriver;
  currentorientation: TPrinterOrientation;
  pconfig: TPrinterConfig;
begin
  pconfig.Changed := false;
  gdidriver := nil;
  try
    if copies = 0 then
      copies := 1;
    drivername := Trim(GetPrinterEscapeStyleDriver(printerindex));
    istextonly := Length(drivername) > 0;
    if istextonly then
    begin
      memstream := TMemoryStream.Create;
      try
        rptextdriver.SaveMetafileRangeToText(metafile, allpages, frompage,
          topage, copies, memstream);
        memstream.Seek(0, soFromBeginning);
        SetLength(S, memstream.Size);
{$IFNDEF DOTNETD}
        memstream.Read(S[1], memstream.Size);
{$ENDIF}
{$IFDEF DOTNETD}
        S := memstream.ToString;
{$ENDIF}
      finally
        memstream.free;
      end;
      // Now Prints to selected printer the stream
      if (not metafile.BlockPrinterSelection) then
        PrinterSelection(metafile.PrinterSelect, metafile.papersource,
          metafile.duplex, pconfig);
      SendControlCodeToPrinter(S);
    end
    else
    begin
      if (not metafile.BlockPrinterSelection) then
      begin
        if printerindex <> pRpDefaultPrinter then
          offset := PrinterSelection(printerindex, metafile.papersource,
            metafile.duplex, pconfig)
        else
          offset := PrinterSelection(metafile.PrinterSelect,
            metafile.papersource, metafile.duplex, pconfig);
      end;
      UpdatePrinterFontList;
      pagemargins := GetPageMarginsTWIPS;
      // Get the time
      mmfirst := TimeGetTime;
      gdidriver := TRpGDIDriver.Create;
      try
        currentorientation := GetPrinterOrientation;
        // Sets page size and orientation
        if metafile.Orientation <> rpOrientationDefault then
        begin
          if metafile.Orientation = rpOrientationPortrait then
          begin
            if currentorientation <> poPortrait then
            begin
              gdidriver.orientationset := true;
              gdidriver.oldorientation := currentorientation;
              if Printer.printing then
                SetPrinterOrientation(false)
              else
                Printer.Orientation := poPortrait;
            end;
          end
          else
          begin
            if currentorientation <> poLandscape then
            begin
              gdidriver.orientationset := true;
              gdidriver.oldorientation := currentorientation;
              if Printer.printing then
                SetPrinterOrientation(true)
              else
                Printer.Orientation := poLandscape;
            end;
          end;
        end;
        // Sets pagesize
        rpagesizeQt.papersource := metafile.papersource;
        rpagesizeQt.duplex := metafile.duplex;
        if metafile.pagesize < 0 then
        begin
          rpagesizeQt.Custom := true;
          rpagesizeQt.CustomWidth := metafile.CustomX;
          rpagesizeQt.CustomHeight := metafile.CustomY;
        end
        else
        begin
          rpagesizeQt.Indexqt := metafile.pagesize;
          rpagesizeQt.Custom := false;
        end;
        gdidriver.toprinter := true;
        gdidriver.selectedprinter := printerindex;
        gdidriver.SetPagesize(rpagesizeQt);
      except
        On E: Exception do
        begin
          rpgraphutilsvcl.RpMessageBox(E.Message);
        end;
      end;
      pagecopies := 1;
      reportcopies := 1;

      if copies > 1 then
      begin
        if (PrinterSupportsCopies(copies)) then
        begin
          if collate then
          begin
            if PrinterSupportsCollation then
            begin
              SetPrinterCopies(copies);
              SetPrinterCollation(true);
            end
            else
            begin
              SetPrinterCopies(1);
              SetPrinterCollation(false);
              reportcopies := copies;
            end;
          end
          else
          begin
            SetPrinterCopies(copies);
            SetPrinterCollation(false);
          end;
        end
        else
        begin
          SetPrinterCopies(1);
          SetPrinterCollation(false);
          if collate then
            reportcopies := copies
          else
            pagecopies := copies;
        end;
      end;
      if allpages then
      begin
        metafile.RequestPage(MAX_PAGECOUNT);
        frompage := 0;
        topage := metafile.CurrentPageCount - 1;
      end
      else
      begin
        frompage := frompage - 1;
        topage := topage - 1;
        metafile.RequestPage(topage);
        if topage > metafile.CurrentPageCount - 1 then
          topage := metafile.CurrentPageCount - 1;
      end;
      if metafile.OpenDrawerBefore then
        SendControlCodeToPrinter(GetPrinterRawOp(printerindex,
          rawopopendrawer));
      if ((not nobegindoc) OR (not Printer.printing)) then
      begin
        Printer.Title := tittle;
        Printer.BeginDoc;
      end;
      try
        dpix := GetDeviceCaps(Printer.Canvas.handle, LOGPIXELSX);
        dpiy := GetDeviceCaps(Printer.Canvas.handle, LOGPIXELSY);
        totalcount := 0;
        for count1 := 0 to reportcopies - 1 do
        begin
          for i := frompage to topage do
          begin
            for count2 := 0 to pagecopies - 1 do
            begin
              apage := metafile.Pages[i];
              if totalcount > 0 then
                gdidriver.NewPage(apage);
              Inc(totalcount);
              for j := 0 to apage.ObjectCount - 1 do
              begin
                gdidriver.PrintObject(Printer.Canvas, apage, apage.Objects[j],
                  dpix, dpiy, true, pagemargins, devicefonts, offset, false);
                if assigned(aform) then
                begin
                  mmlast := TimeGetTime;
                  difmilis := (mmlast - mmfirst);
                  if difmilis > MILIS_PROGRESS then
                  begin
                    // Get the time
                    mmfirst := TimeGetTime;
                    aform.LRecordCount.Caption := SRpPage + ':' +
                      IntToStr(i + 1) + ' - ' + SRpItem + ':' + IntToStr(j + 1);
                    Application.ProcessMessages;
                    if aform.cancelled then
                      Raise Exception.Create(SRpOperationAborted);
                  end;
                end;
              end;
              if assigned(aform) then
              begin
                Application.ProcessMessages;
                if aform.cancelled then
                  Raise Exception.Create(SRpOperationAborted);
              end;
            end;
          end;
        end;
        Printer.EndDoc;
      except
        Printer.Abort;
        raise;
      end;
    end;
    if metafile.OpenDrawerAfter then
      SendControlCodeToPrinter(GetPrinterRawOp(printerindex, rawopopendrawer));
    if assigned(gdidriver) then
    begin
      gdidriver.SendAfterPrintOperations;
      if gdidriver.orientationset then
      begin
        Printer.Orientation := gdidriver.oldorientation;
      end;
    end;
  finally
    if assigned(gdidriver) then
      gdidriver.free;
    SetPrinterConfig(pconfig);
  end;
  // Send Especial operations
  if assigned(aform) then
    aform.close;
end;

function PrintMetafile(metafile: TRpMetafileReport; tittle: string;
  showprogress, allpages: boolean; frompage, topage, copies: integer;
  collate: boolean; devicefonts: boolean;
  printerindex: TRpPrinterSelect = pRpDefaultPrinter;
  nobegindoc: boolean = false): boolean;
var
  dia: TFRpVCLProgress;
begin
  Result := true;
  if Not showprogress then
  begin
    DoPrintMetafile(metafile, tittle, nil, allpages, frompage, topage, copies,
      collate, devicefonts, printerindex, nobegindoc);
    exit;
  end;
  dia := TFRpVCLProgress.Create(Application);
  try
    dia.oldonidle := Application.OnIdle;
    try
      dia.metafile := metafile;
      dia.tittle := tittle;
      dia.allpages := allpages;
      dia.frompage := frompage;
      dia.topage := topage;
      dia.copies := copies;
      dia.collate := collate;
      dia.devicefonts := devicefonts;
      dia.printerindex := printerindex;
      dia.nobegindoc := nobegindoc;
      Application.OnIdle := dia.AppIdle;
      dia.showmodal;
      if dia.errorproces then
        Raise Exception.Create(dia.ErrorMessage);
      Result := Not dia.cancelled;
    finally
      Application.OnIdle := dia.oldonidle;
    end;
  finally
    dia.free;
  end;
end;

type
  LogPal = record
    lpal: TLogPalette;
    dummy: Array [0 .. 5] of TPaletteEntry;
  end;

const
  MAX_RES_BITMAP = 5760;

function DoMetafileToBitmap(metafile: TRpMetafileReport; aform: TFRpVCLProgress;
  Mono: boolean; resx: integer = 200; resy: integer = 100): TBitmap;
var
  gdidriver: TRpGDIDriver;
  apage: TRpMetafilePage;
  i, j: integer;
  offset: TPoint;
  pagemargins: TRect;
  mmfirst, mmlast: DWORD;
  difmilis: int64;
  pageheight, pagewidth: integer;
  arec: TRect;
  syspal: LogPal;
  realx, realy: integer;
  ameta: TMetafile;
  ametacanvas: TMetafilecanvas;
  rgbintensity: integer;
  aobj: TRpMetaObject;
  ddc: HDC;
begin
  // Maximum resolution
  if resx > MAX_RES_BITMAP then
    resx := MAX_RES_BITMAP;
  if resy > MAX_RES_BITMAP then
    resy := MAX_RES_BITMAP;
  if resx < 1 then
    resx := 1;
  if resy < 1 then
    resy := 1;
  offset.X := 0;
  offset.Y := 0;
  mmfirst := TimeGetTime;
  pagemargins.Left := 0;
  pagemargins.Top := 0;
  pagemargins.Bottom := 0;
  pagemargins.Top := 0;
  Result := TBitmap.Create;
  try
    Result.HandleType := bmDIB;
{$IFNDEF DOTNETD}
    if Mono then
    begin
      Result.PixelFormat := pf1bit;
      syspal.lpal.palNumEntries := 2;
      syspal.lpal.palVersion := $300;
      syspal.lpal.palPalEntry[0].peRed := 255;
      syspal.lpal.palPalEntry[0].peGreen := 255;
      syspal.lpal.palPalEntry[0].peBlue := 255;
      syspal.dummy[0].peRed := 0;
      syspal.dummy[0].peGreen := 0;
      syspal.dummy[0].peBlue := 0;
      Result.Palette := CreatePalette(syspal.lpal);
    end
    else
{$ENDIF}
    begin
{$IFNDEF DOTNETDBUGS}
      Result.PixelFormat := pf32bit;
{$ENDIF}
    end;
    pagewidth := (metafile.CustomX * resx) div TWIPS_PER_INCHESS;
    Result.Width := pagewidth;
    pageheight := (metafile.CustomY * resy) div TWIPS_PER_INCHESS;
    metafile.RequestPage(MAX_PAGECOUNT);
    Result.Height := pageheight * metafile.CurrentPageCount;
    arec.Top := 0;
    arec.Right := pagewidth * 2;
    arec.Bottom := pageheight * metafile.CurrentPageCount + pageheight;
    arec.Left := 0;
    Result.Canvas.Brush.Color := CLXColorToVCLColor(metafile.BackColor);
    Result.Canvas.FillRect(arec);
    gdidriver := TRpGDIDriver.Create;
    try
      for i := 0 to metafile.CurrentPageCount - 1 do
      begin
        ameta := TMetafile.Create;
        try
          ameta.Enhanced := true;
          if Mono then
            ameta.Palette := CreatePalette(syspal.lpal);
          ddc := GetDC(0);
          realx := GetDeviceCaps(ddc, LOGPIXELSX);
          realy := GetDeviceCaps(ddc, LOGPIXELSY);
          ReleaseDC(0, ddc);
          ameta.Width := metafile.CustomX * realx div TWIPS_PER_INCHESS;
          ameta.Height := metafile.CustomY * realy div TWIPS_PER_INCHESS;
          apage := metafile.Pages[i];
          ametacanvas := TMetafilecanvas.Create(ameta, 0);
          try
            for j := 0 to apage.ObjectCount - 1 do
            begin
              aobj := apage.Objects[j];
              if Mono then
              begin
                if apage.Objects[j].Metatype = rpMetaText then
                begin
                  rgbintensity := (aobj.FontColor AND $FF) +
                    ((aobj.FontColor AND $FF00) shr 8) +
                    ((aobj.FontColor AND $FF0000) shr 16);
                  if rgbintensity > 128 * 3 then
                    aobj.FontColor := clWhite
                  else
                    aobj.FontColor := clBlack;
                end;
              end;
              gdidriver.PrintObject(ametacanvas, apage, aobj, realx, realy,
                true, pagemargins, false, offset, false);
              if assigned(aform) then
              begin
                mmlast := TimeGetTime;
                difmilis := (mmlast - mmfirst);
                if difmilis > MILIS_PROGRESS then
                begin
                  // Get the time
                  mmfirst := TimeGetTime;
                  aform.LRecordCount.Caption := SRpPage + ':' + IntToStr(i + 1)
                    + ' - ' + SRpItem + ':' + IntToStr(j + 1);
                  Application.ProcessMessages;
                  if aform.cancelled then
                    Raise Exception.Create(SRpOperationAborted);
                end;
              end;
            end;
          finally
            ametacanvas.free;
          end;
          arec.Top := pageheight * i;
          arec.Left := 0;
          arec.Bottom := arec.Top + pageheight;
          arec.Right := pagewidth;
          Result.Canvas.StretchDraw(arec, ameta);
          if assigned(aform) then
          begin
            Application.ProcessMessages;
            if aform.cancelled then
              Raise Exception.Create(SRpOperationAborted);
          end;
        finally
          ameta.free;
        end;
      end;
    finally
      gdidriver.free;
    end;
  except
    Result.free;
    raise;
  end;
end;

function MetafileToBitmap(metafile: TRpMetafileReport; showprogress: boolean;
  Mono: boolean; resx: integer = 200; resy: integer = 100): TBitmap;
var
  dia: TFRpVCLProgress;
begin
  if Not showprogress then
  begin
    Result := DoMetafileToBitmap(metafile, nil, Mono, resx, resy);
    exit;
  end;
  dia := TFRpVCLProgress.Create(Application);
  try
    dia.oldonidle := Application.OnIdle;
    try
      dia.metafile := metafile;
      dia.tittle := 'Bitmap';
      dia.bitresx := resx;
      dia.bitresy := resy;
      dia.bitmono := Mono;
      Application.OnIdle := dia.AppIdleBitmap;
      dia.showmodal;
      Result := dia.MetaBitmap;
      if dia.errorproces then
        Raise Exception.Create(dia.ErrorMessage);
    finally
      Application.OnIdle := dia.oldonidle;
    end;
  finally
    dia.free;
  end;
end;

procedure TFRpVCLProgress.FormCreate(Sender: TObject);
begin
  LRecordCount.Font.Style := [fsBold];
  LTittle.Font.Style := [fsBold];

  BOK.Caption := TranslateStr(93, BOK.Caption);
  BCancel.Caption := TranslateStr(94, BCancel.Caption);
  LTitle.Caption := TranslateStr(252, LTitle.Caption);
  LProcessing.Caption := TranslateStr(253, LProcessing.Caption);
  GPrintRange.Caption := TranslateStr(254, GPrintRange.Caption);
  LFrom.Caption := TranslateStr(255, LFrom.Caption);
  LTo.Caption := TranslateStr(256, LTo.Caption);
  RadioAll.Caption := TranslateStr(257, RadioAll.Caption);
  RadioRange.Caption := TranslateStr(258, RadioRange.Caption);
  Caption := TranslateStr(259, Caption);

  LHorzRes.Caption := SRpHorzRes;
  LVertRes.Caption := SRpVertRes;
  CheckMono.Caption := SRpMonochrome;
end;

procedure TFRpVCLProgress.AppIdle(Sender: TObject; var done: boolean);
begin
  errorproces := false;
  cancelled := false;
  Application.OnIdle := nil;
  done := false;
  try
    LTittle.Caption := tittle;
    LProcessing.Visible := true;
    DoPrintMetafile(metafile, tittle, Self, allpages, frompage, topage, copies,
      collate, devicefonts, printerindex, nobegindoc);
  except
    On E: Exception do
    begin
      ErrorMessage := E.Message;
      errorproces := true;
    end;
  end;
  close;
end;

procedure TFRpVCLProgress.AppIdleBitmap(Sender: TObject; var done: boolean);
begin
  cancelled := false;
  Application.OnIdle := nil;
  done := false;
  errorproces := false;
  try
    LTittle.Caption := tittle;
    LProcessing.Visible := true;
    MetaBitmap := DoMetafileToBitmap(metafile, Self, bitmono, bitresx, bitresy);
  except
    on E: Exception do
    begin
      errorproces := true;
      ErrorMessage := E.Message;
    end;
  end;
  close;
end;

procedure TFRpVCLProgress.BCancelClick(Sender: TObject);
begin
  cancelled := true;
end;

{$IFNDEF FORWEBAX}

function ExportReportToPDF(report: TRpReport; Caption: string;
  progress: boolean; allpages: boolean; frompage, topage, copies: integer;
  showprintdialog: boolean; filename: string; compressed: boolean;
  collate: boolean): boolean;
var
  dia: TFRpVCLProgress;
  oldonidle: TIdleEvent;
  pdfdriver: TRpPDFDriver;
  gdidriver: TRpGDIDriver;
begin
  Result := false;
  allpages := true;
  collate := false;
  if showprintdialog then
  begin
    if Not DoShowPrintDialog(allpages, frompage, topage, copies, collate, true)
    then
      exit;
  end;
  if progress then
  begin
    // Assign appidle frompage to page...
    dia := TFRpVCLProgress.Create(Application);
    try
      dia.allpages := allpages;
      dia.frompage := frompage;
      dia.topage := topage;
      dia.copies := copies;
      dia.report := report;
      dia.filename := filename;
      dia.pdfcompressed := compressed;
      dia.collate := collate;
      oldonidle := Application.OnIdle;
      try
        Application.OnIdle := dia.AppIdlePrintPDF;
        dia.showmodal;
        if dia.errorproces then
          Raise Exception.Create(dia.ErrorMessage);
      finally
        Application.OnIdle := oldonidle;
      end;
    finally
      dia.free;
    end;
  end
  else
  begin
    gdidriver := TRpGDIDriver.Create;
    pdfdriver := TRpPDFDriver.Create;
    try
      pdfdriver.filename := filename;
      pdfdriver.compressed := compressed;
{$IFDEF USETEECHART}
      report.metafile.OnDrawChart := gdidriver.DoDrawChart;
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
      report.metafile.OnFilterImage := gdidriver.FilterImage;
{$ENDIF}
      report.PrintRange(pdfdriver, allpages, frompage, topage, copies, collate);
    finally
      gdidriver.free;
      pdfdriver.free;
    end;
    Result := true;
  end;
end;

function ExportReportToPDFMetaStream(report: TRpReport; Caption: string;
  progress: boolean; allpages: boolean; frompage, topage, copies: integer;
  showprintdialog: boolean; Stream: TStream; compressed: boolean;
  collate: boolean; metafile: boolean): boolean;
var
  pdfdriver: TRpPDFDriver;
  gdidriver: TRpGDIDriver;
  oldtwopass: boolean;
  onprog: TRpProgressEvent;
begin
  oldtwopass := report.TwoPass;
  onprog := report.OnPRogress;
  try
    if metafile then
      report.TwoPass := true;
    gdidriver := TRpGDIDriver.Create;
    pdfdriver := TRpPDFDriver.Create;
    try
      if not metafile then
        pdfdriver.DestStream := Stream;
      pdfdriver.compressed := compressed;
      if progress then
        report.OnPRogress := pdfdriver.RepProgress;
{$IFDEF USETEECHART}
      report.metafile.OnDrawChart := gdidriver.DoDrawChart;
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
      report.metafile.OnFilterImage := gdidriver.FilterImage;
{$ENDIF}
      if metafile then
      begin
        report.PrintRange(pdfdriver, allpages, frompage, topage,
          copies, collate);
      end
      else
        report.PrintRange(pdfdriver, allpages, frompage, topage,
          copies, collate);
      if metafile then
        report.metafile.SaveToStream(Stream);
    finally
      pdfdriver.free;
      gdidriver.free;
    end;
  finally
    report.TwoPass := oldtwopass;
    report.OnPRogress := onprog;
  end;
  Result := true;
end;

procedure TFRpVCLProgress.RepProgress(Sender: TRpBaseReport;
  var docancel: boolean);
var
  astring: Widestring;
begin
  if Not assigned(LRecordCount) then
    exit;
  if Sender.ProgressToStdOut then
  begin
    astring := SRpRecordCount + ' ' + IntToStr(Sender.CurrentSubReportIndex) +
      ':' + SRpPage + ':' + FormatFloat('#########,####', Sender.PageNum) + '-'
      + FormatFloat('#########,####', Sender.RecordCount);
{$I-}
{$IFDEF USEVARIANTS}
    WriteLn(astring);
{$ELSE}
    WriteLn(String(astring));
{$ENDIF}
{$I+}
    // If it's the last page prints additional info
    if Sender.LastPage then
    begin
      astring := format('%-20.20s', [SRpPage]) + FormatFloat('0000000000',
        Sender.PageNum + 1);
{$I-}
{$IFDEF USEVARIANTS}
      WriteLn(astring);
{$ELSE}
      WriteLn(String(astring));
{$ENDIF}
{$I+}
    end;
  end;
  LRecordCount.Caption := IntToStr(Sender.CurrentSubReportIndex) + ':' + SRpPage
    + ':' + FormatFloat('#########,####', Sender.PageNum + 1) + '-' +
    FormatFloat('#########,####', Sender.RecordCount + 1);
  if Sender.LastPage then
    LRecordCount.Caption := format('%-20.20s', [SRpPage]) +
      FormatFloat('0000000000', Sender.PageNum + 1);
  Application.ProcessMessages;
  if cancelled then
    docancel := true;
end;

procedure TFRpVCLProgress.AppIdleReport(Sender: TObject; var done: boolean);
var
  oldprogres: TRpProgressEvent;
  istextonly: boolean;
  drivername: String;
  TextDriver: TRpTextDriver;
  pdfdriver: TRpPDFDriver;
  gdidriver: TRpGDIDriver;
begin
  Application.OnIdle := nil;
  done := false;
  errorproces := false;
  try
    drivername := Trim(GetPrinterEscapeStyleDriver(report.PrinterSelect));
    istextonly := Length(drivername) > 0;

    if istextonly then
    begin
      TextDriver := TRpTextDriver.Create;
      try
        if (not report.metafile.BlockPrinterSelection) then
          TextDriver.SelectPrinter(report.PrinterSelect);
        oldprogres := report.OnPRogress;
        try
          report.OnPRogress := RepProgress;
          report.PrintAll(TextDriver);
        finally
          report.OnPRogress := oldprogres;
        end;
      finally
        TextDriver.free;
      end;
    end
    else
    begin
      if usepdfdriver then
      begin
        pdfdriver := TRpPDFDriver.Create;
        try
          oldprogres := report.OnPRogress;
          try
            report.OnPRogress := RepProgress;
            report.PrintAll(pdfdriver);
          finally
            report.OnPRogress := oldprogres;
          end;
        finally
          pdfdriver.free;
        end;
      end
      else
      begin
        gdidriver := TRpGDIDriver.Create;
        try
          gdidriver.noenddoc := noenddoc;
          if noenddoc then
            gdidriver.toprinter := true;
          if report.PrinterFonts = rppfontsalways then
            gdidriver.devicefonts := true
          else
            gdidriver.devicefonts := false;
          gdidriver.neverdevicefonts := report.PrinterFonts = rppfontsnever;
          oldprogres := report.OnPRogress;
          try
            report.OnPRogress := RepProgress;
            report.PrintAll(gdidriver);
          finally
            report.OnPRogress := oldprogres;
          end;
        finally
          gdidriver.free;
        end;
      end;
    end;
  except
    On E: Exception do
    begin
      ErrorMessage := E.Message;
      errorproces := true;
    end;
  end;
  close;
end;

function CalcReportWidthProgress(report: TRpReport;
  noenddoc: boolean = false): boolean;
var
  dia: TFRpVCLProgress;
begin
  Result := false;
  dia := TFRpVCLProgress.Create(Application);
  try
    dia.oldonidle := Application.OnIdle;
    try
      dia.report := report;
      Application.OnIdle := dia.AppIdleReport;
      dia.noenddoc := noenddoc;
      dia.showmodal;
      if dia.errorproces then
        Raise Exception.Create(dia.ErrorMessage);
      Result := Not dia.cancelled;
    finally
      Application.OnIdle := dia.oldonidle;
    end;
  finally
    dia.free;
  end;
end;

function CalcReportWidthProgressPDF(report: TRpReport;
  noenddoc: boolean = false): boolean;
var
  dia: TFRpVCLProgress;
begin
  Result := false;
  dia := TFRpVCLProgress.Create(Application);
  try
    dia.oldonidle := Application.OnIdle;
    try
      dia.report := report;
      Application.OnIdle := dia.AppIdleReport;
      dia.usepdfdriver := true;
      dia.noenddoc := noenddoc;
      dia.showmodal;
      if dia.errorproces then
        Raise Exception.Create(dia.ErrorMessage);
      Result := Not dia.cancelled;
    finally
      Application.OnIdle := dia.oldonidle;
    end;
  finally
    dia.free;
  end;
end;

procedure TFRpVCLProgress.AppIdlePrintRange(Sender: TObject; var done: boolean);
var
  oldprogres: TRpProgressEvent;
  gdidriver: TRpGDIDriver;
begin
  Application.OnIdle := nil;
  done := false;
  errorproces := false;
  try
    gdidriver := TRpGDIDriver.Create;
    try
      gdidriver.toprinter := true;
      if report.PrinterFonts = rppfontsalways then
        gdidriver.devicefonts := true
      else
        gdidriver.devicefonts := false;
      gdidriver.neverdevicefonts := report.PrinterFonts = rppfontsnever;
      oldprogres := report.OnPRogress;
      try
        report.OnPRogress := RepProgress;
        report.PrintRange(gdidriver, allpages, frompage, topage,
          copies, collate);
      finally
        report.OnPRogress := oldprogres;
      end;
    finally
      gdidriver.free;
    end;
  except
    On E: Exception do
    begin
      ErrorMessage := E.Message;
      errorproces := true;
    end;
  end;
  close;
end;

procedure TFRpVCLProgress.AppIdlePrintRangeText(Sender: TObject;
  var done: boolean);
var
  oldprogres: TRpProgressEvent;
  S: String;
  TextDriver: TRpTextDriver;
  pconfig: TPrinterConfig;
begin
  pconfig.Changed := false;
  Application.OnIdle := nil;
  done := false;
  try
    errorproces := false;
    try
      TextDriver := TRpTextDriver.Create;
      try
        oldprogres := report.OnPRogress;
        try
          if (not report.metafile.BlockPrinterSelection) then
            TextDriver.SelectPrinter(report.PrinterSelect);
          report.OnPRogress := RepProgress;
          report.PrintRange(TextDriver, allpages, frompage, topage,
            copies, collate);
          // Now Prints to selected printer the stream
          SetLength(S, TextDriver.memstream.Size);
{$IFNDEF DOTNETD}
          TextDriver.memstream.Read(S[1], TextDriver.memstream.Size);
{$ENDIF}
{$IFDEF DOTNETD}
          S := TextDriver.memstream.ToString;
{$ENDIF}
          if (not report.metafile.BlockPrinterSelection) then
            PrinterSelection(report.PrinterSelect, report.papersource,
              report.duplex, pconfig);
          SendControlCodeToPrinter(S);
        finally
          report.OnPRogress := oldprogres;
        end;
      finally
        TextDriver.free;
      end;
    except
      On E: Exception do
      begin
        ErrorMessage := E.Message;
        errorproces := true;
      end;
    end;
  finally
    SetPrinterConfig(pconfig);
  end;
  close;
end;

procedure TFRpVCLProgress.AppIdlePrintPDF(Sender: TObject; var done: boolean);
var
  oldprogres: TRpProgressEvent;
  gdidriver: TRpGDIDriver;
  pdfdriver: TRpPDFDriver;
begin
  Application.OnIdle := nil;
  done := false;
  errorproces := false;
  try
    pdfdriver := TRpPDFDriver.Create;
    gdidriver := TRpGDIDriver.Create;
    try

      pdfdriver.filename := filename;
      pdfdriver.compressed := pdfcompressed;
{$IFDEF USETEECHART}
      report.metafile.OnDrawChart := gdidriver.DoDrawChart;
{$ENDIF}
{$IFDEF EXTENDEDGRAPHICS}
      report.metafile.OnFilterImage := gdidriver.FilterImage;
{$ENDIF}
      oldprogres := report.OnPRogress;
      try
        report.OnPRogress := RepProgress;
        report.PrintRange(pdfdriver, allpages, frompage, topage,
          copies, collate);
      finally
        report.OnPRogress := oldprogres;
      end;
    finally
      pdfdriver.free;
      gdidriver.free;
    end;
  except
    On E: Exception do
    begin
      ErrorMessage := E.Message;
      errorproces := true;
    end;
  end;
  close;
end;

function PrintReport(report: TRpReport; Caption: string; progress: boolean;
  allpages: boolean; frompage, topage, copies: integer;
  collate: boolean): boolean;
var
  gdidriver: TRpGDIDriver;
  TextDriver: TRpTextDriver;
  forcecalculation: boolean;
  dia: TFRpVCLProgress;
  oldonidle: TIdleEvent;
  devicefonts: boolean;
  istextonly: boolean;
  drivername: String;
  S: AnsiString;
  pconfig: TPrinterConfig;
begin
  pconfig.Changed := false;
  try
    report.metafile.Title := Caption;
    drivername := Trim(GetPrinterEscapeStyleDriver(report.PrinterSelect));
    istextonly := Length(drivername) > 0;
    if report.PrinterFonts = rppfontsalways then
      devicefonts := true
    else
      devicefonts := false;
    Result := true;
    forcecalculation := false;
    if ((report.copies > 1) and (collate)) then
    begin
      forcecalculation := true;
    end;
    if report.TwoPass then
      forcecalculation := true;
    if forcecalculation then
    begin
      if progress then
      begin
        try
          if Not CalcReportWidthProgress(report, true) then
            Result := false
          else
            PrintMetafile(report.metafile, Caption, progress, allpages,
              frompage, topage, copies, collate, devicefonts,
              report.PrinterSelect, true);
        finally
          if Printer.printing then
            Printer.Abort;
        end
      end
      else
      begin
        try
          if istextonly then
          begin
            TextDriver := TRpTextDriver.Create;
            try
              if (not report.metafile.BlockPrinterSelection) then
                TextDriver.SelectPrinter(report.PrinterSelect);
              report.PrintAll(TextDriver);
            finally
              TextDriver.free;
            end;
          end
          else
          begin
            gdidriver := TRpGDIDriver.Create;
            try
              if report.PrinterFonts = rppfontsalways then
                gdidriver.devicefonts := true
              else
                gdidriver.devicefonts := false;
              gdidriver.toprinter := true;
              gdidriver.neverdevicefonts := report.PrinterFonts = rppfontsnever;
              gdidriver.noenddoc := true;
              report.PrintAll(gdidriver);
            finally
              gdidriver.free;
            end;
          end;
          PrintMetafile(report.metafile, Caption, progress, allpages, frompage,
            topage, copies, collate, devicefonts, report.PrinterSelect, true);
        finally
          if Printer.printing then
            Printer.Abort;
        end
      end;
      exit;
    end;
    if progress then
    begin
      // Assign appidle frompage to page...
      dia := TFRpVCLProgress.Create(Application);
      try
        dia.allpages := allpages;
        dia.frompage := frompage;
        dia.topage := topage;
        dia.copies := copies;
        dia.report := report;
        dia.collate := collate;
        oldonidle := Application.OnIdle;
        try
          if istextonly then
            Application.OnIdle := dia.AppIdlePrintRangeText
          else
            Application.OnIdle := dia.AppIdlePrintRange;
          dia.showmodal;
          if dia.errorproces then
            Raise Exception.Create(dia.ErrorMessage);
        finally
          Application.OnIdle := oldonidle;
        end;
      finally
        dia.free;
      end;
    end
    else
    begin
      if istextonly then
      begin
        TextDriver := TRpTextDriver.Create;
        try
          if (not report.metafile.BlockPrinterSelection) then
            TextDriver.SelectPrinter(report.PrinterSelect);
          report.PrintRange(TextDriver, allpages, frompage, topage,
            copies, collate);
          SetLength(S, TextDriver.memstream.Size);
          TextDriver.memstream.Read(S[1], TextDriver.memstream.Size);
          if (not report.metafile.BlockPrinterSelection) then
            PrinterSelection(report.PrinterSelect, report.papersource,
              report.duplex, pconfig);
          SendControlCodeToPrinter(S);
        finally
          TextDriver.free;
        end;
      end
      else
      begin
        gdidriver := TRpGDIDriver.Create;
        try
          gdidriver.toprinter := true;
          if report.PrinterFonts = rppfontsalways then
            gdidriver.devicefonts := true
          else
            gdidriver.devicefonts := false;
          gdidriver.neverdevicefonts := report.PrinterFonts = rppfontsnever;
          report.PrintRange(gdidriver, allpages, frompage, topage,
            copies, collate);
        finally
          gdidriver.free;
        end;
      end;
    end;
  finally
    SetPrinterConfig(pconfig);
  end;
end;
{$ENDIF}

procedure TFRpVCLProgress.BOKClick(Sender: TObject);
begin
  frompage := StrToInt(EFrom.Text);
  topage := StrToInt(ETo.Text);
  if frompage < 1 then
    frompage := 1;
  if topage < frompage then
    topage := frompage;
  close;
  dook := true;
end;

procedure TFRpVCLProgress.FormShow(Sender: TObject);
begin
  if BOK.Visible then
  begin
    EFrom.Text := IntToStr(frompage);
    ETo.Text := IntToStr(topage);
  end;
end;

procedure TRpGDIDriver.GraphicExtent(Stream: TMemoryStream; var extent: TPoint;
  dpi: integer);
var
  graphic: TBitmap;
{$IFNDEF DOTNETD}
  jpegimage: TJPegImage;
{$ENDIF}
  bitmapwidth, bitmapheight: integer;
  format: string;
begin
  if dpi <= 0 then
    exit;
  graphic := TBitmap.Create;
  try
    format := '';
    GetJPegInfo(Stream, bitmapwidth, bitmapheight, format);
    if (format = 'JPEG') then
    begin
{$IFNDEF DOTNETD}
      jpegimage := TJPegImage.Create;
      try
        jpegimage.LoadFromStream(Stream);
        graphic.Assign(jpegimage);
      finally
        jpegimage.free;
      end;
{$ENDIF}
{$IFDEF DOTNETD}
      graphic.LoadFromStream(Stream);
{$ENDIF}
    end
    else
    begin
      if (format = 'BMP') then
      begin
        graphic.LoadFromStream(Stream);
      end
      else
      begin
        // All other formats
{$IFDEF EXTENDEDGRAPHICS}
        FilterImage(Stream);
        jpegimage := TJPegImage.Create;
        try
          jpegimage.LoadFromStream(Stream);
          bitmap.Assign(jpegimage);
        finally
          jpegimage.free;
        end;
{$ENDIF}
      end;
    end;
    extent.X := Round(graphic.Width / dpi * TWIPS_PER_INCHESS);
    extent.Y := Round(graphic.Height / dpi * TWIPS_PER_INCHESS);
  finally
    graphic.free;
  end;
end;

function PrinterSelection(printerindex: TRpPrinterSelect;
  papersource, duplex: integer; var pconfig: TPrinterConfig): TPoint;
var
  printername: String;
  index: integer;
  offset: TPoint;
  apage: TGDIPageSize;
begin
  printername := GetPrinterConfigName(printerindex);
  offset := GetPrinterOffset(printerindex);
  if Length(printername) > 0 then
  begin
    index := Printer.Printers.IndexOf(printername);
    if index >= 0 then
    begin
      if Printer.printerindex <> Index then
      begin
        // Fixes problem, this reads default
        // document properties after printer selection
        pconfig := GetPrinterConfig;
        pconfig.Changed := true;
        rpvgraphutils.SwitchToPrinterIndex(index);
        // Printer.PrinterIndex:=index;
      end;
    end;
  end;
  if ((papersource > 0) or (duplex > 0)) then
  begin
    apage := GetCurrentPaper;
    if papersource > 0 then
      apage.papersource := papersource;
    if duplex > 0 then
      apage.duplex := duplex;
    SetCurrentPaper(apage);
  end;
  Result := offset;
end;

procedure TRpGDIDriver.SelectPrinter(printerindex: TRpPrinterSelect);
var
  pconfig: TPrinterConfig;
begin
  offset := PrinterSelection(printerindex, 0, 0, pconfig);
  selectedprinter := printerindex;
  if neverdevicefonts then
    exit;
  if devicefonts then
    exit;
  devicefonts := GetDeviceFontsOption(printerindex);
  if devicefonts then
    UpdatePrinterFontList;
end;

procedure TRpGDIDriver.SendAfterPrintOperations;
var
  Operation: String;
  i: TPrinterRawOp;
begin
  for i := Low(TPrinterRawOp) to High(TPrinterRawOp) do
  begin
    if PrinterRawOpEnabled(selectedprinter, i) then
    begin
      Operation := GetPrinterRawOp(selectedprinter, i);
      if Length(Operation) > 0 then
        SendControlCodeToPrinter(Operation);
    end;
  end;
end;

procedure PageSizeSelection(rpPageSize: TPageSizeQt);
var
  pagesize: TGDIPageSize;
begin
  if Printer.Printers.Count < 1 then
    exit;
  pagesize := QtPageSizeToGDIPageSize(rpPageSize);
  SetCurrentPaper(pagesize);
end;

procedure OrientationSelection(neworientation: TRpOrientation);
begin
  if Printer.Printers.Count < 1 then
    exit;
  SetPrinterOrientation(neworientation = rpOrientationLandscape);
  // if neworientation=rpOrientationDefault then
  // exit;
  // if neworientation=rpOrientationPortrait then
  // Printer.Orientation:=poPortrait
  // else
  // Printer.Orientation:=poLandscape;
end;

{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}

procedure TRpGDIDriver.FilterImage(memstream: TMemoryStream);
begin
  inherited FilterImage(memstream);
  ExFilterImage(memstream);
end;
{$ENDIF}
{$IFDEF USETEECHART}

procedure TRpGDIDriver.AddFunctionToChart(achart: TChart; functionName: string;
  functionParams: string; serieCaption: string);
var
  aFastLineSerie: TFastLineSeries;
  average: TTeeFunction;
  serieIndex: integer;
  chartSerie:TChartSeries;
begin
  serieIndex := achart.SeriesCount - 1;
  while (serieIndex < achart.SeriesCount) do
  begin
    if assigned(achart.Series[serieIndex].FunctionType) then
      serieIndex := serieIndex - 1
    else
      break;
  end;
  if (serieIndex < 0) then
    exit;
  if (functionName = 'AVG') then
  begin
    aFastLineSerie := achart.AddSeries(TFastLineSeries) as TFastLineSeries;
    aFastLineSerie.Title := serieCaption;
    average := TAverageTeeFunction.Create(nil);
    aFastLineSerie.FunctionType := average;
    aFastLineSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'MEDIAN') then
  begin
    aFastLineSerie := achart.AddSeries(TFastLineSeries) as TFastLineSeries;
    aFastLineSerie.Title := serieCaption;
    average := TMedianTeeFunction.Create(nil);
    aFastLineSerie.FunctionType := average;
    aFastLineSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'MAX') then
  begin
    aFastLineSerie := achart.AddSeries(TFastLineSeries) as TFastLineSeries;
    aFastLineSerie.Title := serieCaption;
    average := THighTeeFunction.Create(nil);
    aFastLineSerie.FunctionType := average;
    aFastLineSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'MIN') then
  begin
    aFastLineSerie := achart.AddSeries(TFastLineSeries) as TFastLineSeries;
    aFastLineSerie.Title := serieCaption;
    average := TLowTeeFunction.Create(nil);
    aFastLineSerie.FunctionType := average;
    aFastLineSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'ADD') then
  begin
    aFastLineSerie := achart.AddSeries(TFastLineSeries) as TFastLineSeries;
    aFastLineSerie.Title := serieCaption;
    average := TAddTeeFunction.Create(nil);
    aFastLineSerie.FunctionType := average;
    aFastLineSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'SUB') then
  begin
    aFastLineSerie := achart.AddSeries(TFastLineSeries) as TFastLineSeries;
    aFastLineSerie.Title := serieCaption;
    average := TSubtractTeeFunction.Create(nil);
    aFastLineSerie.FunctionType := average;
    aFastLineSerie.DataSources.Add(achart[serieIndex]);
  end
{$IFDEF TEECHARTPRO}
  else
  if (functionName = 'MACD') then
  begin
    chartSerie:=achart.AddSeries(TLineSeries) as TLineSeries;
    chartSerie.Title := serieCaption;
    (chartSerie as TLineSeries).Smoothed:=true;
    average := TMACDFunction.Create(achart);
    chartSerie.FunctionType := average;
    chartSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'MAVG') then
  begin
    chartSerie:=achart.AddSeries(TLineSeries) as TLineSeries;
    chartSerie.Title := serieCaption;
    (chartSerie as TLineSeries).Smoothed:=true;
    average := TMovingAverageFunction.Create(achart);
    chartSerie.FunctionType := average;
    chartSerie.DataSources.Add(achart[serieIndex]);
  end
  else
  if (functionName = 'EMAVG') then
  begin
    chartSerie:=achart.AddSeries(TLineSeries) as TLineSeries;
    chartSerie.Title := serieCaption;
    (chartSerie as TLineSeries).Smoothed:=true;
    average := TExpMovAveFunction.Create(achart);
    chartSerie.FunctionType := average;
    chartSerie.DataSources.Add(achart[serieIndex]);
  end
{$ENDIF}  
  else
    raise Exception.Create('Chart Function name unknown: '+functionName);
end;

procedure TRpGDIDriver.DoDrawChart(adriver: TRpPrintDriver; Series: TRpSeries;
  page: TRpMetafilePage; aposx, aposy: integer; xchart: TObject);
var
  nchart: TRpChart;
  achart: TChart;
  aserie: TChartSeries;
  i, j, afontsize: integer;
  rec: TRect;
  intserie: TRpSeriesItem;
  abitmap: TBitmap;
  FMStream: TMemoryStream;
  acolor: integer;
{$IFDEF DELPHI2009UP}
  nform: TForm;
{$ENDIF}
begin
  nchart := TRpChart(xchart);
  if nchart.Driver = rpchartdriverengine then
  begin
    rppdfdriver.DoDrawChart(adriver, Series, page, aposx, aposy, xchart);
    exit;
  end;
  achart := TChart.Create(nil);
  try
    // In delphi 7 there is no need for parent
{$IFDEF DELPHI2009UP}
    nform := TForm.Create(nil);
    achart.Parent := nform;
{$ENDIF}
    achart.BevelOuter := bvNone;
    afontsize := Round(nchart.FontSize * nchart.Resolution / 100);
    achart.View3D := nchart.View3D;
    achart.View3DOptions.Rotation := nchart.Rotation;
{$IFNDEF BUILDER4}
    achart.View3DOptions.Perspective := nchart.Perspective;
{$ENDIF}
    achart.View3DOptions.Elevation := nchart.Elevation;
    achart.View3DOptions.Orthogonal := nchart.Orthogonal;
    achart.View3DOptions.Zoom := nchart.Zoom;
    achart.View3DOptions.Tilt := nchart.Tilt;
    achart.View3DOptions.HorizOffset := nchart.HorzOffset;
    achart.View3DOptions.VertOffset := nchart.VertOffset;
    achart.View3DWalls := nchart.View3DWalls;
    achart.BackColor := clTeeColor;
    achart.BackWall.Brush.Style := bsclear;
    achart.Gradient.Visible := false;
    achart.Color := clWhite;
    achart.LeftAxis.LabelsFont.Name := nchart.WFontName;
    achart.BottomAxis.LabelsFont.Name := nchart.WFontName;
    achart.Legend.Font.Name := nchart.WFontName;
    achart.LeftAxis.LabelsFont.Style := CLXIntegerToFontStyle(nchart.FontStyle);
    achart.BottomAxis.LabelsFont.Style :=
      CLXIntegerToFontStyle(nchart.FontStyle);
    achart.Legend.Font.Size := afontsize;
    achart.Legend.Font.Style := CLXIntegerToFontStyle(nchart.FontStyle);
    achart.Legend.Visible := nchart.ShowLegend;
    // autorange and other ranges
    achart.LeftAxis.Maximum := Series.HighValue;
    achart.LeftAxis.Minimum := Series.LowValue;
    achart.LeftAxis.Automatic := false;
    achart.LeftAxis.AutomaticMaximum := true;
    achart.LeftAxis.AutomaticMinimum := true;
    if (Series.AutoRange <> rpAutoRangeDefault) then
    begin
      case Series.AutoRange of
        rpAutoRangeUpper:
          achart.LeftAxis.AutomaticMinimum := false;
        rpAutoRangeLower:
          achart.LeftAxis.AutomaticMaximum := false;
        rpAutoRangeNone:
          begin
            achart.LeftAxis.AutomaticMinimum := false;
            achart.LeftAxis.AutomaticMaximum := false;
          end;
      end;
    end;
    achart.LeftAxis.LabelsAngle := nchart.VertFontRotation mod 360;
    if (nchart.VertFontSize > 0) then
      achart.LeftAxis.LabelsFont.Size :=
        Round(nchart.VertFontSize * nchart.Resolution / 100);
    achart.BottomAxis.LabelsAngle := nchart.HorzFontRotation mod 360;
    if (nchart.HorzFontSize > 0) then
      achart.BottomAxis.LabelsFont.Size :=
        Round(nchart.HorzFontSize * nchart.Resolution / 100);
{$IFDEF USEVARIANTS}
    achart.LeftAxis.Logarithmic := Series.Logaritmic;
    if achart.LeftAxis.Logarithmic then
      achart.LeftAxis.LogarithmicBase := Round(Series.LogBase);
{$ENDIF}
    achart.LeftAxis.Inverted := Series.Inverted;
    acolor := 0;
    for i := 0 to Series.Count - 1 do
    begin
      intserie := Series.Items[i];
      aserie := nil;
      if Length(intserie.functionName) > 0 then
      begin
        AddFunctionToChart(achart, UpperCase(intserie.functionName),
          intserie.functionParams, intserie.Caption);
        if (achart.SeriesCount>0) then        
         aserie:=achart.Series[achart.SeriesCount-1];
      end
      else
      begin
        case intserie.ChartType of
          rpchartline:
            begin
              aserie := TLineSeries.Create(nil);
            end;
          rpchartsplines:
            begin
              aserie := TLineSeries.Create(nil);
              TLineSeries(aserie).Smoothed := true;
            end;
          rpchartbar:
            begin
              aserie := TBarSeries.Create(nil);
              case nchart.MultiBar of
                rpMultiNone:
                  TBarSeries(aserie).MultiBar := mbNone;
                rpMultiside:
                  TBarSeries(aserie).MultiBar := mbSide;
                rpMultiStacked:
                  TBarSeries(aserie).MultiBar := mbStacked;
                rpMultiStacked100:
                  TBarSeries(aserie).MultiBar := mbStacked100;
              end;
            end;
          rpchartpoint:
            aserie := TPointSeries.Create(nil);
          rpcharthorzbar:
            aserie := THorizBarSeries.Create(nil);
          rpchartarea:
            aserie := TAreaSeries.Create(nil);
          rpchartpie:
            begin
              aserie := TPieSeries.Create(nil);
            end;
          rpchartarrow:
            aserie := TArrowSeries.Create(nil);
          rpchartbubble:
            aserie := TBubbleSeries.Create(nil);
          rpchartgantt:
            aserie := TGanttSeries.Create(nil);
{$IFDEF TEECHARTPRO}
          rpchartcandlestick:
            aserie := TCandleSeries.Create(nil);
          rpchartpyramid:
            aserie:= TPyramidSeries.Create(nil);
          rpchartpolar:
            aserie:= TPolarSeries.Create(nil);
          rpchartpointfigure:
            aserie:= TPointFigureSeries.Create(nil);
          rpchartfunnel:
            aserie:= TFunnelSeries.Create(nil);
          rpchartkagi:
            aserie:= TKagiSeries.Create(nil);
          rpchartdoughnut:
            aserie:= TDonutSeries.Create(nil);
          rpchartradar:
            aserie:= TRadarSeries.Create(nil);
          rpchartrenko:
            aserie:= TRenkoSeries.Create(nil);
          rpcharterrorbar:
            aserie:= TErrorBarSeries.Create(nil);
{$ENDIF}
          else
            raise Exception.Create('Tee Chart Pro Required for thischart Type');

        end;
      end;
      if not assigned(aserie) then
        exit;
      if Length(intserie.Caption) > 0 then
        aserie.Title := intserie.Caption;
      aserie.Marks.Font.Name := nchart.WFontName;
      aserie.Marks.Font.Size := afontsize;
      aserie.Marks.Font.Style := CLXIntegerToFontStyle(nchart.FontStyle);
      if Length(intserie.FunctionName) = 0 then
      begin
       aserie.Marks.Visible := nchart.ShowHint;
       aserie.Marks.Style := TSeriesMarksStyle(nchart.MarkStyle);
      end;
      aserie.ParentChart := achart;
      if intserie.Color >= 0 then
        aserie.SeriesColor := intserie.Color
      else
        aserie.SeriesColor := SeriesColors[acolor];
      // Assigns the color for this serie
      if Length(intserie.functionName) = 0 then
      begin
        for j := 0 to intserie.ValueCount - 1 do
        begin
          if intserie.ValueXCount > j then
          begin
            if Series.Count < 2 then
            begin
              if intserie.Colors[j] >= 0 then
                aserie.AddXY(intserie.ValuesX[j], intserie.Values[j],
                  intserie.ValueCaptions[j], intserie.Colors[j])
              else
                aserie.AddXY(intserie.ValuesX[j], intserie.Values[j],
                  intserie.ValueCaptions[j], SeriesColors[acolor]);
              if (nchart.ChartType in [rpchartpie,rpchartdoughnut]) or nchart.ShowLegend then
                acolor := ((acolor + 1) mod (MAX_SERIECOLORS));
            end
            else
            begin
              if intserie.Colors[j] >= 0 then
                aserie.AddXY(intserie.ValuesX[j], intserie.Values[j],
                  intserie.ValueCaptions[j], intserie.Colors[j])
              else
                aserie.AddXY(intserie.ValuesX[j], intserie.Values[j],
                  intserie.ValueCaptions[j], SeriesColors[acolor]);
            end;
          end
          else
          begin
            if Series.Count < 2 then
            begin
              if intserie.Colors[j] >= 0 then
                aserie.Add(intserie.Values[j], intserie.ValueCaptions[j],
                  intserie.Colors[j])
              else
                aserie.Add(intserie.Values[j], intserie.ValueCaptions[j],
                  SeriesColors[acolor]);
              if (nchart.ChartType in [rpchartpie,rpchartdoughnut]) or nchart.ShowLegend then
                acolor := ((acolor + 1) mod (MAX_SERIECOLORS));
            end
            else
            begin
              if intserie.Colors[j] >= 0 then
                aserie.Add(intserie.Values[j], intserie.ValueCaptions[j],
                  intserie.Colors[j])
              else
                aserie.Add(intserie.Values[j], intserie.ValueCaptions[j],
                  SeriesColors[acolor]);
            end;
          end;
          // achart.AddSeries(aserie);
        end;
      end;
      acolor := ((acolor + 1) mod (MAX_SERIECOLORS));
      abitmap := TBitmap.Create;
      try
{$IFNDEF DOTNETDBUGS}
        abitmap.HandleType := bmDIB;
        abitmap.PixelFormat := pf32bit;
{$ENDIF}
        // Chart resolution to default screen
        abitmap.Width := Round(twipstoinchess(nchart.PrintWidth) *
          nchart.Resolution);
        abitmap.Height := Round(twipstoinchess(nchart.PrintHeight) *
          nchart.Resolution);
        rec.Top := 0;
        rec.Left := 0;
        rec.Bottom := abitmap.Height - 1;
        rec.Right := abitmap.Width - 1;
        achart.Draw(abitmap.Canvas, rec);
        // Finally print it
        FMStream := TMemoryStream.Create;
        try
          abitmap.SaveToStream(FMStream);
          page.NewImageObject(aposy, aposx, nchart.PrintWidth,
            nchart.PrintHeight, DEF_COPYMODE, integer(rpDrawStretch),
            nchart.Resolution, FMStream, false);
        finally
          FMStream.free;
        end;
      finally
        abitmap.free;
      end;
      acolor := ((acolor + 1) mod MAX_SERIECOLORS);
    end;
  finally
    while achart.SeriesList.Count > 0 do
    begin
      TObject(achart.SeriesList.Items[0]).free;
    end;
    achart.free;
{$IFDEF DELPHI2009UP}
    nform.free;
{$ENDIF}
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TRpGDIDriver.DrawChart(Series: TRpSeries;
  ametafile: TRpMetafileReport; posx, posy: integer; achart: TObject);
begin
{$IFNDEF FORWEBAX}
{$IFDEF USETEECHART}
  DoDrawChart(Self, Series, ametafile.Pages[ametafile.CurrentPage], posx,
    posy, achart);
{$ENDIF}
{$IFNDEF USETEECHART}
  rppdfdriver.DoDrawChart(Self, Series, ametafile.Pages[ametafile.CurrentPage],
    posx, posy, achart);
{$ENDIF}
{$ENDIF}
end;

function AskBitmapProps(var HorzRes, VertRes: integer;
  var Mono: boolean): boolean;
var
  diarange: TFRpVCLProgress;
begin
  Result := false;
  diarange := TFRpVCLProgress.Create(Application);
  try
    diarange.Caption := SRpBitmapProps;
    diarange.BOK.Visible := true;
    diarange.GBitmap.Visible := true;
    diarange.EHorzRes.Text := IntToStr(HorzRes);
    diarange.EVertRes.Text := IntToStr(HorzRes);
    diarange.CheckMono.Checked := Mono;
    diarange.ActiveControl := diarange.BOK;
    diarange.showmodal;
    if diarange.dook then
    begin
      try
        HorzRes := StrToInt(diarange.EHorzRes.Text);
        VertRes := StrToInt(diarange.EVertRes.Text);
      except
      end;
      if HorzRes < 1 then
        HorzRes := 1;
      if VertRes < 1 then
        VertRes := 1;
      Mono := diarange.CheckMono.Checked;
      Result := true;
    end
  finally
    diarange.free;
  end;
end;

function TRpGDIDriver.GetFontDriver: TRpPrintDriver;
begin
  if assigned(FontDriver) then
    Result := FontDriver
  else
    Result := Self;
end;

{$IFNDEF FORWEBAX}
{$IFDEF EXTENDEDGRAPHICS}

procedure ExFilterImage(memstream: TMemoryStream);
var
  gclass: TGraphicExGraphicClass;
  bitmap: TBitmap;
  gpicture: TGraphicExGraphic;
  jpegimage: TJPegImage;
begin
  // Use graphicex library to obtain type and convert it to jpeg
  gclass := rpgraphicex.FileFormatList.GraphicFromContent(memstream);
  if (gclass = nil) then
    exit;
  memstream.Seek(0, soFromBeginning);
  gpicture := gclass.Create;
  try
    try
      gpicture.LoadFromStream(memstream);
      bitmap := TBitmap.Create;
      bitmap.PixelFormat := pf24bit;
      bitmap.Height := gpicture.Height;
      bitmap.Width := gpicture.Width;
      bitmap.Canvas.Draw(0, 0, gpicture);
      jpegimage := TJPegImage.Create;
      try
        jpegimage.CompressionQuality := 100;
        jpegimage.Assign(bitmap);
        memstream.Clear;
        jpegimage.SaveToStream(memstream);
      finally
        jpegimage.free;
      end;
    finally
      memstream.Seek(0, soFromBeginning);
    end;
  finally
    gpicture.free;
  end;
end;
{$ENDIF}
{$ENDIF}

end.
