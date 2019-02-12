unit rppanel;

interface

uses Classes,Windows,Graphics,VCL.ExtCtrls,Controls;

type
 TRpPanel=Class(Vcl.ExtCtrls.TPanel)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner:TComponent);override;
  End;

implementation

Uses
  Vcl.Styles,
  Vcl.Themes;

constructor TRpPanel.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
end;

procedure TRpPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
  VerticalAlignments: array[TVerticalAlignment] of Longint = (DT_TOP, DT_BOTTOM, DT_VCENTER);
var
  Rect: TRect;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  TopColor        : TColor;
  BottomColor     : TColor;
  LBaseColor      : TColor;
  LBaseTopColor   : TColor;
  LBaseBottomColor: TColor;
  Flags: Longint;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := LBaseTopColor;
    if Bevel = bvLowered then
      TopColor := LBaseBottomColor;
    BottomColor := LBaseBottomColor;
    if Bevel = bvLowered then
      BottomColor := LBaseTopColor;
  end;

begin
  Rect := GetClientRect;

  LBaseColor := Color;//use the color property value to get the background color.
  LBaseTopColor := clBtnHighlight;
  LBaseBottomColor := clBtnShadow;
  LStyle := StyleServices;
  if LStyle.Enabled then
  begin
    LDetails := LStyle.GetElementDetails(tpPanelBevel);
    if LStyle.GetElementColor(LDetails, ecEdgeHighLightColor, LColor) and (LColor <> clNone) then
      LBaseTopColor := LColor;
    if LStyle.GetElementColor(LDetails, ecEdgeShadowColor, LColor) and (LColor <> clNone) then
      LBaseBottomColor := LColor;
  end;

  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  if not (LStyle.Enabled and (csParentBackground in ControlStyle)) then
    Frame3D(Canvas, Rect, LBaseColor, LBaseColor, BorderWidth)
  else
    InflateRect(Rect, -Integer(BorderWidth), -Integer(BorderWidth));
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  with Canvas do
  begin
    //if not LStyle.Enabled or not ParentBackground then
    begin
      //Brush.Color := LBaseColor;
      Brush.Color := LBaseColor;
      FillRect(Rect);
    end;

    if ShowCaption and (Caption <> '') then
    begin
      Brush.Style := bsClear;
      Font := Self.Font;
      Flags := DT_EXPANDTABS or DT_SINGLELINE or
        VerticalAlignments[VerticalAlignment] or Alignments[Alignment];
      Flags := DrawTextBiDiModeFlags(Flags);
      if LStyle.Enabled then
      begin
        LDetails := LStyle.GetElementDetails(tpPanelBackground);
        if not LStyle.GetElementColor(LDetails, ecTextColor, LColor) or (LColor = clNone) then
          LColor := Font.Color;
        LStyle.DrawText(Handle, LDetails, Caption, Rect, TTextFormatFlags(Flags), LColor)
      end
      else
        DrawText(Handle, Caption, -1, Rect, Flags);
    end;
  end;
end;

end.
