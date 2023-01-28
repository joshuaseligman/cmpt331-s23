program Caesar;
(* Function that encrypts the input string by the shift amount *)
function Encrypt(inStr : string; shiftAmount : integer) : string;
var
    curChar: Char; (* The current character being worked with *)
    charValue: integer; (* The ASCII value of the current character *)
    diff: integer; (* The difference between the current character and A and Z to detect wraparound *)
    idx: integer; (* The position in the string we are at *)
begin
    (* Start off by normalizing the shift amount *)
    shiftAmount := shiftAmount mod 26;
    Encrypt := inStr;

    (* Pascal uses 1-based indexing *)
    idx := 1;
    (* Loop through each character in the string *)
    for curChar in Encrypt do
    begin
        (* Get the initial character ASCII code *)
        charValue := ord(curChar);

        (* Convert the character to uppercase if it is not already *)
        if ((charValue >= 97) and (charValue <= 122)) then
            charValue := charValue - 32;

        (* Caesar cipher only impacts letters, so check that conditon first *)
        if ((charValue >= 65) and (charValue <= 90)) then
        begin
            (* Perform the shift *)
            charValue := charValue + shiftAmount;

            (* Check wraparound on the Z end *)
            diff := charValue - 90;
            if diff > 0 then
                (* Perform the wraparound (-1 is needed because 91 should be 65 (A)) *)
                charValue := 65 + diff - 1
            else
            begin
                (* Check the low end of the range *)
                diff := 65 - charValue;
                if diff > 0 then
                    (* Perform the wraparound (+1 is needed because 64 should be 90 (Z)) *)
                    charValue := 90 - diff + 1;
            end;
            (* Update the string accordingly *)
            Encrypt[idx] := chr(charValue);
        end;
        (* Increment the index for our own reference *)
        idx := idx + 1;
    end;
end;

(* Function that decrypts the input string by the shift amount *)
function Decrypt(inStr : string; shiftAmount : integer) : string;
var
    curChar: Char; (* The current character being worked with *)
    charValue: integer; (* The ASCII value of the current character *)
    diff: integer; (* The difference between the current character and A and Z to detect wraparound *)
    idx: integer; (* The position in the string we are at *)
begin
    (* Start off by normalizing the shift amount *)
    shiftAmount := shiftAmount mod 26;
    Decrypt := inStr;

    (* Pascal uses 1-based indexing *)
    idx := 1;
    (* Loop through each character in the string *)
    for curChar in Decrypt do
    begin
        (* Get the initial character ASCII code *)
        charValue := ord(curChar);

        (* Convert the character to uppercase if it is not already *)
        if ((charValue >= 97) and (charValue <= 122)) then
            charValue := charValue - 32;

        (* Caesar cipher only impacts letters, so check that conditon first *)
        if ((charValue >= 65) and (charValue <= 90)) then
        begin
            (* Perform the shift *)
            charValue := charValue - shiftAmount;

            (* Check wraparound on the Z end *)
            diff := charValue - 90;
            if diff > 0 then
                (* Perform the wraparound (-1 is needed because 91 should be 65 (A)) *)
                charValue := 65 + diff - 1
            else
            begin
                (* Check the low end of the range *)
                diff := 65 - charValue;
                if diff > 0 then
                    (* Perform the wraparound (+1 is needed because 64 should be 90 (Z)) *)
                    charValue := 90 - diff + 1;
            end;
            (* Update the string accordingly *)
            Decrypt[idx] := chr(charValue);
        end;
        (* Increment the index for our own reference *)
        idx := idx + 1;
    end;
end;

(* Procedure to solve a Caesar cipher *)
procedure solve(inputString : string; maxShiftAmount : integer);
var
    curShift: integer; (* The current shift amount  *)
begin
    (* Normalize the max shift amount being used *)
    maxShiftAmount := abs(maxShiftAmount);
    if maxShiftAmount > 26 then
        maxShiftAmount := maxShiftAmount mod 26;

    (* Loop through everything *)
    for curShift := maxShiftAmount downto 0 do
        (* Perform the decrypt and print the result *)
        writeln('Caesar ', curShift, ': ', Decrypt(inputString, -curShift));
end;

var
    originalString: string; (* The original string *)
    encryptOut: string; (* The output of encrypt *)
    decryptOut: string; (* The output of decrypt *)
begin
    originalString := 'This is a test string from Alan';
    writeln('Alan tests:');
    encryptOut := Encrypt(originalString, 8);
    decryptOut := Decrypt(encryptOut, 8);
    writeln(encryptOut);
    writeln(decryptOut);
    solve('HAL', 26);
    
    writeln();
    writeln('Encrypt and decrypt tests:');
    (* Test negative shift *)
    encryptOut := Encrypt(originalString, -1);
    decryptOut := Decrypt(encryptOut, -1);
    writeln(encryptOut);
    writeln(decryptOut);
    (* Test modulus *)
    encryptOut := Encrypt(originalString, 27);
    decryptOut := Decrypt(encryptOut, 27);
    writeln(encryptOut);
    writeln(decryptOut);
    (* Test empty string *)
    encryptOut := Encrypt('', 7);
    decryptOut := Decrypt(encryptOut, 7);
    writeln(encryptOut);
    writeln(decryptOut);
    (* Test no letters *)
    encryptOut := Encrypt('1234567890!@#$%^&*(){}', 7);
    decryptOut := Decrypt(encryptOut, 7);
    writeln(encryptOut);
    writeln(decryptOut);

    writeln();
    writeln('Solve tests:');
    (* Test absolute value *)
    solve('HAL', -26);
    writeln();
    (* Test modulus *)
    solve('HAL', 30);
end.