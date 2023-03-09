-module(caesar).
-export([performShift/2, encrypt/2, decrypt/2, solveHelper/2, solve/2, start/0]).

% Performs a shift on a list/string that is uppercase
performShift([Char | Str], ShiftAmt) ->
    [
        if
            % Only shift if there is a letter
            (Char >= 65) and (Char =< 90) ->
                NewChar = Char + ShiftAmt,
                if
                    % Compute the Z wraparound
                    NewChar > 90 ->
                        65 + NewChar - 90 - 1;
                    % Compute the A wraparound
                    NewChar < 65 ->
                        90 - 65 + NewChar + 1;
                    true ->
                        % If no wraparound then return the shifted character
                        NewChar
                end;
            true ->
                % No change so return the original character
                Char
        end
    % Recursively call performShift on the rest of the string
    | performShift(Str, ShiftAmt)];
% Base case for the recursion. Empty string gets returned as an empty list.
performShift([], ShiftAmt) -> [].

% Encrypts a string with the given shift amount
encrypt(InStr, ShiftAmt) ->
    % Get the uppercase string
    NewStr = string:to_upper(InStr),
    % Clean up the shift amount
    RealShift = ShiftAmt rem 26,
    % Perform the shift on the string
    performShift(NewStr, RealShift).

% Decrypts a string
decrypt(InStr, ShiftAmt) ->
    % Decrypt is negative encrypt
    encrypt(InStr, -ShiftAmt).

% Recursively solves a Caesar cipher
solveHelper(InStr, ShiftAmt) ->
    % Print out the output from the encrypt function
    io:fwrite("Caesar ~w: ~p~n", [ShiftAmt, encrypt(InStr, ShiftAmt)]),
    if
        % Contine until we have no more shifts
        ShiftAmt > 0 ->
            solveHelper(InStr, ShiftAmt - 1);
        true ->
            % We are done so return void
            void
    end.

% Solves a Caesar cipher
solve(InStr, MaxShift) ->
    if
        abs(MaxShift) > 26 ->
            % Can take mod if greater than 26
            RealShift = abs(MaxShift) rem 26;
        true ->
            % Just take abs here
            RealShift = abs(MaxShift)
    end,
    % Call the recursive solve helper function starting with the max shift
    solveHelper(InStr, RealShift).

% Entrypoint for the program
start() ->
    % Basic Alan tests
    io:fwrite("Alan tests:~n"),
    EncryptOut1 = encrypt("This is a test string from Alan", 8),
    io:fwrite("~p~n", [EncryptOut1]),
    DecryptOut1 = decrypt(EncryptOut1, 8),
    io:fwrite("~p~n", [DecryptOut1]),
    solve("HAL", 26),
    io:fwrite("~nEncrypt and decrypt tests:~n"),
    % Negative shift
    EncryptOut2 = encrypt("This is a test string from Alan", -1),
    io:fwrite("~p~n", [EncryptOut2]),
    DecryptOut2 = decrypt(EncryptOut2, -1),
    io:fwrite("~p~n", [DecryptOut2]),
    % Mod shift
    EncryptOut3 = encrypt("This is a test string from Alan", 27),
    io:fwrite("~p~n", [EncryptOut3]),
    DecryptOut3 = decrypt(EncryptOut3, 27),
    io:fwrite("~p~n", [DecryptOut3]),
    % Empty string
    EncryptOut4 = encrypt("", 7),
    io:fwrite("~p~n", [EncryptOut4]),
    DecryptOut4 = decrypt(EncryptOut4, 7),
    io:fwrite("~p~n", [DecryptOut4]),
    % No letters
    EncryptOut5 = encrypt("1234567890!@#$%^&*(){}", 7),
    io:fwrite("~p~n", [EncryptOut5]),
    DecryptOut5 = decrypt(EncryptOut5, 7),
    io:fwrite("~p~n", [DecryptOut5]),
    io:fwrite("~nSolve tests:~n"),
    % Negative shift
    solve("HAL", -26),
    io:fwrite("~n"),
    % Mod shift
    solve("HAL", 30).
