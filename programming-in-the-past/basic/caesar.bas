10 print "hello world"
20 encryptinput$ = "This is a test string from Alan"
30 encryptoutput$ = ""
40 decryptinput$ = ""
50 decryptoutput$ = ""
60 shiftamount% = 8
70 gosub 1000
71 print encryptoutput$
72 decryptinput$ = encryptoutput$
80 gosub 2000
90 print decryptoutput$
100 end
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
