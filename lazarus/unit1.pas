unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, PrintersDlgs,  Forms, Controls,
  Graphics, Dialogs, StdCtrls, rppdfreport, rplclreport,Printers;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DateTimePicker1: TDateTimePicker;
    LCLReport1: TLCLReport;
    PDFReport1: TPDFReport;
    PrintDialog1: TPrintDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  PDFReport1.Filename:='c:\datos\test.rep';
  PDFReport1.PDFFilename:='c:\datos\test.pdf';
  {$ENDIF}
  {$IFDEF LINUX}
  PDFReport1.Filename:='/home/toni/prog/reportman/lazarus/test.rep';
  PDFReport1.PDFFilename:='/home/toni/prog/test.pdf';
  {$ENDIF}
  PDFReport1.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    {$IFDEF MSWINDOWS}
  LCLReport1.Filename:='c:\datos\test.rep';
  LCLReport1.PDFFilename:='c:\datos\test.pdf';
  {$ENDIF}
  {$IFDEF LINUX}
  LCLReport1.Filename:='/home/toni/prog/reportman/lazarus/test.rep';
  LCLReport1.Preview:=true;
  {$ENDIF}
  LCLReport1.Execute;

end;

end.

