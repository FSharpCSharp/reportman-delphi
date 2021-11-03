{*******************************************************}
{                                                       }
{       Rptparser                                       }
{       Expression parser for TRpEvaluator              }
{       Report Manager                                  }
{                                                       }
{       Copyright (c) 1994-2019 Toni Martir             }
{       toni@reportman.es                               }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpparser;

{$I rpconf.inc}

interface


uses Classes,sysutils,
 rpmdconsts,rptypeval, System.Character;
type


  TRpParser = class(TObject)
  private
    FNewExpression:string;
    FOrigin: Longint;
    FBuffer: array of char;
    FBufPtr: Integer;
    FBufEnd: Integer;
    FSourcePtr: Integer;
    FSourceEnd: Integer;
    FTokenPtr: Integer;
    FStringPtr: Integer;
    FSourceLine: Integer;
    FToken: Char;
    FFloatType: Char;
    FWideStr: WideString;
    ParseBufSize :integer;
    procedure SkipBlanks;
    procedure SetExpression(Value:string);
  public
    constructor Create;
    destructor Destroy;override;
    procedure CheckToken(T: Char);
    procedure CheckTokenSymbol(const S: string);
    procedure Error(MessageID:WideString);
    procedure HexToBinaryStream(Stream: TStream);
    function NextToken: Char;
    function SourcePos: Longint;
    function TokenComponentIdent: string;
    function TokenFloat: Double;
//    function TokenInt: Int64;
    function TokenInt: Integer;
    function TokenString: string;
    function TokenWideString: WideString;
    function TokenSymbolIs(const S: string): Boolean;
    // Ask for the next token
    function NextTokenIs(Value:string):Boolean;
    property FloatType: Char read FFloatType;
    property SourceLine: Integer read FSourceLine;
    property Token: Char read FToken;
    property Expression:string read FNewExpression write SetExpression;
  end;

var
 ParserSetChars:set of Char=
{$IFDEF DOTNETD}
  ['A'..'Z', 'a'..'z','0'..'9', '_','.'];
{$ENDIF}
{$IFNDEF DOTNETD}
  ['A'..'Z', 'a'..'z','á','à','é','è','í','ó','ò','ú', 'Ñ','ñ','0'..'9','_','.',
         'ä','Ä','ö','Ö','ü','Ü','Á','À','É','È','Í','Ó','Ò','Ú','ß'];
{$ENDIF}

implementation

function SameText(const S1, S2: string): Boolean;
begin
  Result := CompareText(S1, S2) = 0;
end;



const
  H2BConvert: array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);

function HexToBin(const Text: array of Byte; TextOffset: Integer;
  Buffer: array of Byte; BufOffset: Integer; Count: Integer): Integer;
var
  I, C: Integer;
begin
  C := 0;
  for I := 0 to Count - 1 do
  begin
    if not (AnsiChar(Text[TextOffset + I * 2]) in [AnsiChar('0')..AnsiChar('f')]) or
       not (AnsiChar(Text[TextOffset + 1 + I * 2]) in [AnsiChar('0')..AnsiChar('f')]) then
      Break;
    Buffer[BufOffset + I] :=
      (H2BConvert[AnsiChar(Text[TextOffset + I * 2])] shl 4) or
       H2BConvert[AnsiChar(Text[TextOffset + 1 + I * 2])];
    Inc(C);
  end;
  Result := C;
end;

function HexToBinChar(const Text: array of char; TextOffset: Integer;
  Buffer: array of Byte; BufOffset: Integer; Count: Integer): Integer;
var
  I, C: Integer;
begin
  C := 0;
  for I := 0 to Count - 1 do
  begin
    if not (Text[TextOffset + I * 2] in ['0'..'f']) or
       not (Text[TextOffset + 1 + I * 2] in ['0'..'f']) then
      Break;
    Buffer[BufOffset + I] :=
      (H2BConvert[AnsiChar(Text[TextOffset + I * 2])] shl 4) or
       H2BConvert[AnsiChar(Text[TextOffset + 1 + I * 2])];
    Inc(C);
  end;
  Result := C;
end;

function ALineStart(Buffer: array of char; BufPos: Integer): Integer;
begin
  while (Ord(BufPos) > 0) and (Ord(Buffer[BufPos]) <> 10) do
    Dec(BufPos);
  if Ord(Buffer[BufPos]) = 10 then
    Inc(BufPos);
  Result := BufPos;
end;


constructor TRpParser.Create;
begin
  inherited Create;
  ParseBufSize := 4096;
  SetLength(FBuffer, ParseBufSize);
end;


procedure TRpParser.CheckToken(T: Char);
begin
  if Token <> T then
    case T of
      toSymbol:
        Error(SRpIdentifierExpected);
      tkString:
        Error(SRpstringExpected);
      toWString:
        Error(SRpstringExpected);
      toInteger, toFloat:
        Error(SRpNumberExpected);
      toOperator:
        Error(SRpOperatorExpected);
    end;
end;

procedure TRpParser.Error(MessageID: WideString);
begin
  Raise TRpEvalException.Create(MessageID,Tokenstring,SourceLine,SourcePos);
