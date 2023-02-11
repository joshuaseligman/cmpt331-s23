.section .text
.global _start

_start:
    nop     # Needed for gdb to work properly

    # Alan encrypt and decrypt tests
    la      a0, alan_test
    li      a1, 31
    li      a2, 8
    call    encrypt

    li  a7, 64
    li  a0, 1
    la  a1, alan_test
    li  a2, 32
    ecall

    la      a0, alan_test
    li      a1, 31
    li      a2, 8
    call    decrypt

    li  a7, 64
    li  a0, 1
    la  a1, alan_test
    li  a2, 32
    ecall

    # Alan solve test
    la      a0, hal
    li      a1, 3
    li      a2, 26
    call    solve

    li  a7, 64
    li  a0, 1
    la  a1, empty_string
    li  a2, 1
    ecall

    # Test negative shift amounts
    la      a0, alan_test
    li      a1, 31
    li      a2, -1
    call    encrypt

    li  a7, 64
    li  a0, 1
    la  a1, alan_test
    li  a2, 32
    ecall

    la      a0, alan_test
    li      a1, 31
    li      a2, -1
    call    decrypt

    li  a7, 64
    li  a0, 1
    la  a1, alan_test
    li  a2, 32
    ecall

    # Test modulus with encrypt and decrypt
    la      a0, alan_test
    li      a1, 31
    li      a2, 27
    call    encrypt

    li  a7, 64
    li  a0, 1
    la  a1, alan_test
    li  a2, 32
    ecall

    la      a0, alan_test
    li      a1, 31
    li      a2, 27
    call    decrypt

    li  a7, 64
    li  a0, 1
    la  a1, alan_test
    li  a2, 32
    ecall

    # Test an empty string
    la      a0, empty_string
    li      a1, 0
    li      a2, 7
    call    encrypt

    li  a7, 64
    li  a0, 1
    la  a1, empty_string
    li  a2, 1
    ecall

    la      a0, empty_string
    li      a1, 0
    li      a2, 7
    call    decrypt

    li  a7, 64
    li  a0, 1
    la  a1, empty_string
    li  a2, 1
    ecall

    # Test with no letters (only numbers and symbols)
    la      a0, no_letters
    li      a1, 0
    li      a2, 22
    call    encrypt

    li  a7, 64
    li  a0, 1
    la  a1, no_letters
    li  a2, 23
    ecall

    la      a0, no_letters
    li      a1, 22
    li      a2, 7
    call    decrypt

    li  a7, 64
    li  a0, 1
    la  a1, no_letters
    li  a2, 23
    ecall

    li  a7, 64
    li  a0, 1
    la  a1, empty_string
    li  a2, 1
    ecall

    # Test abs with solve
    la      a0, hal
    li      a1, 3
    li      a2, -26
    call    solve

    li  a7, 64
    li  a0, 1
    la  a1, empty_string
    li  a2, 1
    ecall

    # Test modulus with solve
    la      a0, hal
    li      a1, 3
    li      a2, 30
    call    solve

    addi    a7, zero, 93 # exit sys call
    addi    a0, zero, 0 # exit status 0
    ecall

# a0 = address of the string to encrypt
# a1 = length of the string
# a2 = shift amount
encrypt:
    mv  t0, a0 # Copy string address into a temporary register
    li  t1, 0 # Conter variable for the character we are on
    mv  t2, a2 # Move the shift amount into a temporary register
    li  t6, 26 # Used for getting the mod of the shift amount

    # If shift > 26, then keep subtracting until < 26
    encrypt_positive_mod:
        blt t2, t6, encrypt_change_limit
        sub t2, t2, t6
        j   encrypt_positive_mod
    
    # Change to -26 for next check
    encrypt_change_limit:
        li t6, -26

    # If shift < -26, then keep subtracting -26 (add 26) until > -26
    encrypt_negative_mod:
        blt t6, t2, encrypt_loop
        sub t2, t2, t6
        j encrypt_negative_mod

    # The actual encryption loop
    encrypt_loop:
        lb  t3, 0(t0) # Get the current character
        li  t5, 97 # a
        li  t6, 122 # z
        
        # Convert to uppercase if needed
        blt t3, t5, encrypt_conversion
        blt t6, t3, encrypt_conversion
        addi    t3, t3, -32 # Convert to uppercase

        encrypt_conversion:
            li  t5, 65 # A
            li  t6, 90 # Z

            # Only continue if there is a letter
            blt t3, t5, encrypt_check_loop
            blt t6, t3, encrypt_check_loop
            add t3, t3, t2

            sub t4, t3, t6 # character - 90 (check for Z wraparound)
            bge zero, t4, encrypt_lower_wraparound
            # Char value is A (t5) + diff (t4) - 1
            add t3, t4, t5
            addi t3, t3, -1

            # Can go straight to storing as we do not need to worry about A wraparound
            j encrypt_store_char

            encrypt_lower_wraparound:
                sub t4, t5, t3 # 65 - char (check for A wraparound)
                bge zero, t4, encrypt_store_char
                # Char value is Z (t6) - diff (t4) + 1
                sub t3, t6, t4
                addi t3, t3, 1

            encrypt_store_char:
                sb  t3, 0(t0) # Store it in the output string

            encrypt_check_loop:
                addi t0, t0, 1 # Move to next byte
                addi t1, t1, 1 # Increment the counter
                ble t1, a1, encrypt_loop # Loop if there is still more to do
    ret

