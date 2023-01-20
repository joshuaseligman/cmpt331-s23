! Entrypoint for the program
program caesar
    ! We need to make sure that all variable types are explicitly defined
    implicit none

    ! We will need 3 strings, the original, the output for encrypt, and the output for decrypt
    character(31) :: original
    character(31) :: encryptOutput
    character(31) :: decryptOutput

    original = 'This is a test string from Alan'

    ! Call encrypt on the original string with a shift of 8
    call encrypt(original, 31, -27, encryptOutput)
    print *, encryptOutput

    ! Decrypt the encrypted value with the shift of 8
    call decrypt(encryptOutput, 31, -27, decryptOutput)
    print *, decryptOutput

    ! Call the solve subroutine
    call solve('HAL', 3, 26)
    
contains

    ! Subroutine to encrypt a string of size stringLength by shiftAmount and store the result in outputString
    subroutine encrypt(inputString, stringLength, shiftAmount, outputString)
        implicit none

        ! stringLength is needed so the type of inputString and outputString can be explicitly defined by their length
        ! shiftAmount is the amount to shift the string by
        integer, intent(in) :: stringLength, shiftAmount

        ! inputString will not be modified and is a character type of size stringLength
        character(stringLength), intent(in) :: inputString
        ! outputString will be modified and has the same length as inputString
        character(stringLength) :: outputString

        ! newShift will be used to make sure the shift amount is between -25 and 25
        ! index will be used to iterate through the string character by character
        ! charValue is the ASCII value of a given character
        ! diff will be used to determine if the wraparound calculation is needed
        integer :: newShift, index, charValue, diff

        ! Start off by setting outputString to the same value is inputString
        outputString = inputString

        ! Convert the shift amount to be between -25 and 25
        newShift = mod(shiftAmount, 26)

        ! Iterate through the string one character at a time
        ! Looping and modifying individual characters found at the link below
        ! http://computer-programming-forum.com/49-fortran/4075a24f74fcc9ce.htm
        do index = 1, len(outputString)
            ! Get the original character value at the given position
            charValue = ichar(outputString(index:index))

            ! Check to see if it is a lowercase letter ('a' - 'z')
            if (charValue >= 97 .and. charValue <= 122) then
                ! If so, make it capital by subtracting 32 ('a' - 'A')
                charValue = charValue - 32
            endif

            ! Make sure the character is a letter ('A' - 'Z') because already converted to uppercase
            if (charValue >= 65 .and. charValue <= 90) then
                ! Perform the shift by the given amount
                charValue = charValue + newShift

                ! diff is how much over the charater is relative to 'Z' (90)
                diff = charValue - 90

                ! If it went over, wraparound is needed
                if (diff > 0) then
                    ! Finish the wraparound by adding the diff to 'A' (65)
                    ! The -1 is needed because a diff of 1 means that the character is 1 beyond 'Z', which will be 'A'
                    charValue = 65 + diff - 1
                else
                    ! diff is how much under the charater is relative to 'A' (65)
                    diff = 65 - charValue

                    ! If it went under, wraparound is needed
                    if (diff > 0) then
                        ! Finish the wraparound by subtracting the diff from 'Z' (90)
                        ! The +1 is needed because a diff of 1 means that the character is 1 beyond 'A', which will be 'Z'
                        charValue = 90 - diff + 1
                    endif
                endif

                ! Update the output string at the index with the new character value
                ! If the character was not originally a letter, then no change is needed, which is why this is inside of the if block
                outputString(index:index) = char(charValue)
            endif
        enddo
    end subroutine encrypt

    ! Subroutine to decrypt a string of size stringLength that has been encrypted by shiftAmount and store the result in outputString
    subroutine decrypt(inputString, stringLength, shiftAmount, outputString)
        implicit none

        ! stringLength is needed so the type of inputString and outputString can be explicitly defined by their length
        ! shiftAmount is the amount to unshift by
        integer, intent(in) :: stringLength, shiftAmount

        ! inputString will not be modified and is a character type of size stringLength
        character(stringLength), intent(in) :: inputString
        ! outputString will be modified and has the same length as inputString
        character(stringLength) :: outputString

        ! newShift will be used to make sure the shift amount is between -25 and 25
        ! index will be used to iterate through the string character by character
        ! charValue is the ASCII value of a given character
        ! diff will be used to determine if the wraparound calculation is needed
        integer :: newShift, index, charValue, diff

        ! Start off by setting outputString to the same value is inputString
        outputString = inputString

        ! Convert the shift amount to be between -25 and 25
        newShift = mod(shiftAmount, 26)

        ! Iterate through the string one character at a time
        ! Looping and modifying individual characters found at the link below
        ! http://computer-programming-forum.com/49-fortran/4075a24f74fcc9ce.htm
        do index = 1, len(outputString)
            ! Get the original character value at the given position
            charValue = ichar(outputString(index:index))

            ! Check to see if it is a lowercase letter ('a' - 'z')
            if (charValue >= 97 .and. charValue <= 122) then
                ! If so, make it capital by subtracting 32 ('a' - 'A')
                charValue = charValue - 32
            endif

            ! Make sure the character is a letter ('A' - 'Z') because already converted to uppercase
            if (charValue >= 65 .and. charValue <= 90) then
                ! Perform the unshift by the given amount
                charValue = charValue - newShift

                ! diff is how much under the charater is relative to 'A' (65)
                diff = 65 - charValue

                ! If it went under, wraparound is needed
                if (diff > 0) then
                    ! Finish the wraparound by subtracting the diff from 'Z' (90)
                    ! The +1 is needed because a diff of 1 means that the character is 1 beyond 'A', which will be 'Z'
                    charValue = 90 - diff + 1
                else
                    ! diff is how much over the charater is relative to 'Z' (90)
                    diff = charValue - 90

                    ! If it went over, wraparound is needed
                    if (diff > 0) then
                        ! Finish the wraparound by adding the diff to 'A' (65)
                        ! The -1 is needed because a diff of 1 means that the character is 1 beyond 'Z', which will be 'A'
                        charValue = 65 + diff - 1
                    endif
                endif

                ! Update the output string at the index with the new character value
                ! If the character was not originally a letter, then no change is needed, which is why this is inside of the if block
                outputString(index:index) = char(charValue)
            endif
        enddo
    end subroutine decrypt

    ! Subroutine to solve a caesar cipher of the input string of size stringLength with a set number of tries (maxShiftValue)
    subroutine solve(inputString, stringLength, maxShiftValue)
        implicit none

        ! stringLength is needed so the type of inputString and outputString can be explicitly defined by their length
        ! shiftAmount is the amount to unshift by
        integer, intent(in) :: stringLength, maxShiftValue

        ! inputString will not be modified and is a character type of size stringLength
        character(stringLength), intent(in) :: inputString

        ! outputString is a temporary variable that will be used as the result from each solve attempt
        character(stringLength) :: outputString

        ! shiftAmount is the current amount being shifted
        integer :: shiftAmount

        ! Try all shift amounts from the max down to 0
        do shiftAmount = maxShiftValue, 0, -1
            ! Call the decrypt subroutine with the current shiftAmount and store in outputString
            call decrypt(inputString, stringLength, -shiftAmount, outputString)

            ! Print out the results
            ! Formatting strings found at the link below
            ! https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap05/format.html
            print '(a,I0,a,a)', 'Caesar ', shiftAmount, ': ', outputString
        enddo
    end subroutine solve
end program caesar