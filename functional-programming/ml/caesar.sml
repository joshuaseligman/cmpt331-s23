(* Creates a sequence from num down to 0, inclusive  *)
fun createSequence(num: int): int list =    if num <= 0 then
                                                (* Base case is just a 0 *)
                                                [0]
                                            else
                                                (* Append the current number to the rest of the sequence *)
                                                [num]@createSequence(num - 1);

(* Function that deals with the wraparounds *)
fun handleWraparond(charValue: int): int =  if charValue > 90 then
                                                (* Handle Z wraparound  *)
                                                65 + charValue - 90 - 1
                                            else if charValue < 65 then
                                                (* Handle A wraparound  *)
                                                90 - 65 + charValue + 1
                                            else charValue; (* No wraparound *)

(* Performs a shift on the given character *)
fun performShift(c: char, shiftAmt: int): char =    if Char.isAlpha(c) then
                                                        (* Convert to uppercase, get the ordinal value, add the shift,
                                                         * manage the wraparound, and then convert back to a character *)
                                                        chr(handleWraparond(ord(Char.toUpper(c)) + shiftAmt))
                                                    else c; (* Non-letters stay the same *)

(* Runs the encrypt with the given shift on the string  *)
fun encrypt(inStr: string, shiftAmt: int): string = implode( (* Puts the list back together into a string *)
                                                        map (* Run performShift on every element of the list *)
                                                        (fn (c) => performShift(c, shiftAmt mod 26))
                                                        (
                                                            (* Create list of characters *)
                                                            explode(inStr)
                                                        )
                                                    );

(* Runs the decrypt (negative encrypt) on a string *)
fun decrypt(inStr: string, shiftAmt: int): string = encrypt(inStr, ~shiftAmt);

(* Creates the shift value for solve *)
fun cleanSolveShift(shift: int): int =  if Int.abs(shift) > 26 then
                                            (* Take mod if greater than 26 *)
                                            Int.abs(shift) mod 26
                                        else Int.abs(shift); (* Just take abs otherwise *)

(* Solves the Caesar cipher *)
fun solve(inStr: string, maxShiftAmt: int): string list =   map
                                                            (* Lambda function that runs encrypt with the current shift amount *)
                                                            (fn (shift) => "Caesar: "^Int.toString(shift)^": "^encrypt(inStr, shift))
                                                            (
                                                                (* Create a sequence from the max shift down to 0 *)
                                                                createSequence(cleanSolveShift(maxShiftAmt))
                                                            );

print("Alan tests:\n");
val encryptOut: string = encrypt("This is a test string from Alan", 8);
val decryptOut: string = decrypt(encryptOut, 8);
val solveOut: string list = solve("HAL", 26);
print(String.concatWith("\n")(solveOut)^"\n");

print("Encrypt and decrypt tests:\n");
(* Negative shift *)
val encryptOut: string = encrypt("This is a test string from Alan", ~1);
val decryptOut: string = decrypt(encryptOut, ~1);
(* Mod shift *)
val encryptOut: string = encrypt("This is a test string from Alan", 27);
val decryptOut: string = decrypt(encryptOut, 27);
(* Empty string *)
val encryptOut: string = encrypt("", 7);
val decryptOut: string = decrypt(encryptOut, 7);
(* All numbers and symbols (no letters) *)
val encryptOut: string = encrypt("1234567890!@#$%^&*(){}", 7);
val decryptOut: string = decrypt(encryptOut, 7);

print("Solve tests:\n");
(* Negative shift *)
val solveOut: string list = solve("HAL", ~26);
print(String.concatWith("\n")(solveOut)^"\n");
(* Mod shift *)
val solveOut: string list = solve("HAL", 30);
print(String.concatWith("\n")(solveOut)^"\n");

(* Needed for SMLNJ *)
OS.Process.exit(OS.Process.success);
