program caesar
    implicit none
    character(31) :: s1
    character(31) :: s2
    character(31) :: s3
    s1 = 'This is a test string from Alan'
    call encrypt(s1, 31, 8, s2)
    print *, s2
    call decrypt(s2, 31, 8, s3)
    print *, s3

    call solve('HAL', 3, 26)
contains
    subroutine encrypt(inputString, stringLength, shiftAmount, outputString)
        implicit none
        integer, intent(in) :: stringLength, shiftAmount
        character(stringLength), intent(in) :: inputString
        character(stringLength) :: outputString
        integer :: index, charValue, diff
        outputString = inputString

        ! http://computer-programming-forum.com/49-fortran/4075a24f74fcc9ce.htm
        do index = 1, len(outputString)
            charValue = ichar(outputString(index:index))
            if (charValue >= 97 .and. charValue <= 122) then
                charValue = charValue - 32
            endif
            if (charValue >= 65 .and. charValue <= 90) then
                charValue = charValue + shiftAmount
                diff = charValue - 90
	            if (diff > 0) then
                    charValue = 65 + diff - 1
	            endif
                outputString(index:index) = char(charValue)
	        endif
        enddo
    end subroutine encrypt

    subroutine decrypt(inputString, stringLength, shiftAmount, outputString)
        implicit none
        integer, intent(in) :: stringLength, shiftAmount
        character(stringLength), intent(in) :: inputString
        character(stringLength) :: outputString
        integer :: index, charValue, diff
        outputString = inputString

        ! http://computer-programming-forum.com/49-fortran/4075a24f74fcc9ce.htm
        do index = 1, len(outputString)
            charValue = ichar(outputString(index:index))
            if (charValue >= 97 .and. charValue <= 122) then
                charValue = charValue - 32
            endif
            if (charValue >= 65 .and. charValue <= 90) then
                charValue = charValue - shiftAmount
                diff = 65 - charValue
	            if (diff > 0) then
                    charValue = 90 - diff + 1
	            endif
                outputString(index:index) = char(charValue)
	        endif
        enddo
    end subroutine decrypt

    subroutine solve(inputString, stringLength, maxShiftValue)
        implicit none
        integer, intent(in) :: stringLength, maxShiftValue
        character(stringLength), intent(in) :: inputString
        character(stringLength) :: outputString
        integer :: shiftAmount

        do shiftAmount = maxShiftValue, 0, -1
            call encrypt(inputString, stringLength, shiftAmount, outputString)
            ! https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap05/format.html
            print '(a,I0,a,a)', 'Caesar ', shiftAmount, ': ', outputString
        enddo
    end subroutine solve
end program caesar