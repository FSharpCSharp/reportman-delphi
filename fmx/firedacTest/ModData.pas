unit ModData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.MongoDBDef, FireDAC.Phys.ASADef,
  FireDAC.Phys.TDataDef, FireDAC.Phys.MSSQLDef, FireDAC.Phys.InfxDef,
  FireDAC.Phys.DB2Def, FireDAC.Phys.OracleDef,
  FireDAC.Phys.PGDef, FireDAC.Phys.ADSDef,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.ODBCDef,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.ODBC,
  FireDAC.Phys.MySQL, FireDAC.Phys.ADS, FireDAC.Phys.PG,
{$IFNDEF LINUX}
  FireDAC.Phys.TDBX, FireDAC.Phys.TDBXBase,
  FireDAC.Phys.MSAccDef,
  FireDAC.Phys.DS,
  FireDAC.Phys.MSAcc,
  FireDAC.Phys.DSDef, FireDAC.Phys.TDBXDef,
{$ENDIF}

  FireDAC.Phys.Oracle, FireDAC.Phys.DB2, FireDAC.Phys.Infx, FireDAC.Phys.MSSQL,
  FireDAC.Phys.TData, FireDAC.Phys.ODBCBase, FireDAC.Phys.ASA,
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.MongoDB, FireDAC.Phys.IBDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Phys.IB, FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.FMXUI.Login, FireDAC.FMXUI.Error,
  FireDAC.Stan.Error, FireDAC.Comp.UI;

type
  TDataModule1 = class(TDataModule)
    FDPhysMongoDriverLink1: TFDPhysMongoDriverLink;
    FDPhysASADriverLink1: TFDPhysASADriverLink;
    FDPhysTDataDriverLink1: TFDPhysTDataDriverLink;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDPhysInfxDriverLink1: TFDPhysInfxDriverLink;
    FDPhysDB2DriverLink1: TFDPhysDB2DriverLink;
    FDPhysOracleDriverLink1: TFDPhysOracleDriverLink;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDPhysADSDriverLink1: TFDPhysADSDriverLink;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDPhysODBCDriverLink1: TFDPhysODBCDriverLink;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
