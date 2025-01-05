codeunit 50002 "String Library (INT)"
{

    trigger OnRun()
    begin
    end;

    procedure FindParameter(Parameters: array[100] of Text[1024]; ParameterName: Text[1024]; var ParameterValue: Text[1024]): Boolean
    var
        i: Integer;
        CurrentParameterName: Text[1024];
        Str: Text[1024];
        Pos: Integer;
    begin
        for i := 1 to ArrayLen(Parameters) do begin
            Str := Parameters[i];
            if Str = '' then
                exit(false);
            Pos := StrPos(Str, '=');
            if Pos <> 0 then begin
                CurrentParameterName := UpperCase(CopyStr(Str, 1, Pos - 1));
                if UpperCase(ParameterName) = CurrentParameterName then begin
                    ParameterValue := CopyStr(Str, Pos + 1);
                    exit(true);
                end;
            end;
        end;
        exit(false);
    end;

    procedure ExtractURL(URL: Text[1024]; var Protocol: Text[1024]; var "Object": Text[1024]; var Parameters: array[100] of Text[1024]): Boolean
    var
        Str: Text[1024];
        Pos: Integer;
        Parameter: Text[1024];
        i: Integer;
    begin
        Protocol := '';
        Object := '';
        Clear(Parameters);

        Str := DecodeURL(URL);
        Pos := StrPos(Str, ':');
        if Pos = 0 then
            exit(false);
        Protocol := CopyStr(Str, 1, Pos - 1);
        Str := CopyStr(Str, Pos + 1);
        Pos := StrPos(Str, '?');
        if Pos = 0 then begin
            Object := Str;
            exit(true);
        end;
        Object := CopyStr(Str, 1, Pos - 1);
        Str := CopyStr(Str, Pos + 1);
        i := 1;
        while StrToToken(Str, '&', Parameter) do begin
            Parameters[i] := Parameter;
            i += 1;
        end;
        if Str <> '' then
            exit(false);

        exit(true);
    end;

    procedure IsInteger(value: Text[30]): Boolean
    var
        integerValue: Integer;
    begin
        // Stellt fest ob der übergebene String ein Integer-Value ist
        exit(Evaluate(integerValue, value));
    end;

    procedure TrimFront(var inString: Text[1024]): Text[1024]
    begin
        // Entfernt Leerzeichen vom Anfang eines Strings
        exit(DelChr(inString, '<', ' '));
    end;

    procedure TrimTail(var inString: Text[1024]): Text[1024]
    begin
        // Entfernt Leerzeichen vom Ende eines Strings
        exit(DelChr(inString, '>', ' '));
    end;

    procedure Trim(var inString: Text[1024]): Text[1024]
    begin
        // Entfernt Leerzeichen vom Anfang und Ende eines Strings
        exit(DelChr(inString, '<>', ' '));
    end;

    procedure Replace(inString: Text[1024]; oldString: Text[1024]; newString: Text[1024]) outString: Text[1024]
    var
        inStringLen: Integer;
        oldStringLen: Integer;
        firstFind: Integer;
    begin
        // Ersetzt alle Vorkommen von oldString mit newString innerhalb inString und liefert das Ergebnis zurück
        inStringLen := StrLen(inString);
        oldStringLen := StrLen(oldString);

        // leere Strings können nicht ersetzt werden
        if (inStringLen > 0) then begin
            firstFind := StrPos(inString, oldString);
            while (firstFind > 0) do begin
                outString += CopyStr(inString, 1, firstFind - 1);
                outString += newString;
                inString := DelStr(inString, 1, firstFind + oldStringLen - 1);
                firstFind := StrPos(inString, oldString);
            end;
            outString += inString;
        end else begin
            outString := inString;
        end;
    end;

    procedure AppendStr(var Str: Text[1024]; MaxLen: Integer; StrToAppend: Text[1024]): Boolean
    var
        Len: Integer;
        Len2: Integer;
    begin
        Len := StrLen(Str);
        Len2 := StrLen(StrToAppend);
        if (Len + Len2) > MaxLen then
            exit(false);

        Str := Str + StrToAppend;

        exit(true);
    end;

    procedure CSSInsert(var Str: Text[1024]; StrToAdd: Text[1024]; Unique: Boolean): Boolean
    var
        Index: Integer;
        MaxLen: Integer;
        Len: Integer;
        Len2: Integer;
        TotalLen: Integer;
    begin
        if Unique then
            if CSSFind(Str, StrToAdd, Index) then
                exit(false);

        if Str <> '' then begin
            StrToAdd := ',' + StrToAdd;
        end;
        Len := StrLen(Str);
        Len2 := StrLen(StrToAdd);
        TotalLen := Len + Len2;
        MaxLen := MaxStrLen(Str);
        if TotalLen > MaxLen then
            exit(false);

        Str := Str + StrToAdd;
        exit(true);
    end;

    procedure CSSFind(Str: Text[1024]; StrToFind: Text[1024]; var Index: Integer): Boolean
    var
        i: Integer;
        FetchedStr: Text[1024];
    begin
        Index := 0;

        i := 0;
        while CSSFetchStr(Str, FetchedStr) do begin
            i += 1;
            if (FetchedStr = StrToFind) then begin
                Index := i;
                exit(true);
            end;
        end;

        exit(false);
    end;

    procedure CSSSelectStr(Str: Text[1024]; Index: Integer; var SelectedStr: Text[1024]): Boolean
    var
        i: Integer;
        FetchedStr: Text[1024];
    begin
        SelectedStr := '';
        if (Index < 1) then
            exit(false);
        i := 0;
        while CSSFetchStr(Str, FetchedStr) do begin
            i += 1;
            if (i = Index) then begin
                SelectedStr := FetchedStr;
                exit(true);
            end;
        end;

        exit(false);
    end;

    procedure CSSFetchStr(var Str: Text[1024]; var RetStr: Text[1024]): Boolean
    var
        Pos: Integer;
    begin
        if Str = '' then
            exit(false);

        Pos := StrPos(Str, ',');
        if Pos = 0 then begin
            RetStr := Str;
            Str := '';
            exit(true);
        end;

        RetStr := CopyStr(Str, 1, Pos - 1);
        Str := CopyStr(Str, Pos + 1);
        exit(true);
    end;

    procedure StrToToken(var Str: Text[1024]; Sep: Text[1024]; var Token: Text[1024]): Boolean
    var
        Pos: Integer;
        Len: Integer;
    begin
        if Str = '' then
            exit(false);

        Pos := StrPos(Str, Sep);
        if Pos = 0 then begin
            Token := Str;
            Str := '';
            exit(true);
        end;

        Len := StrLen(Sep);
        Token := CopyStr(Str, 1, Pos - 1);
        Str := CopyStr(Str, Pos + Len);
        exit(true);
    end;

    procedure Parse(var Str: Text[1024]; MatchStr: Text[1024]): Boolean
    var
        Pos: Integer;
        Len: Integer;
    begin
        Pos := StrPos(Str, MatchStr);
        if Pos <> 1 then
            exit(false);

        Len := StrLen(MatchStr);
        Str := CopyStr(Str, Len + 1);
        exit(true);
    end;

    procedure IsAlpha(Ch: Char): Boolean
    begin
        if Ch in ['a' .. 'z', 'A' .. 'Z'] then
            exit(true);

        exit(false);
    end;

    procedure IsNum(Ch: Char): Boolean
    begin
        if Ch in ['0' .. '9'] then
            exit(true);

        exit(false);
    end;

    procedure IsAlphaNum(Ch: Char): Boolean
    begin
        if IsAlpha(Ch) or IsNum(Ch) then
            exit(true);

        exit(false);
    end;

    procedure ParseAlphaNum(var Str: Text[1024]; var Token: Text[1024]): Boolean
    var
        i: Integer;
        len: Integer;
    begin
        if Str = '' then
            exit(false);

        if not IsAlpha(Str[1]) then
            exit(false);

        len := StrLen(Str);
        i := 2;
        while IsAlphaNum(Str[i]) do begin
            i += 1;
        end;

        Token := CopyStr(Str, 1, i - 1);
        Str := CopyStr(Str, i);
        exit(true);
    end;

    procedure Char2Hex(ch: Char) HexStr: Text[2]
    var
        a: Integer;
        r: Integer;
        i: Integer;
        len: Integer;
    begin
        a := ch;
        len := MaxStrLen(HexStr);
        i := len;
        while (a <> 0) do begin
            r := a mod 16;
            if r > 9 then
                HexStr[i] := 65 + (r - 10)
            else
                HexStr[i] := 48 + r; // 48 = '0'
            i -= 1;
            a := a div 16;
        end;
        while (i > 0) do begin
            HexStr[i] := '0';
            i -= 1;
        end;
    end;

    procedure HexDigit2Int(Digit: Char): Integer
    var
        a: Integer;
    begin
        if not (Digit in ['0' .. '9', 'A' .. 'F', 'a' .. 'f']) then
            exit(0);

        if Digit in ['a' .. 'f'] then begin
            a := Digit - 'a' + 10;
            exit(a);
        end;

        if Digit in ['A' .. 'F'] then begin
            a := Digit - 'A' + 10;
            exit(a);
        end;

        a := Digit - '0';
        exit(a);
    end;

    procedure Hex2Int(HexStr: Text[1024]): Integer
    var
        Num: Integer;
        Len: Integer;
        i: Integer;
        j: Integer;
        a: Integer;
    begin
        Num := 0;
        Len := StrLen(HexStr);
        j := 0;
        for i := Len downto 1 do begin
            a := HexDigit2Int(HexStr[i]);
            Num += a * Power(16, j);
            j += 1;
        end;
        exit(Num);
    end;

    procedure SwapStr(Str: Text[1024]) RetStr: Text[1024]
    var
        len: Integer;
        i: Integer;
    begin
        RetStr := '';
        len := StrLen(Str);
        for i := 1 to len do begin
            RetStr[len - i + 1] := Str[i];
        end;
    end;

    procedure Char(ch: Char): Char
    begin
        exit(ch);
    end;

    procedure EncodeURL(Str: Text[1024]) RetStr: Text[1024]
    var
        len: Integer;
        i: Integer;
        ch: Char;
        ChT: Text[1];
    begin
        // ! # $ % & ' ( ) * + , / : ; = ? @ [ ]
        len := StrLen(Str);
        for i := 1 to len do begin
            ch := Str[i];
            case ch of
                ' ':
                    RetStr := RetStr + '%' + Char2Hex(' ');
                '!':
                    RetStr := RetStr + '%' + Char2Hex('!');
                '#':
                    RetStr := RetStr + '%' + Char2Hex('#');
                '$':
                    RetStr := RetStr + '%' + Char2Hex('$');
                '%':
                    RetStr := RetStr + '%' + Char2Hex('%');
                '&':
                    RetStr := RetStr + '%' + Char2Hex('&');
                '''':
                    RetStr := RetStr + '%' + Char2Hex('''');
                '(':
                    RetStr := RetStr + '%' + Char2Hex('(');
                ')':
                    RetStr := RetStr + '%' + Char2Hex(')');
                '*':
                    RetStr := RetStr + '%' + Char2Hex('*');
                '+':
                    RetStr := RetStr + '%' + Char2Hex('+');
                ',':
                    RetStr := RetStr + '%' + Char2Hex(',');
                '/':
                    RetStr := RetStr + '%' + Char2Hex('/');
                ':':
                    RetStr := RetStr + '%' + Char2Hex(':');
                ';':
                    RetStr := RetStr + '%' + Char2Hex(';');
                '=':
                    RetStr := RetStr + '%' + Char2Hex('=');
                '?':
                    RetStr := RetStr + '%' + Char2Hex('?');
                '@':
                    RetStr := RetStr + '%' + Char2Hex('@');
                '[':
                    RetStr := RetStr + '%' + Char2Hex('[');
                ']':
                    RetStr := RetStr + '%' + Char2Hex(']');
                // optional...
                '\':
                    RetStr := RetStr + '%' + Char2Hex('\');
                '{':
                    RetStr := RetStr + '%' + Char2Hex('{');
                '}':
                    RetStr := RetStr + '%' + Char2Hex('}');
                else begin
                    ChT[1] := ch;
                    RetStr := RetStr + ChT;
                end;
            end;
        end;
    end;

    procedure GetNextChar(var Str: Text[1024]; var Ch: Char): Boolean
    begin
        if Str = '' then
            exit(false);

        Ch := Str[1];
        Str := CopyStr(Str, 2);
        exit(true);
    end;

    procedure IsHexNum(Ch: Char): Boolean
    begin
        if Ch in ['0' .. '9', 'A' .. 'F', 'a' .. 'f'] then
            exit(true);

        exit(false);
    end;

    procedure ParseHex(var Str: Text[1024]; var HexNum: Text[1024]): Boolean
    var
        i: Integer;
        j: Integer;
    begin
        HexNum := '';

        i := 1;
        if not IsHexNum(Str[i]) then
            exit(false);

        j := 1;
        HexNum[j] := Str[i];
        j += 1;
        i += 1;
        while IsHexNum(Str[i]) do begin
            HexNum[j] := Str[i];
            j += 1;
            i += 1;
        end;

        Str := CopyStr(Str, i + 1);
        exit(true);
    end;

    procedure ParseURLencodedChar(var Str: Text[1024]; var Ch: Char): Boolean
    var
        HexNum: Text[30];
    begin
        if StrLen(Str) < 3 then
            exit(false);

        if Str[1] <> '%' then
            exit(false);

        if not IsHexNum(Str[2]) then
            exit(false);

        if not IsHexNum(Str[3]) then
            exit(false);

        HexNum[1] := Str[2];
        HexNum[2] := Str[3];
        Ch := Hex2Int(HexNum);

        Str := CopyStr(Str, 4);
        exit(true);
    end;

    procedure DecodeURL(Str: Text[1024]) RetStr: Text[1024]
    var
        ChT: Text[1];
    begin
        // ! # $ % & ' ( ) * + , / : ; = ? @ [ ]
        RetStr := '';
        while (StrLen(Str) > 0) do begin
            if ParseURLencodedChar(Str, ChT[1]) then begin
                RetStr += ChT;
            end else begin
                RetStr += CopyStr(Str, 1, 1);
                Str := CopyStr(Str, 2);
            end;
        end;
    end;

    procedure AsciiToAnsi(Input: Text[1024]) Output: Text[1024]
    var
        AnsiString: Text[1024];
        AsciiString: Text[1024];
    begin
        GetAnsiChars(AnsiString);
        GetAsciiChars(AsciiString);
        Output := ConvertStr(Input, AsciiString, AnsiString);
    end;

    procedure AnsiToAscii(Input: Text[1024]) Output: Text[1024]
    var
        AnsiString: Text[11];
        AsciiString: Text[11];
    begin
        GetAnsiChars(AnsiString);
        GetAsciiChars(AsciiString);
        Output := ConvertStr(Input, AnsiString, AsciiString);
    end;

    procedure GetAnsiChars(var AnsiString: Text[1024])
    begin
        AnsiString[1] := 252;
        AnsiString[2] := 246;
        AnsiString[3] := 228;
        AnsiString[4] := 220;
        AnsiString[5] := 214;
        AnsiString[6] := 196;
        AnsiString[7] := 223;
        AnsiString[8] := 232;
        AnsiString[9] := 200;
        AnsiString[10] := 233;
        AnsiString[11] := 224;
    end;

    procedure GetAsciiChars(var AsciiString: Text[1024])
    begin
        AsciiString[1] := 129;
        AsciiString[2] := 148;
        AsciiString[3] := 132;
        AsciiString[4] := 154;
        AsciiString[5] := 153;
        AsciiString[6] := 142;
        AsciiString[7] := 225;
        AsciiString[8] := 138;
        AsciiString[9] := 212;
        AsciiString[10] := 130;
        AsciiString[11] := 133;
    end;
}

