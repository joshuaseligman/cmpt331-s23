000000 Identification division.
000001   Function-id. encrypt.
000002 Data division.
000000   Working-storage section.
000000     1 curChar pic 999.
000000     1 idx pic 99 value 1.
000000     1 diff pic S9(2).
000000     1 newShift pic S9(2).
000003   Linkage section.
000004     1 inStr pic x(32).
000000     1 shiftAmt pic S999.
000005     1 res pic x(32).
000006 Procedure division
000007   using by reference inStr shiftAmt
000008   returning res.
000009   Move inStr to res
000000   compute newShift = function mod(shiftAmt, 26)
000000   display inStr " - " shiftAmt
000000   perform encrypt-work until idx > function length(inStr)
000011   goback.
000000   encrypt-work.
000000     compute curChar = function ord(res(idx:1))
000000     if curChar >= 98 and curChar <= 123 then
000000       compute curChar = curChar - 32
000000     end-if
000000     if curChar >= 66 and curChar <= 91 then
000000       compute curChar = curChar + newShift
000000       compute diff = curChar - 91
000000       if diff > 0 then
000000         compute curChar = 66 + diff - 1
000000       else
               compute diff = 66 - curChar
               if (diff > 0) then
                 compute curChar = 91 - diff + 1
               end-if
000000       end-if
000000       move function char(curChar) to res(idx:1)
000000     end-if
000000     add 1 to idx.
000012 End function encrypt.
000000 Identification division.
000001   Function-id. decrypt.
000002 Data division.
000000   Working-storage section.
000000     1 curChar pic 999.
000000     1 idx pic 99 value 1.
000000     1 diff pic S9(2).
000000     1 newShift pic S9(2).
000003   Linkage section.
000004     1 inStr pic x(32).
000000     1 shiftAmt pic S999.
000005     1 res pic x(32).
000006 Procedure division
000007   using by reference inStr shiftAmt
000008   returning res.
000009   Move inStr to res
000000   compute newShift = function mod(shiftAmt, 26)
000000   display inStr " - " shiftAmt
000000   perform decrypt-work until idx > function length(inStr)
000011   goback.
000000   decrypt-work.
000000     compute curChar = function ord(res(idx:1))
000000     if curChar >= 98 and curChar <= 123 then
000000       compute curChar = curChar - 32
000000     end-if
000000     if curChar >= 66 and curChar <= 91 then
000000       compute curChar = curChar - newShift
000000       compute diff = curChar - 91
000000       if diff > 0 then
000000         compute curChar = 66 + diff - 1
000000       else
               compute diff = 66 - curChar
               if (diff > 0) then
                 compute curChar = 91 - diff + 1
               end-if
000000       end-if
000000       move function char(curChar) to res(idx:1)
000000     end-if
000000     add 1 to idx.
000012 End function decrypt.
000100 Identification division.
000101   Program-id. caesar.
000102 Environment division.
000103   Configuration section.
000104     Repository.
000105       Function encrypt
00000        Function decrypt.
000106 Data division.
000107   Working-storage section.
000108     1 inStr pic x(32) value "This is a test string from Alan".
000000     1 shift pic S999 value -27.
000108     1 encryptRes pic x(32).
000000     1 decryptRes pic x(32).
000109 Procedure division.
000110   Move encrypt(inStr shift) to encryptRes
000111   Display encryptRes
000000   Move decrypt(encryptRes shift) to decryptRes
000000   display decryptRes
000112   Goback.
000113 End program caesar.
