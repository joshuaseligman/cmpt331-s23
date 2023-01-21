10 print "hello world"
20 encryptinput$ = "This is a test string from Alan"
30 encryptoutput$ = ""
40 decryptinput$ = ""
50 decryptoutput$ = ""
60 shiftamount% = 8
70 solveInput$ = "HAL"
80 gosub 1000
81 print encryptoutput$
82 decryptinput$ = encryptoutput$
90 gosub 2000
100 print decryptoutput$
110 shiftAmount% = 26
120 gosub 3000
999 end
1000 encryptoutput$ = ucase$(encryptinput$)
1010 realShift% = shiftamount% mod 26
1020 for index% = 1 to len(encryptoutput$)
1030 char% = asc(mid$(encryptoutput$, index%, 1))
1040 if char% >= 65 and char% <= 90 then
1050 char% = char% + realShift%
1060 diff% = char% - 90
1070 if diff% > 0 then
1080 char% = 65 + diff% - 1
1090 else
1100 diff% = 65 - char%
1110 if diff% > 0 then
1120 char% = 90 - diff% + 1
1130 endif
1140 endif
1150 mid$(encryptoutput$, index%, 1) = chr$(char%)
1160 endif
1170 next index%
1180 return
2000 decryptoutput$ = ucase$(decryptinput$)
2010 realShift% = shiftamount% mod 26
2020 for index% = 1 to len(decryptoutput$)
2030 char% = asc(mid$(decryptoutput$, index%, 1))
2040 if char% >= 65 and char% <= 90 then
2050 char% = char% - realShift%
2060 diff% = char% - 90
2070 if diff% > 0 then
2080 char% = 65 + diff% - 1
2090 else
2100 diff% = 65 - char%
2110 if diff% > 0 then
2120 char% = 90 - diff% + 1
2130 endif
2140 endif
2150 mid$(decryptoutput$, index%, 1) = chr$(char%)
2160 endif
2170 next index%
2180 return
3000 realShift% = abs(shiftAmount%)
3010 if realShift% > 26 then
3020 realShift% = realShift% mod 26
3030 endif
3040 decryptinput$ = solveInput$
3050 for shift% = realShift% to 0 step -1
3060 shiftAmount% = -shift%
3070 gosub 2000
3080 print "Caesar " shift% ": " decryptoutput$
3090 next shift%
3100 return