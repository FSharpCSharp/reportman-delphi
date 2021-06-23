{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfdesignvcl                                  }
{       Design frame of the Main form                   }
{       Used by a subreport                             }
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

unit rpmdfdesignvcl;

interface

{$I rpconf.inc}

uses
  SysUtils,
{$IFDEF USEVARIANTS}
  Types,
{$ENDIF}
  Classes,
  Graphics, Controls, Forms, Dialogs, Menus,
  ExtCtrls,Windows,Messages,
  rpmdfstrucvcl,rpmdobinsintvcl,rpgraphutilsvcl,
  rpmdfsectionintvcl,rpmdobjinspvcl,rprulervcl,
  rpsubreport,rpsection,rpreport,rpmunits;

type
  TRpPaintEventPanel=class;

  TFRpDesignFrameVCL = class(TFrame)
    PTop: TPanel;
    PLeft: TPanel;
  private
    { Private declarations }
    panelheight:integer;
    PSection: TRpPaintEventPanel;
    FReport:TRpReport;
    FObjInsp:TFRpObjInspVCL;
    leftrulers:Tlist;
    FSubReport:TRpSubreport;
    toptitles:Tlist;
    righttitles:Tlist;
    FScale:double;
    CONS_RULER_LEFT: integer;
    CONS_RIGHTPWIDTH: integer;
    procedure SetReport(Value:TRpReport);
    procedure SecPosChange(Sender:TObject);
    procedure SetScale(nvalue:double);
  public
    { Public declarations }
    freportstructure:TFRpStructureVCL;
    SectionScrollBox: TScrollBox;
    secinterfaces:TList;
    TopRuler:TRpRulerVCL;
    procedure InvalidateCaptions;
    procedure UpdateInterface(refreshobjinsp:boolean);
    procedure ShowAllHiden;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure UpdateSelection(force:boolean);
    procedure SelectSubReport(subreport:TRpSubReport);
    property Report:TRpReport read FReport write SetReport;
    property ObjInsp:TFRpObjInspVCL read FObjInsp write FObjInsp;
    property Scale:double read FScale write SetScale;
    property CurrentSubreport:TRpSubReport read FSubReport;
  end;

  // A ScrollBox that not scrolls in view focused controls
  TRpScrollBox=class(TScrollBox)
   protected
    procedure AutoScrollInView(AControl: TControl); override;
   end;


  TRpPanelRight=Class(TPanel)
   private
    FFrame:TFRpDesignFrameVCL;
    FRectangle:TRpRectangle;
    FRectangle2:TRpRectangle;
    FRectangle3:TRpRectangle;
    FRectangle4:TRpRectangle;
    FXOrigin,FYOrigin:integer;
    FBlocked:boolean;
   protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure Paint;override;
   public
    Section:TRpSection;
    constructor Create(AOwner:TComponent);override;
   end;

  TRpPaintEventPanel=Class(TPanel)
   private
    FOnPaint:TNotifyEvent;
    Updating:boolean;
    FOnPosChange:TNotifyEvent;
    FFrame:TFRpDesignFrameVCL;
    FRectangle:TRpRectangle;
    FRectangle2:TRpRectangle;
    FRectangle3:TRpRectangle;
    FRectangle4:TRpRectangle;
    FXOrigin,FYOrigin:integer;
    FBlocked:boolean;
    allowselect:Boolean;
   protected
    procedure Paint;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure DoPosChange(var Msg:TMessage);message WM_MOVE;
   public
    CaptionText:WideString;
    section:TRpSection;
    constructor Create(AOwner:TComponent);override;
    property OnPaint:TNotifyEvent read FOnPaint write FOnPaint;
    property OnPosChange:TNotifyEvent read FOnPosChange write FOnPosChange;
   end;



implementation

{$R *.dfm}

uses rpmdfmainvcl;

procedure TrpScrollBox.AutoScrollInView(AControl: TControl);
begin

end;


constructor TrpPaintEventPanel.Create(AOwner:TComponent);
var
 opts:TControlStyle;
