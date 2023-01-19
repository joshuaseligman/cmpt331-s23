000000 Identification division.
000001   Function-id. encrypt.
000002 Data division.
000000   Working-storage section.
000000     1 curChar pic 999.
000000     1 idx pic 99 value 1.
000000     1 diff pic S99.
000003   Linkage section.
000004     1 inStr pic x(32).
000000     1 shiftAmt pic 99.
000005     1 res pic x(32).
000006 Procedure division
000007   using by reference inStr shiftAmt
000008   returning res.
000009   Move inStr to res
000000   display inStr " - " shiftAmt
000000   perform encrypt-work until idx > 32
000011   goback.
000000   encrypt-work.
000000     compute curChar = function ord(res(idx:1))
000000     if curChar >= 98 and curChar <= 123 then
000000       compute curChar = curChar - 32
000000     end-if
000000     if curChar >= 66 and curChar <= 91 then
000000       compute curChar = curChar + shiftAmt
000000       compute diff = curChar - 91
000000       if diff > 0 then
000000         compute curChar = 66 + diff - 1
000000       end-if
000000       move function char(curChar) to res(idx:1)
000000     end-if
000000     add 1 to idx.
000012 End function encrypt.
000100 Identification division.
000101   Program-id. caesar.
000102 Environment division.
000103   Configuration section.
000104     Repository.
000105       Function encrypt.
000106 Data division.
000107   Working-storage section.
000108     1 inStr pic x(32) value "This is a test string from Alan".
000108     1 result pic x(32) usage display.
000109 Procedure division.
000110   Move encrypt(inStr 08) to result
000111   Display result
000112   Goback.
000113 End program caesar.
