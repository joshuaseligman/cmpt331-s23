program caesar
    implicit none
    character(31) :: s1
    character(31) :: s2
    s1 = 'This is a test string from Alan'
    call encrypt(s1, 31, 8, s2)
    print *, s2
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
	        endif
            outputString(index:index) = char(charValue)
        enddo
    end subroutine encrypt
end program caesar