begin
 Inherited Create(AOwner);

 BevelInner:=bvNone;
 BevelOuter:=bvNone;
 BorderStyle:=bsNone;
 allowselect:=true;

 opts:=ControlStyle;
 include(opts,csCaptureMouse);
 ControlStyle:=opts;

end;



procedure TRpPaintEventPanel.DoPosChange(var Msg:TMessage);
begin
 inherited;
 
 if Assigned(FOnPosChange) then
  FOnPosChange(Self);
end;

procedure TRpPaintEventPanel.Paint;
var
 rec:TRect;
 secint:TRpSectionInterface;
begin
 inherited Paint;

 if not updating then
 begin
  if Assigned(FOnPaint) then
   FOnPaint(Self);
 end;

 if not assigned(parent) then
  exit;

 rec:=ClientRect;
 Canvas.Brush.Color:=Color;

 secint:=nil;
 if FFrame.objinsp.SelectedItems.Count>0 then
  if (FFrame.ObjInsp.SelectedItems.Objects[0] is TRpSectionInterface) then
   secint:=TRpSectionInterface(FFrame.objinsp.CompItem)
  else
   secint:=TRpSectionInterface(TRpSizePosInterface(FFrame.objinsp.SelectedItems.Objects[0]).SectionInt);

 if assigned(Section) then
  if assigned(secint) then
   if section=secint.printitem then
    if allowselect then
     Canvas.Brush.Color:=clAppWorkSpace;
 Canvas.Rectangle(rec);
 if (parent.parent is TScrollBox) then
 begin
  Canvas.Brush.Style:=bsClear;
  Canvas.TextOut(TScrollBox(parent.parent).HorzScrollBar.Position,0,CaptionText);
 end;
end;




constructor TFRpDesignFrameVCL.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FScale:=1.0;
 TopRuler:=TRpRulerVCL.Create(Self);
 TopRuler.Rtype:=rHorizontal;
 CONS_RIGHTPWIDTH:=ScaleDPI(5);
 CONS_RULER_LEFT:=ScaleDpi(20);
 TopRuler.Left:=CONS_RULER_LEFT;
 TopRuler.Width:=ScaleDpi(389);
 TopRuler.Height:=ScaleDpi(20);
 TopRuler.Parent:=PTop;

// panelheight:=Round(1.3*Font.Size/72*Screen.PixelsPerInch);
 panelheight:=Round(1.3*Font.Size*96/72);
 SectionScrollBox:=TRpScrollBox.Create(Self);
 SectionScrollBox.BorderStyle:=bsNone;
 SectionScrollBox.Color:=clAppWorkSpace;
 SectionScrollBox.Align:=Alclient;
 SectionScrollBox.HorzScrollBar.Tracking:=True;
 SectionScrollBox.VertScrollBar.Tracking:=True;

 SectionScrollBox.Parent:=Self;



 leftrulers:=Tlist.Create;
 toptitles:=Tlist.Create;
 righttitles:=Tlist.Create;
 secinterfaces:=TList.Create;

 PSection:=TRpPaintEventPanel.Create(Self);
 PSection.allowselect:=False;
 PSection.FFrame:=Self;
 PSection.Color:=clAppWorkSpace;
 PSection.Parent:=SectionSCrollBox;
 PSection.OnPosChange:=SecPosChange;
end;


procedure TFRpDesignFrameVCL.SetScale(nvalue:double);
var
 i:integer;
 subrep:TRpSubReport;
begin
 FScale:=nvalue;
 TopRuler.Scale:=FScale;
 for i:=0 to leftrulers.Count-1 do
 begin
  TRpRulerVCL(leftrulers.Items[i]).Scale:=FScale;
 end;
 if Assigned(FReport) then
 begin
  subrep:=CurrentSubReport;
  SelectSubReport(nil);
  SelectSubReport(subrep);
 end;
end;


destructor TFRpDesignFrameVCL.Destroy;
begin
 leftrulers.free;
 toptitles.free;
 righttitles.free;
 secinterfaces.free;

 inherited Destroy;
