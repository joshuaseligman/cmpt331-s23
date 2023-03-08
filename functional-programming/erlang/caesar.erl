-module(caesar).
-export([performShift/2,encrypt/2,decrypt/2,start/0]).

performShift([Char | Str], ShiftAmt) ->
    [
        if
            (Char >= 65) and (Char =< 90) ->
                NewChar = Char + ShiftAmt,
                if
                    NewChar > 90 ->
                        65 + NewChar - 90 - 1;
                    NewChar < 65 ->
                        90 - 65 + NewChar + 1;
                    true ->
                        NewChar
                end;
            true ->
                Char
        end
    | performShift(Str, ShiftAmt)];

performShift([], ShiftAmt) -> [].


encrypt(InStr, ShiftAmt) ->
    NewStr = string:to_upper(InStr),
    RealShift = ShiftAmt rem 26,
    performShift(NewStr, RealShift).

decrypt(InStr, ShiftAmt) ->
    encrypt(InStr, -ShiftAmt).

start() ->
    EncryptOut = encrypt("This is a test string from Alan", 34),
    io:fwrite("~p~n", [EncryptOut]),
    DecryptOut = decrypt(EncryptOut, 34),
    io:fwrite("~p~n", [DecryptOut]).
