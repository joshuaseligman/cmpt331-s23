9 rem Define the strings for the encryption input and output
10 encryptinput$ = "This is a test string from Alan"
20 encryptoutput$ = ""
29 rem Define the strings for the decrytion input and output
30 decryptinput$ = ""
40 decryptoutput$ = ""
49 rem Define the shift amount for encrypt and decrypt
50 shiftamount% = 8
59 rem Call the encrypt subroutine and print the output
60 gosub 1000
70 print encryptoutput$
79 rem Set the decrypt input to be what the encrypt output was
80 decryptinput$ = encryptoutput$
89 rem Call decrypt with the same shift amount as encrypt
90 gosub 2000
100 print decryptoutput$
109 rem Set the solve variables for the string and the amount
110 solveInput$ = "HAL"
120 shiftAmount% = 26
129 rem Call solve with the given variables
130 gosub 3000
140 end
1000 goto 1010
1009 rem Encrypt output starts off as an uppercase version of the input
1010 encryptoutput$ = ucase$(encryptinput$)
1019 rem Shift amount should be between -25 and 25
1020 realShift% = shiftamount% mod 26
1029 rem Loop through every character in the string
1030 for index% = 1 to len(encryptoutput$)
1039 rem Get the ascii code
1040 char% = asc(mid$(encryptoutput$, index%, 1))
1050 if char% >= 65 and char% <= 90 then
1059 rem Do the shift if it is a letter
1060 char% = char% + realShift%
1069 rem Check to see if there is wraparound on the 'Z' end
1070 diff% = char% - 90
1080 if diff% > 0 then
1089 rem Wrap the character around to the 'A' side
1090 char% = 65 + diff% - 1
1100 else
1109 rem Check to see if there is wraparound on the 'A' end
1110 diff% = 65 - char%
1120 if diff% > 0 then
1129 rem Wrap the character around to the 'Z' side
1130 char% = 90 - diff% + 1
1140 endif
1150 endif
1159 rem Only have to replace the character if it is a letter
1160 mid$(encryptoutput$, index%, 1) = chr$(char%)
1170 endif
1180 next index%
1190 return
2000 goto 2010
2009 rem Decrypt output starts off as an uppercase version of the input
2010 decryptoutput$ = ucase$(decryptinput$)
2019 rem Shift amount should be between -25 and 25
2020 realShift% = shiftamount% mod 26
2029 rem Loop through every character in the string
2030 for index% = 1 to len(decryptoutput$)
2039 rem Get the ascii code
2040 char% = asc(mid$(decryptoutput$, index%, 1))
2050 if char% >= 65 and char% <= 90 then
2059 rem Do the shift if it is a letter
2060 char% = char% - realShift%
2069 rem Check to see if there is wraparound on the 'Z' end
2070 diff% = char% - 90
2080 if diff% > 0 then
2089 rem Wrap the character around to the 'A' side
2090 char% = 65 + diff% - 1
2100 else
2109 rem Check to see if there is wraparound on the 'A' end
2110 diff% = 65 - char%
2120 if diff% > 0 then
2129 rem Wrap the character around to the 'Z' side
2130 char% = 90 - diff% + 1
2140 endif
2150 endif
2159 rem Only have to replace the character if it is a letter
2160 mid$(decryptoutput$, index%, 1) = chr$(char%)
2170 endif
2180 next index%
2190 return
3000 goto 3010
3009 rem Only need positive shift amounts
3010 realShift% = abs(shiftAmount%)
3020 if realShift% > 26 then
3029 rem Take the mod of the shift is greater than 26
3030 realShift% = realShift% mod 26
3040 endif
3049 rem Decrypt takes in the solve input string
3050 decryptinput$ = solveInput$
3060 for shift% = realShift% to 0 step -1
3069 rem Update the shift amount according to the current step in the loop
3070 shiftAmount% = -shift%
3079 rem Call decrypt and print the result
3080 gosub 2000
3090 print "Caesar " shift% ": " decryptoutput$
3100 next shift%
3110 return