end;


procedure TFRpDesignFrameVCL.SetReport(Value:TRpReport);
begin
 FReport:=Value;
 if Not Assigned(FReport) then
  exit;
 SelectSubReport(Freport.SubReports[0].SubReport);
 UpdateSelection(false);
end;



procedure TFRpDesignFrameVCL.UpdateSelection(force:boolean);
var
 dataobj:TOBject;
 FSectionInterface:TRpSectionInterface;
 i:integer;
 asubreport:TRpSubReport;
begin
 if Not Assigned(freportstructure) then
  exit;
 if Not Assigned(freportstructure.RView.Selected) then
  exit;
 if Not Assigned(freportstructure.RView.Selected.Data) then
  exit;
 if force then
 begin
  SelectSubReport(nil);
 end;

 dataobj:=TObject(freportstructure.RView.Selected.Data);
 // Looks if there is a subreport selected
 asubreport:=freportstructure.FindSelectedSubreport;
 if asubreport<>FSubReport then
 begin
  SelectSubReport(asubreport);
 end;
 if (dataobj is TRpSubReport) then
 begin
  if assigned(fobjinsp) then
  begin
   fobjinsp.AddCompItem(nil,true);
  end;
  exit;
 end;
 if (dataobj is TRpSection) then
 begin
  i:=0;
  FSectionInterface:=nil;
  while i<secinterfaces.count do
  begin
   if TRpSectionInterface(secinterfaces.items[i]).printitem=dataobj then
   begin
    FSectionInterface:=TRpSectionInterface(secinterfaces.items[i]);
    break;
   end;
   inc(i);
  end;
  if Assigned(FSectionInterface) then
   fobjinsp.AddCompItem(FSectionInterface,true);
 end;
end;


procedure TFRpDesignFrameVCL.SecPosChange(Sender:TObject);
var
 i:integer;
 aruler:TRpRulerVCL;
 despy:integer;
 apanel:TRpPaintEventPanel;
begin
 TopRuler.Left:=CONS_RULER_LEFT-SectionScrollBox.HorzScrollBar.Position;;
 for i:=0 to leftrulers.count-1 do
 begin
  despy:=SectionScrollBox.VertScrollBar.Position;
  aruler:=TRpRulerVCL(leftrulers.items[i]);
  aruler.Top:=TRpSectionInterface(secinterfaces.Items[i]).Top-despy;
  apanel:=TRpPaintEventPanel(toptitles.Items[i]);
  apanel.Updating:=true;
  try
   apanel.Invalidate;
   apanel.Update;
  finally
   apanel.Updating:=false;
  end;
 end;
end;

procedure TFRpDesignFrameVCL.InvalidateCaptions;
var
 apanel:TRpPaintEventpanel;
 i:integer;
begin
 for i:=0 to toptitles.count-1 do
 begin
  apanel:=TRpPaintEventpanel(toptitles.Items[i]);
  if i<FSubReport.Sections.Count then
   apanel.CaptionText:=' '+FSubReport.Sections.Items[i].Section.SectionCaption(false);
  apanel.Invalidate;
 end;
end;


procedure TFRpDesignFrameVCL.SelectSubReport(subreport:TRpSubReport);
var
 i:integer;
 asecint:TRpSectionInterface;
 apanel:TRpPaintEventpanel;
 rpanel:TRpPanelRight;
 aruler:TRpRulerVCL;
 posx:integer;
 maxwidth:integer;
 oldsection:TRpSection;
