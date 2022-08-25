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
  Data.Bind.DBScope, FMX.ListBox, FireDAC.FMXUI.Login, FireDAC.FMXUI.Error,
  FireDAC.Comp.UI,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.ADSDef, FireDAC.Phys.FBDef, FireDAC.Phys.PGDef,
  FireDAC.Phys.IBDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.OracleDef, FireDAC.Phys.DB2Def, FireDAC.Phys.InfxDef,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.TDataDef, FireDAC.Phys.ASADef,
  FireDAC.Phys.MongoDBDef, FireDAC.Phys.MongoDB, FireDAC.Phys.ASA,
  FireDAC.Phys.TData, FireDAC.Phys.MSSQL, FireDAC.Phys.Infx, FireDAC.Phys.DB2,
  FireDAC.Phys.Oracle,
  FireDAC.Phys.SQLite, FireDAC.Phys.IB, FireDAC.Phys.PG,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.ADS, FireDAC.Phys.MySQL,
  FireDAC.Phys.ODBCBase;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    FDConnection1: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDQuery1: TFDQuery;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    DataSource1: TDataSource;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Layout3D1: TLayout3D;
    ButtonConnect: TButton;
    Panel1: TPanel;
    ComboDriver: TComboBox;
    Label2: TLabel;
    TabItem2: TTabItem;
    Button1: TButton;
    MemoSQL: TMemo;
    TabItem3: TTabItem;
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    MemoParams: TMemo;
    Panel2: TPanel;
    CheckCreateParams: TCheckBox;
    CheckCreateMacros: TCheckBox;
    CheckExpandParams: TCheckBox;
    CheckExpandMacros: TCheckBox;
    CheckExpandEscapes: TCheckBox;
    CheckUnifyParams: TCheckBox;
    procedure ButtonConnectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
 if (not FDConnection1.Connected) then
 begin
   raise Exception.Create('Go to Connection tab and connect database before opening the dataset.');
 end;
 FDQuery1.Close;
 FDQuery1.SQL.Text := '';
 FDQuery1.Params.Clear;
 FDQuery1.ResourceOptions.EscapeExpand :=   CheckExpandParams.IsChecked;
 FDQuery1.ResourceOptions.ParamCreate :=   CheckCreateParams.IsChecked;
 FDQuery1.ResourceOptions.ParamExpand :=   CheckExpandParams.IsChecked;
 FDQuery1.ResourceOptions.UnifyParams :=   CheckUnifyParams.IsChecked;
 FDQuery1.ResourceOptions.MacroCreate :=   CheckCreateMacros.IsChecked;
 FDQuery1.ResourceOptions.MacroExpand :=   CheckExpandMacros.IsChecked;
 FDQuery1.SQL.Text := MemoSQL.Text;

 ClientDataSet1.Active:=false;
 ClientDataSet1.Active:=true;
 TabControl1.ActiveTab := TabItem3;
end;

procedure TForm1.ButtonConnectClick(Sender: TObject);
begin
 FDConnection1.DriverName:=ComboDriver.Items[ComboDriver.ItemIndex];
 FDConnection1.Params.Text := MemoParams.Text;
 FDConnection1.Params.AddPair('DriverId',ComboDriver.Items[ComboDriver.ItemIndex]);
 FDConnection1.Close;
 FDConnection1.Open;
 TabControl1.ActiveTab := TabItem2;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 TabControl1.ActiveTab:=TabControl1.Tabs[0];
 ComboDriver.ItemIndex := 12;
 MemoParams.Text := FDConnection1.Params.Text;

end;

end.