# a0 = address of the string to decrypt
# a1 = length of the string
# a2 = shift amount
decrypt:
    mv  t0, a0 # Copy string address into a temporary register
    li  t1, 0 # Conter variable for the character we are on
    mv  t2, a2 # Move the shift amount into a temporary register
    li  t6, 26 # Used for getting the mod of the shift amount

    # If shift > 26, then keep subtracting until < 26
    decrypt_positive_mod:
        blt t2, t6, decrypt_change_limit
        sub t2, t2, t6
        j   decrypt_positive_mod
    
    # Change to -26 for next check
    decrypt_change_limit:
        li t6, -26

    # If shift < -26, then keep subtracting -26 (add 26) until > -26
    decrypt_negative_mod:
        blt t6, t2, decrypt_loop
        sub t2, t2, t6
        j decrypt_negative_mod

    # The actual encryption loop
    decrypt_loop:
        lb  t3, 0(t0) # Get the current character
        li  t5, 97 # a
        li  t6, 122 # z
        
        # Convert to uppercase if needed
        blt t3, t5, decrypt_conversion
        blt t6, t3, decrypt_conversion
        addi    t3, t3, -32 # Convert to uppercase

        decrypt_conversion:
            li  t5, 65 # A
            li  t6, 90 # Z

            # Only continue if there is a letter
            blt t3, t5, decrypt_check_loop
            blt t6, t3, decrypt_check_loop
            sub t3, t3, t2

            sub t4, t3, t6 # character - 90 (check for Z wraparound)
            bge zero, t4, decrypt_lower_wraparound
            # Char value is A (t5) + diff (t4) - 1
            add t3, t4, t5
            addi t3, t3, -1

            # Can go straight to storing as we do not need to worry about A wraparound
            j decrypt_store_char

            decrypt_lower_wraparound:
                sub t4, t5, t3 # 65 - char (check for A wraparound)
                bge zero, t4, decrypt_store_char
                # Char value is Z (t6) - diff (t4) + 1
                sub t3, t6, t4
                addi t3, t3, 1

            decrypt_store_char:
                sb  t3, 0(t0) # Store it in the output string

            decrypt_check_loop:
                addi t0, t0, 1 # Move to next byte
                addi t1, t1, 1 # Increment the counter
                ble t1, a1, decrypt_loop # Loop if there is still more to do
    ret

# a0 = address of the string to solve
# a1 = string length
# a2 = max shift amount
solve:
    mv t0, a2 # Store the current shift amount
    li t1, 26 # 26 constant for use to take the modulus

    solve_abs:
        # Negate the value if needed to make it positive
        bge t0, zero, solve_mod
        neg t0, t0

    # Take the mod to make the max shift <= 26
    solve_mod:
        ble t0, t1, solve_loop
        sub t0, t0, t1
        j   solve_mod

    solve_loop:
        # Break when less than 0
        blt t0, zero, solve_break

        # Negate the current shift amount for the decrypt function
        neg a2, t0

        # Push the current shift amount and return address onto the stack
        addi sp, sp, -8
        sw ra, 4(sp)
        sw t0, 0(sp)

        call decrypt

        # Pop the current shift amount from the stack
        lw t0, 0(sp)
        lw ra, 4(sp)
        addi sp, sp, 8

        # Print out the current shifted string
        li  a7, 64
        addi a2, a1, 1
        mv  a1, a0
        li  a0, 1
        ecall

        # Reset the registers to work with decrypt
        mv a0, a1
        addi a1, a2, -1
        mv a2, t0

        # We now have to call decrypt with the non-negated shift amount
        # because decrypt modifies the original string, so we need to fix that

        # Push the current shift amount and return address onto the stack
        addi sp, sp, -8
        sw ra, 4(sp)
        sw t0, 0(sp)

        call decrypt

        # Pop the current shift amount from the stack
        lw t0, 0(sp)
        lw ra, 4(sp)
        addi sp, sp, 8

        # Decrement the shift amount
        addi t0, t0, -1

        # Go back to the top
        j solve_loop

    solve_break:
        ret

alan_test:
    .ascii "This is a test string from Alan\n"
  
hal:
    .ascii "HAL\n"

empty_string:
    .ascii "\n"

no_letters:
    .ascii "1234567890!@#$%^&*(){}\n"