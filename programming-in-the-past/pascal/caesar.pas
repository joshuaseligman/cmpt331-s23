program Caesar;
function Encrypt(inStr : string; shiftAmount : integer) : string;
var
    curChar: Char;
begin
    shiftAmount := shiftAmount mod 26;
    Encrypt := inStr;
    for curChar in Encrypt do
        writeln(curChar);
end;

var
    originalString : string;
begin
    originalString := 'hello world';
    Encrypt(originalString, 28);
end.