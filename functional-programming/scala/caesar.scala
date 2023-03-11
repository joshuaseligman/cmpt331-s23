object Caesar {
    
    // Function to perform a shift on a caesar cipher
    def performShift(c: Char, shift: Int): Char = {
        // Have to work with integers, so do the conversion
        var newChar: Int = c.toInt;
        if (newChar >= 65 && newChar <= 90) {
            // Only perform shift on letters
            newChar = newChar + shift;

            if (newChar > 90) {
                // Handle Z wraparound
                newChar = 65 + newChar - 90 - 1;
            } else if (newChar < 65) {
                // Handle A wraparound
                newChar = 90 - 65 + newChar + 1;
            }
        }
        // Convert the int back to a char to be returned
        return newChar.toChar;
    }

    // Function to encrypt a string by the given shift amount
    def encrypt(inputStr: String, shiftAmount: Int): String = {
        // Compute the actual shift amount being used
        val realShift: Int = shiftAmount % 26;
        
        // Get the array of characters
        var stringChars: Array[Char] = inputStr.toUpperCase().toCharArray();

        // Perform the shift on each character in the array
        var newChars: Array[Char] = stringChars.map((c: Char) => performShift(c, realShift));

        // Create a new string with the shifted characters
        return String.copyValueOf(newChars);
    }

    // Function to decrypt a string by the given shift amount
    def decrypt(inputStr: String, shiftAmount: Int): String = {
        // Decrypt is negative encrypt
        return encrypt(inputStr, -shiftAmount);
    }

    /// Helper function for solve that returns nothing in practice
    def solveHelper(inputStr: String, shiftAmount: Int): Unit = {
        // Print the result of the encrypt function
        println(s"Caesar ${shiftAmount}: ${encrypt(inputStr, shiftAmount)}");
        if (shiftAmount > 0) {
            // Only continue if there is still more to do
            solveHelper(inputStr, shiftAmount - 1);
        }
    }

    // Function to solve a Caesar cipher
    def solve(inputStr: String, maxShiftAmount: Int) = {
        // Clean up the max shift amount
        var realMaxShift: Int = Math.abs(maxShiftAmount);
        if (realMaxShift > 26) {
            realMaxShift = realMaxShift % 26;
        }

        // Call the helper function starting with the max shift
        solveHelper(inputStr, realMaxShift);
    }

    def main(args: Array[String]) = {
        println("Alan tests:");
        var encryptOut: String = encrypt("This is a test string from Alan", 8);
        println(encryptOut);
        var decryptOut: String = decrypt(encryptOut, 8);
        println(decryptOut);
        solve("HAL", 26);

        println("\nEncrypt and decrypt tests:");
        // Test negative shift amount
        encryptOut = encrypt("This is a test string from Alan", -1);
        println(encryptOut);
        decryptOut = decrypt(encryptOut, -1);
        println(decryptOut);

        // Test modulus
        encryptOut = encrypt("This is a test string from Alan", 27);
        println(encryptOut);
        decryptOut = decrypt(encryptOut, 27);
        println(decryptOut);

        // Test empty string
        encryptOut = encrypt("", 27);
        println(encryptOut);
        decryptOut = decrypt(encryptOut, 27);
        println(decryptOut);

        // Test no letters
        encryptOut = encrypt("1234567890!@#$%^&*(){}", 27);
        println(encryptOut);
        decryptOut = decrypt(encryptOut, 27);
        println(decryptOut);

        println("\nSolve tests:");
        // Test absolute value
        solve("HAL", -26);
        println();
        // Test modulus
        solve("HAL", 30);
    }
}