begin
 // If subreport is not the same frees
 if Fsubreport=subreport then
  exit;
 Visible:=false;
 try
 oldsection:=nil;
 if assigned(fsubreport) then
 begin
  fobjinsp.ClearMultiselect;
  for i:=0 to secinterfaces.Count-1 do
  begin
   TRpSectionInterface(secinterfaces.Items[i]).Free;
   TPanel(TopTitles.Items[i]).Free;
   TPanel(RightTitles.Items[i]).Free;
   TRpRulerVCL(LeftRulers.Items[i]).Free;
  end;
  TPanel(TopTitles.Items[secinterfaces.Count]).Free;

  secinterfaces.clear;
  toptitles.clear;
  righttitles.clear;
  leftrulers.Clear;
 end;
 Fsubreport:=subreport;
 FObjInsp.RecreateChangesize;
 fobjinsp.AddCompItem(nil,true);
 if not assigned(fsubreport) then
  exit;
 SectionScrollBox.Visible:=true;
 try
  maxwidth:=0;
  posx:=0;
  for i:=0 to fsubreport.Sections.Count-1 do
  begin
   apanel:=TRpPaintEventPanel.Create(self);
   apanel.FFrame:=Self;
   if i=0 then
    apanel.Cursor:=crArrow
   else
    apanel.Cursor:=crSizeNS;
   apanel.OnPaint:=SecPosChange;
   apanel.Height:=panelheight;
   apanel.Caption:='';
   apanel.CaptionText:=' '+FSubReport.Sections.Items[i].Section.SectionCaption(false);
   apanel.Alignment:=taLeftJustify;
   apanel.BorderStyle:=bsNone;
   apanel.BevelInner:=bvNone;
   apanel.BevelOuter:=bvNone;
   apanel.Top:=posx;
   apanel.section:=FSubReport.Sections.Items[i].Section;
   oldsection:=apanel.section;
   posx:=posx+apanel.Height;
   apanel.parent:=PSection;
   toptitles.Add(apanel);



   asecint:=TRpSectionInterface.Create(Self,fsubreport.Sections.Items[i].Section);
   asecint.Scale:=Scale;
   asecint.OnPosChange:=SecPosChange;
   asecint.fobjinsp:=FObjInsp;
   asecint.freportstructure:=freportstructure;
   asecint.Left:=0;
   asecint.Top:=posx;
   asecint.UpdatePos;
   asecint.Parent:=PSection;
   asecint.CreateChilds;
   asecint.UpdatePos;
   secinterfaces.Add(asecint);

   apanel.Width:=asecint.Width;


   rpanel:=TRpPanelRight.Create(self);
   rpanel.FFrame:=Self;
   rpanel.Height:=asecint.Height;
   rpanel.Left:=asecint.Width;
   rpanel.Caption:='';
   rpanel.Top:=posx;
   rpanel.Width:=CONS_RIGHTPWIDTH;
   rpanel.section:=oldsection;
   rpanel.parent:=PSection;
   righttitles.Add(rpanel);


   aruler:=TRpRulerVCL.Create(Self);
   aruler.RType:=rVertical;
   aruler.Width:=20;
   aruler.Left:=0;
   aruler.Scale:=Scale;
   aruler.parent:=PLeft;
   leftrulers.Add(aruler);
   aruler.Top:=posx;
   aruler.Height:=asecint.Height;
   if rpmunits.defaultunit=rpUnitCms then
    aruler.Metrics:=rCms
   else
    aruler.Metrics:=rInchess;

   if maxwidth<asecint.width then
    maxwidth:=asecint.width;
   posx:=posx+asecint.Height;

  end;
  // Last panel for resizing only
  apanel:=TRpPaintEventPanel.Create(self);
  apanel.allowselect:=false;
  apanel.FFrame:=Self;
  apanel.Cursor:=crSizeNS;
  apanel.OnPaint:=SecPosChange;
  apanel.Height:=panelheight div 3;
  apanel.Caption:='';
  apanel.CaptionText:='';
  apanel.Alignment:=taLeftJustify;
  apanel.BorderStyle:=bsNone;
  apanel.BevelInner:=bvNone;
  apanel.BevelOuter:=bvNone;
  apanel.Top:=posx;
  apanel.width:=oldsection.width;
  apanel.section:=oldsection;
  posx:=posx+apanel.Height;
  apanel.parent:=PSection;
  toptitles.Add(apanel);



  for i:=0 to secinterfaces.Count-1 do
  begin
   asecint:=TRpSectionInterface(secinterfaces.items[i]);
   asecint.SendToBack;
  end;
  TopRuler.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
  if rpmunits.defaultunit=rpUnitCms then
   TopRuler.Metrics:=rCms
  else
   TopRuler.Metrics:=rInchess;
  PSection.Height:=posx+Height;
  PSection.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
 finally
  SectionScrollBox.Visible:=true;
 end;
 SectionScrollBox.VertScrollBar.Position:=0;
 SectionScrollBox.HorzScrollBar.Position:=0;
 finally
  Visible:=true;
 end;
