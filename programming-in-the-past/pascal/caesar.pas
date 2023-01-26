program Caesar;
function Encrypt(inStr : string; shiftAmount : integer) : string;
var
    curChar: Char;
    charValue: integer;
    diff: integer;
    idx: integer;
begin
    shiftAmount := shiftAmount mod 26;
    Encrypt := inStr;
    idx := 1;
    for curChar in Encrypt do
    begin
        charValue := ord(curChar);
        if ((charValue >= 97) and (charValue <= 122)) then
            charValue := charValue - 32;
        if ((charValue >= 65) and (charValue <= 90)) then
        begin
            charValue := charValue + shiftAmount;
            diff := charValue - 90;
            if diff > 0 then
                charValue := 65 + diff - 1
            else
            begin
                diff := 65 - charValue;
                if diff > 0 then
                    charValue := 90 - diff + 1;
            end;
            Encrypt[idx] := chr(charValue);
        end;
        idx := idx + 1;
    end;
end;

var
    originalString : string;
begin
    originalString := 'This is a test string from Alan';
    writeln(Encrypt(originalString, -18));
end.