end;


procedure TRpParser.CheckTokenSymbol(const S: string);
begin
  if not TokenSymbolIs(S) then
   Raise TRpEvalException.Create(Format(SRpExpected, [S]),'',SourceLine,SourcePos);
end;


procedure TRpParser.HexToBinaryStream(Stream: TStream);
var
  Count: Integer;
  Buffer: array[0..255] of Byte;
begin
  SkipBlanks;
  while Char(FBuffer[FSourcePtr]) <> '}' do
  begin
    Count := HexToBinChar(FBuffer, FSourcePtr, Buffer, 0, SizeOf(Buffer));
    if Count = 0 then
      Error(SRpEvalSyntax);
    Stream.Write(Buffer, Count);
    Inc(FSourcePtr, Count * 2);
    SkipBlanks;
  end;
  NextToken;
end;


function TRpParser.NextToken: Char;
var
  I, J: Integer;
  IsWideStr: Boolean;
  P, S: Integer;
  achar:Char;
  operadors:string;
  operador:Char;
begin
  SkipBlanks;
  P := FSourcePtr;
  FTokenPtr := P;
  case FBuffer[P] of
    // Identifiers with blanks into brackets
    '[':
      begin
        Inc(P);
        achar:=FBuffer[P];
        while ((achar<>Char(0)) AND (achar<>']')) do
        begin
         Inc(P);
         achar:=FBuffer[P];
        end;
        // Finish?
        if achar<>']' then
         Raise Exception.Create(Format(SRpExpected,[']']));
        Inc(P);
        Result := toSymbol;
      end;
    // Operators
    '*','+','-','/','(',')',',','=','>','<',':',';':
      begin
       Result:=toOperator;
       operador:=Char(FBuffer[P]);
       Inc(P);
       case Char(FBuffer[P]) of
        '=':
         if operador in [':','!','<','>','='] then
          Inc(P);
        '<':
         if operador='>' then
          Inc(P);
        '>':
         if operador='<' then
          Inc(p);
       end;
      end;
    // Strings and chars
    '#', '''':
      begin
        IsWideStr := False;
        J := 0;
        S := P;
        while True do
          case Char(FBuffer[P]) of
            '#':
              begin
                Inc(P);
                I := 0;
                while FBuffer[P] in ['0'..'9'] do
                begin
                  I := I * 10 + (Ord(FBuffer[P]) - Ord('0'));
                  Inc(P);
                end;
                if (I > 127) then
                  IsWideStr := True;
                Inc(J);
              end;
            '''':
              begin
                Inc(P);
                while True do
                begin
                  case FBuffer[P] of
                    #0, #10, #13:
                      Error(SRpEvalSyntax);
                    '''':
                      begin
                        Inc(P);
                        if FBuffer[P] <> '''' then
                          Break;
                      end;
                  end;
                  Inc(J);
                  Inc(P);
                end;
              end;
          else
            Break;
          end;
        P := S;
        if IsWideStr then
          SetLength(FWideStr, J);
        J := 1;
        while True do
          case Char(FBuffer[P]) of
            '#':
              begin
                Inc(P);
                I := 0;
                while FBuffer[P] in ['0'..'9'] do
                begin
                  I := I * 10 + (Ord(FBuffer[P]) - Ord('0'));
                  Inc(P);
                end;
                if IsWideStr then
                begin
                  FWideStr[J] := WideChar(SmallInt(I));
                  Inc(J);
                end
                else
                begin
                  FBuffer[S] := Char(I);
                  Inc(S);
                end;
              end;
            '''':
              begin
                Inc(P);
                while True do
                begin
                  case Ord(FBuffer[P]) of
                    0, 10, 13:
                      Error(SRpEvalSyntax);
                    Ord(''''):
                      begin
                        Inc(P);
                        if Char(FBuffer[P]) <> '''' then
                          Break;
                      end;
                  end;
                  if IsWideStr then
                  begin
                    FWideStr[J] := WideChar(FBuffer[P]);
                    Inc(J);
                  end
                  else
                  begin
                    FBuffer[S] := FBuffer[P];
                    Inc(S);
                  end;
                  Inc(P);
                end;
              end;
          else
            Break;
          end;
        FStringPtr := S;
        if IsWideStr then
          Result := toWString
        else
          Result := tkString;
      end;
    // Hex numbers
    '$':
      begin
        Inc(P);
        while FBuffer[P] in ['0'..'9', 'A'..'F', 'a'..'f'] do
          Inc(P);
        Result := toInteger;
      end;
    // Numbers
    '0'..'9':
      begin
        Inc(P);
        while FBuffer[P] in ['0'..'9'] do
          Inc(P);
        Result := toInteger;
        while FBuffer[P] in ['0'..'9', '.', 'e', 'E'] do
        begin
          if FBuffer[P]='.' then
          begin
{$IFDEF DELPHI2009UP}
           FBuffer[P]:=FormatSettings.DecimalSeparator;
{$ELSE}
           FBuffer[P]:=DecimalSeparator;
{$ENDIF}
          end;
          Inc(P);
          Result := toFloat;
        end;
        if (FBuffer[P] in ['c', 'C', 'd', 'D', 's', 'S', 'f', 'F']) then
        begin
          Result := toFloat;
          FFloatType := Char(FBuffer[P]);
          Inc(P);
        end
        else
          FFloatType := #0;
      end;
  else
    // Check for identifier
    Result := Char(FBuffer[P]);
    if (Result.IsLetterOrDigit or (Result = '_')) then
    begin
      Inc(P);
      while (FBuffer[P].IsLetterOrDigit or (FBuffer[P] in ['_','.'])) do
      // while FBuffer[P] in ['A'..'Z', 'a'..'z','á','à','é','è','í','ó','ò','ú', 'Ñ','ñ','0'..'9','_','.',
      //  'ä','Ä','ö','Ö','ü','Ü','Á','À','É','È','Í','Ó','Ò','Ú','ß'] do
        Inc(P);
      Result := toSymbol;
    end
    else
    begin
      if Result <> toEOF then
      begin
       Result:=toSymbol;
       Inc(P);
      end;
    end;
  end;
  FSourcePtr := P;
  FToken := Result;
  // Symbols
  if FToken=toSymbol then
  begin
   OperadorS:=UpperCase(TokenString);
   if ((OperadorS='OR') OR (OperadorS='NOT')
        OR (OperadorS='AND') OR (OperadorS='IIF')) then
   begin
    Result:=toOperator;
    FToken:=toOperator;
   end;
  end;
end;


procedure TRpParser.SkipBlanks;
begin
  while True do
  begin
    case Ord(FBuffer[FSourcePtr]) of
      0:
        begin
          //ReadBuffer;
          if FBuffer[FSourcePtr] = Char(0) then
            Exit;
          Continue;
        end;
      10:
        Inc(FSourceLine);
      33..255:
        Exit;
    end;
    Inc(FSourcePtr);
  end;
end;

function TRpParser.SourcePos: Longint;
begin
  Result := FOrigin + FTokenPtr;
end;

function TRpParser.TokenFloat: Double;
begin
  if FFloatType <> #0 then
    Dec(FSourcePtr);
  Result := StrToFloat(TokenString);
  if FFloatType <> #0 then
    Inc(FSourcePtr);
end;

function TRpParser.TokenInt: Integer;
begin
  Result := StrToInt64(TokenString);
end;

function TRpParser.TokenString: string;
var
  L: Integer;
begin
  if FToken = tkString then
    L := FStringPtr - FTokenPtr
  else
    L := FSourcePtr - FTokenPtr;
  SetString(Result,PChar(@FBuffer[FTokenPtr]),L);
  // Brackets out
  if FToken=toSymbol then
  begin
   if Length(Result)>0 then
   begin
    if Result[1]='[' then
     if Result[Length(Result)]=']' then
      Result:=Copy(Result,2,Length(Result)-2);
   end;
  end;
end;

function TRpParser.TokenWideString: WideString;
begin
  if FToken = tkString then
    Result := TokenString
  else
    Result := FWideStr;
end;

function TRpParser.TokenSymbolIs(const S:string): Boolean;
begin
  Result := (Token = toSymbol) and SameText(S, TokenString);
end;

function TRpParser.TokenComponentIdent: string;
var
  P: Integer;
begin
  CheckToken(toSymbol);
  P := FSourcePtr;
  while FBuffer[P] = '.' do
  begin
    Inc(P);
    if not (FBuffer[P] in ['A'..'Z', 'a'..'z', '_']) then
      Error(SRpIdentifierexpected);
    repeat
      Inc(P)
    until not (FBuffer[P] in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
  end;
  FSourcePtr := P;
  Result := TokenString;
end;





function TRpParser.NextTokenIs(Value:string):Boolean;
var NewParser:TRpParser;
    Apuntador:Integer;
begin
  // A new parser must be create for checking the next token
  Apuntador:=FSourcePtr;
  NewParser:=TRpParser.Create;
  try
   NewParser.Expression:=Copy(Expression,Apuntador+1,Length(Expression));
   Result:=False;
   if NewParser.Token in [toSymbol,toOperator] then
    if NewParser.TokenString=Value then
     Result:=True;
  finally
   NewParser.free;
  end;
end;

procedure TRpParser.SetExpression(Value:string);
begin
  FNewExpression:=Value;
  if (Length(Value)>(ParseBufSize-1)) then
  begin
   ParseBufSize:=Length(Value)*2;
   SetLength(FBuffer, ParseBufSize);
  end;
  StringToWideChar(FNewExpression,PChar(FBuffer),ParseBufSize);
  FBuffer[Length(Value)] := Char(0);
  FBufPtr := 0;
  FBufEnd := ParseBufSize;
  FSourcePtr := 0;
  FSourceEnd := 0;
  FTokenPtr := 0;
  FSourceLine := 1;
  NextToken;
end;

destructor TRpParser.Destroy;
begin

 inherited destroy;
end;

end.