end;


procedure TFRpDesignFrameVCL.UpdateInterface(refreshobjinsp:boolean);
var
 i,j:integer;
 asecint:TRpSectionInterface;
 apanel:TRpPaintEventpanel;
 rpanel:TRpPanelRight;
 aruler:TRpRulerVCL;
 posx:integer;
 maxwidth:integer;
 oldxposition,oldyposition:integer;
begin
 if not Assigned(FSubreport) then
  exit;
 oldxposition:=SectionScrollBox.HorzScrollBar.Position;
 oldyposition:=SectionScrollBox.VertScrollBar.Position;
 SectionScrollBox.Visible:=false;
 try
  SectionScrollBox.HorzScrollBar.Position:=0;
  SectionScrollBox.VertScrollBar.Position:=0;
  maxwidth:=0;
  posx:=0;
  asecint:=nil;
  for i:=0 to secinterfaces.Count-1 do
  begin
   apanel:=TRpPaintEventpanel(toptitles.Items[i]);
   asecint:=TRpSectionInterface(secinterfaces.items[i]);
   asecint.UpdateBack;
   rpanel:=TRpPanelRight(Righttitles.Items[i]);
   apanel.Color:=clBtnFace;

   apanel.Width:=asecint.Width;
   apanel.Caption:='';
   apanel.CaptionText:=' '+FSubReport.Sections.Items[i].Section.SectionCaption(false);
   apanel.Top:=posx;
   posx:=posx+apanel.Height;


   asecint.Top:=posx;
   asecint.UpdatePos;
   for j:=0 to asecint.childlist.Count-1 do
   begin
    TRpSizePosInterface(asecint.childlist.Items[j]).UpdatePos;
   end;
   apanel.Width:=asecint.Width;
   rpanel.Top:=posx;
   rpanel.Height:=asecint.Height;
   rpanel.Left:=asecint.Width;

   aruler:=TRpRulerVCL(leftrulers.items[i]);
   aruler.Top:=posx;
   aruler.Height:=asecint.Height;
   if rpmunits.defaultunit=rpUnitCms then
    aruler.Metrics:=rCms
   else
    aruler.Metrics:=rInchess;

   if maxwidth<asecint.width then
    maxwidth:=asecint.width;
   posx:=posx+asecint.Height;
   asecint.SendToBack;
   if ObjInsp.CompItem=asecint then
    if refreshobjinsp then
     ObjInsp.AddCompItem(asecint,true);
  end;
  apanel:=TRpPaintEventpanel(toptitles.Items[secinterfaces.Count]);
  apanel.Width:=asecint.Width;
  apanel.Caption:='';
  apanel.Top:=posx;
  posx:=posx+apanel.Height;

  TopRuler.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
  if rpmunits.defaultunit=rpUnitCms then
   TopRuler.Metrics:=rCms
  else
   TopRuler.Metrics:=rInchess;
 finally
  SectionScrollBox.Visible:=true;
 end;
 SectionScrollBox.HorzScrollBar.Position:=oldxposition;
 SectionScrollBox.VertScrollBar.Position:=oldyposition;
 PSection.Height:=posx+Height;
 PSection.Width:=maxwidth*2+CONS_RIGHTPWIDTH;
end;

procedure TFRpDesignFrameVCL.ShowAllHiden;
var
 asecint:TRpSectionInterface;
 aposint:TRpSizePosInterface;
 i,j:integer;
