(define (encryptStr str shiftAmt)
  ; Convert the input string to be upper case and split by character
  (set 'realStr (explode (upper-case str)))
  ; Get the mod because only need to work within -25 and 25
  (set 'realShift (mod shiftAmt 26))
  (println realStr)
  (println realShift)

  (map (lambda (strChar)
         ; Begin by getting the ASCII code
         (set 'newChar (char strChar))
         ; Only work with letters now
         (cond ((and (>= newChar 65) (<= newChar 90))
            ; Perform the shift
            (set 'newChar (+ newChar realShift))
            (println newChar)
            
            ; Check for the Z wraparound
            (set 'diff (- newChar 90))
            (cond
              ((> diff 0)
                (set 'newChar (+ (65 (- diff 1))))
              )
              (t
                ; Check for A wraparound
                (set 'diff (- 65 newChar))
                (cond ((> diff 0) (set 'newChar (- 90 (+ diff 1)))))
              )
            )
         ))
         (char newChar)
       )
       realStr)
  (println realStr)
)

(encryptStr "hello world" -28)

(exit)
