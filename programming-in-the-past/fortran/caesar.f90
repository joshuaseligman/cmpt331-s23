program caesar
    implicit none
    character(11) :: s1
    character(11) :: s2
    s1 = 'hello world'
    call encrypt(s1, 11, 8, s2)
    print *, s2
contains
    subroutine encrypt(inputString, stringLength, shiftAmount, outputString)
        implicit none
        integer, intent(in) :: stringLength, shiftAmount
        character(stringLength), intent(in) :: inputString
        character(stringLength) :: outputString
        integer :: index, charValue
        outputString = inputString

        ! http://computer-programming-forum.com/49-fortran/4075a24f74fcc9ce.htm
        do index = 1, len(outputString)
            charValue = ichar(outputString(index:index))
            print *, charValue
            if (charValue >= 97 .and. charValue <= 122) then
                charValue = charValue - 32
                outputString(index:index) = char(charValue)
            endif
        enddo
    end subroutine encrypt
end program caesar