begin
 for i:=0 to secinterfaces.Count-1 do
 begin
  asecint:=TRpSectionInterface(secinterfaces.items[i]);
  for j:=0 to asecint.childlist.Count-1 do
  begin
   aposint:=TRpSizePosInterface(asecint.childlist.items[j]);
   aposint.Visible:=true;
   aposint.PrintItem.Visible:=true;
  end;
 end;
end;


procedure TRpPaintEventPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
 inherited MouseDown(Button,Shift,X,Y);

 if cursor<>crSizeNS then
  exit;
 if Not Assigned(FRectangle) then
 begin
  FRectangle:=TRpRectangle.Create(Self);
  FRectangle2:=TRpRectangle.Create(Self);
  FRectangle3:=TRpRectangle.Create(Self);
  FRectangle4:=TRpRectangle.Create(Self);

  FRectangle.SetBounds(Left,Top,Width,1);
  FRectangle2.SetBounds(Left,Top+Height,Width,1);
  FRectangle3.SetBounds(Left,Top,1,Height);
  FRectangle4.SetBounds(Left+Width,Top,1,Height);

  FRectangle.Parent:=Parent;
  FRectangle2.Parent:=Parent;
  FRectangle3.Parent:=Parent;
  FRectangle4.Parent:=Parent;
 end;


 FXOrigin:=X;
 FYOrigin:=Y;
 FBlocked:=True;
end;

procedure TRpPaintEventPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 NewLeft,NewTop:integer;
 i,MaxY:integer;
begin
 inherited MouseMove(Shift,X,Y);

 if MouseCapture then
 begin
  if ((Abs(X-FXOrigin)>CONS_MINIMUMMOVE) OR
    (Abs(Y-FYOrigin)>CONS_MINIMUMMOVE)) then
     FBlocked:=False;

  if Assigned(FRectangle) AND (Not FBlocked) then
  begin
   // Look the last panel
   i:=0;
   while i<FFrame.toptitles.count do
   begin
    if FFrame.toptitles.Items[i]=Self then
    begin
     dec(i);
     break;
    end;
    inc(i);
   end;
   MaxY:=TRpPaintEventPanel(FFrame.toptitles.Items[i]).Top+
    TRpPaintEventPanel(FFrame.toptitles.Items[i]).Height;

   NewLeft:=0;
   NewTop:=Top-FYOrigin+Y;
   if NewTop<0 then
    NewTop:=0;
   if NewTop+Height>Parent.Height then
    NewTop:=Parent.Height-Height;
   if NewTop<0 then
    NewTop:=0;
   if NewTop<MaxY then
    NewTop:=MaxY;
   FRectangle.SetBounds(Newleft,NewTop,Parent.Width,1);
   FRectangle2.SetBounds(Newleft,NewTop+Height,Parent.Width,1);
   FRectangle3.SetBounds(Newleft,NewTop,1,Height);
   FRectangle4.SetBounds(Newleft+Parent.Width,NewTop,1,Height);
   FRectangle.Parent.Update;
  end;
 end;
end;

procedure TRpPaintEventPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 NewTop:integer;
 i,MaxY:integer;
 asection:TRpSection;
 dframe:TFRpDesignFrameVCL;
begin
 inherited MouseUp(Button,Shift,X,Y);

 if Assigned(FRectangle) then
 begin
  FRectangle.Free;
  FRectangle:=nil;
  FRectangle2.Free;
  FRectangle:=nil;
  FRectangle3.Free;
  FRectangle:=nil;
  FRectangle4.Free;
  FRectangle:=nil;


  // Look the last panel
  i:=0;
  while i<FFrame.toptitles.count do
  begin
   if FFrame.toptitles.Items[i]=Self then
   begin
    dec(i);
    break;
   end;
   inc(i);
  end;
  MaxY:=TRpPaintEventPanel(FFrame.toptitles.Items[i]).Top+
   TRpPaintEventPanel(FFrame.toptitles.Items[i]).Height;
  asection:=TRpPaintEventPanel(FFrame.toptitles.Items[i]).Section;
  // New position
  NewTop:=Top-FYOrigin+Y;
  if NewTop<0 then
   NewTop:=0;
  if NewTop+Height>Parent.Height then
   NewTop:=Parent.Height-Height;
  if NewTop<MaxY then
   NewTop:=MaxY;
  // Resize with the diference
  if NewTop<>Top then
  begin
   asection.Height:=pixelstotwips(NewTop-MaxY,FFrame.Scale);
   if asection.Height=0 then
    asection.Height:=0;
   FFrame.UpdateInterface(true);
  end;
 end;
 if allowselect then
 begin
  dframe:=TFRpDesignFrameVCL(Owner);
  dframe.freportstructure.SelectDataItem(section);
 end;
