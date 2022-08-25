unit FMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.ODBC, FireDAC.Phys.ODBCDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FMX.Memo.Types, FMX.Memo, FMX.StdCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ScrollBox, FMX.Grid, FMX.Controls3D, FMX.Layers3D,
  FMX.TabControl, FMX.Controls.Presentation, Datasnap.Provider,
  Datasnap.DBClient, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Layout3D1: TLayout3D;
    Grid1: TGrid;
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDQuery1: TFDQuery;
    ButtonConnect: TButton;
    Panel1: TPanel;
    Button1: TButton;
    MemoSQL: TMemo;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    DataSource1: TDataSource;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure ButtonConnectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
 FDQuery1.SQL.Text := MemoSQL.Text;
 ClientDataSet1.Active:=false;
 ClientDataSet1.Active:=true;
 TabControl1.ActiveTab := TabItem3;
end;

procedure TForm1.ButtonConnectClick(Sender: TObject);
begin
 FDConnection1.Close;
 FDConnection1.Open;
 TabControl1.ActiveTab := TabItem2;
end;

end.
