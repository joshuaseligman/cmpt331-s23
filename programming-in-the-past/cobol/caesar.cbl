000100 Identification division.
*******  This function encrypts a string based on the given shift amount
000101   Function-id. encrypt.
000102 Data division.
000103   Working-storage section.
*******    Represents the current character being analyzed
000104     1 curChar pic 999.
*******    Represents the index of the string being worked on
000105     1 idx pic 99.
*******    Represents the difference to determine wraparound
000106     1 diff pic S9(2).
*******    Shift value between -25 and 25
000107     1 newShift pic S9(2).
000108   Linkage section.
*******    The input string
000109     1 inStr pic x(32).
*******    The amount to shift by
000110     1 shiftAmt pic S999.
*******    The shifted string
000111     1 res pic x(32).
000112 Procedure division
000113   using by reference inStr shiftAmt
000114   returning res.
*******  Begin by copying the input to the result and set the index to 1
000115   Move inStr to res
000116   move 1 to idx
*******  Adjust the shift amount to be in the range -25 to 25
000117   compute newShift = function mod(shiftAmt 26)
*******  Repeat the work for all characters in the string
000118   perform encrypt-work until idx > function length(inStr)
000119   goback.
000120   encrypt-work.
*******    Get the current character's ordinal value (ASCII + 1)
000121     compute curChar = function ord(res(idx:1))
*******    Convert to uppercase if between 'a' (98) and 'z' (123)
000122     if curChar >= 98 and curChar <= 123 then
000123       compute curChar = curChar - 32
000124     end-if
*******    Only need to modify the character if it is a letter ('A' (66) to 'Z' (91))
000125     if curChar >= 66 and curChar <= 91 then
*******      Perform the shift
000126       compute curChar = curChar + newShift
*******      Check for wraparound on the 'Z' end
000127       compute diff = curChar - 91
000128       if diff > 0 then
*******        Do the wraparound. -1 at the end because diff of 1 means it should be 'A'
000129         compute curChar = 66 + diff - 1
000130       else
*******        Check wraparound on the 'A' end
000131         compute diff = 66 - curChar
000132         if (diff > 0) then
*******        Do the wraparound. +1 at the end because diff of 1 means it should be 'Z'
000133           compute curChar = 91 - diff + 1
000134         end-if
000135       end-if
*******      Update the character in the result string
000136       move function char(curChar) to res(idx:1)
000137     end-if
000138     add 1 to idx.
000139 End function encrypt.
000200 Identification division.
*******  This function decrypts a string based on the given shift amount
000201   Function-id. decrypt.
000202 Data division.
000203   Working-storage section.
*******    Represents the current character being analyzed
000204     1 curChar pic 999.
*******    Represents the index of the string being worked on
000205     1 idx pic 99.
*******    Represents the difference to determine wraparound
000206     1 diff pic S9(2).
*******    Shift value between -25 and 25
000207     1 newShift pic S9(2).
000208   Linkage section.
*******    The input string
000209     1 inStr pic x(32).
*******    The amount to shift by
000210     1 shiftAmt pic S999.
*******    The shifted string
000211     1 res pic x(32).
000212 Procedure division
000213   using by reference inStr shiftAmt
000214   returning res.
*******  Begin by copying the input to the result and set the index to 1
000215   Move inStr to res
000216   move 1 to idx
*******  Adjust the shift amount to be in the range -25 to 25
000217   compute newShift = function mod(shiftAmt 26)
*******  Repeat the work for all characters in the string
000218   perform decrypt-work until idx > function length(inStr)
000219   goback.
000220   decrypt-work.
*******    Get the current character's ordinal value (ASCII + 1)
000221     compute curChar = function ord(res(idx:1))
*******    Convert to uppercase if between 'a' (98) and 'z' (123)
000222     if curChar >= 98 and curChar <= 123 then
000223       compute curChar = curChar - 32
000224     end-if
*******    Only need to modify the character if it is a letter ('A' (66) to 'Z' (91))
000225     if curChar >= 66 and curChar <= 91 then
*******      Perform the shift
000226       compute curChar = curChar - newShift
*******      Check for wraparound on the 'Z' end
000227       compute diff = curChar - 91
000228       if diff > 0 then
*******        Do the wraparound. -1 at the end because diff of 1 means it should be 'A'
000229         compute curChar = 66 + diff - 1
000230       else
*******        Check wraparound on the 'A' end
000231         compute diff = 66 - curChar
000232         if (diff > 0) then
*******        Do the wraparound. +1 at the end because diff of 1 means it should be 'Z'
000233           compute curChar = 91 - diff + 1
000234         end-if
000235       end-if
*******      Update the character in the result string
000236       move function char(curChar) to res(idx:1)
000237     end-if
000238     add 1 to idx.
000239 End function decrypt.
000300 Identification division.
*******  Function to try to break a Caesar cipher
000301   Function-id. solve.
000302 Environment division.
000303   Configuration section.
000304     Repository.
*******      Have to import the decrypt function
000305       Function decrypt.
000306 Data division.
000307   Working-storage section.
*******    The current amount to shift by
000308     1 shiftAmt pic S999.
*******    Negated shiftAmt
000309     1 realShiftAmt pic S999.
*******    The result string for each call to decrypt
000310     1 outputStr pic x(32).
000311   Linkage section.
*******    The input string
000312     1 inStr pic x(32).
*******    The max shift amount to try
000313     1 maxShiftAmt pic S999.
*******    Have to return something, so will return 0
000314     1 res pic 9.
000315 Procedure division
000316   using by reference inStr maxShiftAmt
000317   returning res.
000318   Move 0 to res
*******  Get the absolute value for the shift amount to make sure it is positive
*******  In the end, -26 will be the same as +26
000319   move function abs(maxShiftAmt) to shiftAmt
*******  Repeat for all possible shift amounts
000320   perform solve-work until shiftAmt < 0
000321   goback.
000322   solve-work.
*******    Negate the shift amount
000323     compute realShiftAmt = shiftAmt * -1
*******    Try to decrypt the string and display the result
000324     move function decrypt(inStr realShiftAmt) to outputStr
000325     display "Caesar " shiftAmt ": " outputStr
000326     subtract 1 from shiftAmt.
000327 End function solve.
000000 Identification division.
000001   Program-id. caesar.
000002 Environment division.
000003   Configuration section.
000004     Repository.
000005       Function encrypt
000006       function decrypt
000007       function solve.
000008 Data division.
000009   Working-storage section.
000010     1 inStr pic x(32) value "This is a test string from Alan".
000011     1 shift pic S999 value -27.
000012     1 encryptRes pic x(32).
000013     1 decryptRes pic x(32).
000014     1 solveStr pic x(32) value "HAL".
000015     1 solveShift pic S999 value 26.
000016 Procedure division.
000017   Move encrypt(inStr shift) to encryptRes
000018   display encryptRes
000019   move decrypt(encryptRes shift) to decryptRes
000020   display decryptRes
000021   display solve(solveStr solveShift)
000022   goback.
000023 End program caesar.