end;

constructor TRpPanelRight.Create(AOwner:TComponent);
var
 opts:TControlStyle;
begin
 inherited Create(AOwner);

 BevelInner:=bvNone;
 BevelOuter:=bvNone;
 BorderStyle:=bsNone;
 Cursor:=crSizeWE;

 opts:=ControlStyle;
 include(opts,csCaptureMouse);
 ControlStyle:=opts;
end;

procedure TRpPanelRight.Paint;
var
 rec:TRect;
begin
 inherited Paint;

 if not assigned(parent) then
  exit;

 rec:=ClientRect;
 Canvas.Brush.Color:=Color;

 Canvas.Rectangle(rec);
end;


procedure TRpPanelRight.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
begin
 if Not Assigned(FRectangle) then
 begin
  FRectangle:=TRpRectangle.Create(Self);
  FRectangle2:=TRpRectangle.Create(Self);
  FRectangle3:=TRpRectangle.Create(Self);
  FRectangle4:=TRpRectangle.Create(Self);

  FRectangle.SetBounds(Left,Top,Width,1);
  FRectangle2.SetBounds(Left,Top+Height,Width,1);
  FRectangle3.SetBounds(Left,Top,1,Height);
  FRectangle4.SetBounds(Left+Width,Top,1,Height);

  FRectangle.Parent:=Parent;
  FRectangle2.Parent:=Parent;
  FRectangle3.Parent:=Parent;
  FRectangle4.Parent:=Parent;
 end;


 FXOrigin:=X;
 FYOrigin:=Y;
 FBlocked:=True;
end;

procedure TRpPanelRight.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 NewLeft,NewTop:integer;
begin
 inherited MouseMove(Shift,X,Y);

 if MouseCapture then
 begin
  if ((Abs(X-FXOrigin)>CONS_MINIMUMMOVE) OR
    (Abs(Y-FYOrigin)>CONS_MINIMUMMOVE)) then
     FBlocked:=False;

  if Assigned(FRectangle) AND (Not FBlocked) then
  begin
   NewLeft:=Left-FXOrigin+X;
   NewTop:=Top;
   if NewLeft<0 then
    NewLeft:=0;
   FRectangle.SetBounds(Newleft,NewTop,Width,1);
   FRectangle2.SetBounds(Newleft,NewTop+Height,Width,1);
   FRectangle3.SetBounds(Newleft,NewTop,1,Height);
   FRectangle4.SetBounds(Newleft+Width,NewTop,1,Height);
   FRectangle.Parent.Update;
  end;
 end;
end;

procedure TRpPanelRight.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 NewLeft:integer;
begin
 inherited MouseUp(Button,Shift,X,Y);

 if Assigned(FRectangle) then
 begin
  FRectangle.Free;
  FRectangle:=nil;
  FRectangle2.Free;
  FRectangle:=nil;
  FRectangle3.Free;
  FRectangle:=nil;
  FRectangle4.Free;
  FRectangle:=nil;
  // New position
  NewLeft:=Left-FXOrigin+X;
  if NewLeft<0 then
   NewLeft:=0;
  if NewLeft+Width>Parent.Width then
   NewLeft:=Parent.Width-Width;
  if NewLeft<0 then
   NewLeft:=0;

  section.Width:=pixelstotwips(NewLeft,FFrame.Scale);

  FFrame.UpdateInterface(true);
 end;
end;

end.
