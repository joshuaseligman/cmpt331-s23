(* Function to negate an integer value because multiplying by -1 doesn't work *)
fun negate(x: int): int = x - x - x;

(* Creates a list with num and size numElements *)
fun createList (num: int, numElements: int): int list = if numElements <= 1 then
                                                            (* Recursion base case is size 1 *)
                                                            [num]
                                                        else
                                                            (* Append a list of size 1 to the returned recursive list *)
                                                            [num]@createList(num, numElements - 1);


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
                                                        performShift
                                                        (
                                                            (* Need a tuple of the character and shift amount for performShift *)
                                                            (* val zip : 'a list * 'b list -> ('a * 'b) list *)
                                                            ListPair.zip(
                                                                (* Create list of characters *)
                                                                explode(inStr),
                                                                (* Create list of shift amounts *)
                                                                createList(shiftAmt mod 26, size(inStr))
                                                            )
                                                        )
                                                    );

(* Runs the decrypt (negative encrypt) on a string *)
fun decrypt(inStr: string, shiftAmt: int): string = encrypt(inStr, negate(shiftAmt));

val encryptOut: string = encrypt("This is a test string from Alan", 8);
val decryptOut: string = decrypt(encryptOut, 8);

(* Needed for SMLNJ *)
OS.Process.exit(OS.Process.success);
