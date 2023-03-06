(define (encryptStr str shiftAmt)
    ; Convert the input string to be upper case and split by character
    (set 'realStr (explode (upper-case str)))
    ; Get the mod because only need to work within -25 and 25
    (set 'realShift (mod shiftAmt 26))

    ; Map the transformation to each character
    (set 'newStr (map (lambda (strChar)
        ; Begin by getting the ASCII code
        (set 'newChar (char strChar))
        ; Only work with letters now
        (cond ((and (>= newChar 65) (<= newChar 90))
            ; Perform the shift
            (set 'newChar (+ newChar realShift))
            
            ; Check for the Z wraparound
            (set 'diff (- newChar 90))
            (cond
                ((> diff 0)
                    ; Do wraparound so anything beyond Z picks up at A
                    (set 'newChar (- (+ 65 diff) 1))
                )
                (true
                    ; Check for A wraparound
                    (set 'diff (- 65 newChar))
                    (cond
                        ((> diff 0)
                            ; Do wraparound so anything beyound A picks up at Z
                            (set 'newChar (+ (- 90 diff) 1))
                        )
                    )
                )
            )
        ))
        ; Convert to a character and return it
        (char newChar)
    ;  This is the input to the map function
    ) realStr))
    ; Join the exploded string and put it back together
    (join newStr "")
)

(define (decryptStr str shiftAmt)
  ; Decrypt is a negative encrypt
  (encryptStr str (* -1 shiftAmt))
)

(define (solve str maxShift)
  ; Make sure the shift is between 0 and 26
  (set 'realMaxShift maxShift)
  ; If negative, take absolute value
  (cond ((< realMaxShift 0) (set 'realMaxShift (* -1 realMaxShift))))
  ; If greater than 26, then take the mod
  (cond ((> realMaxShift 26) (set 'realMaxShift (mod realMaxShift 26))))
  (map (lambda (curShift)
         ; Call encrypt with the current shift amount
         (set 'out (encryptStr str curShift))
         (println "Caesar " curShift ": " out)
       )
       ; Generate a sequence from the max down to 0 (inclusive)
       (sequence realMaxShift 0)
  )
)

(println "Alan tests:")
(set 'encryptOut (encryptStr "This is a test string from Alan" 8))
(println encryptOut)
(set 'decryptOut (decryptStr encryptOut 8))
(println decryptOut)
(solve "HAL" 26)

(println "")
(println "Encrypt and decrypt tests:")
; Negative shift amount
(set 'encryptOut (encryptStr "This is a test string from Alan" -1))
(println encryptOut)
(set 'decryptOut (decryptStr encryptOut -1))
(println decryptOut)

; Modulus
(set 'encryptOut (encryptStr "This is a test string from Alan" 27))
(println encryptOut)
(set 'decryptOut (decryptStr encryptOut 27))
(println decryptOut)

; Empty string
(set 'encryptOut (encryptStr "" 7))
(println encryptOut)
(set 'decryptOut (decryptStr encryptOut 7))
(println decryptOut)

; Symbols and no letters
(set 'encryptOut (encryptStr "1234567890!@#$%^&*(){}" 7))
(println encryptOut)
(set 'decryptOut (decryptStr encryptOut 7))
(println decryptOut)

; Solve tests
(println "")
(println "Solve tests:")
; Negative shift amount
(solve "HAL" -26)
(println "")
; Modulus
(solve "HAL" 30)

; Needed for newlisp
(exit)
