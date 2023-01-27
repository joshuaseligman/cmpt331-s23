object Caesar {
    // Function to encrypt a string by the given shift amount
    def encrypt(inputStr: String, shiftAmount: Int): String = {
        // Compute the actual shift amount being used
        val realShift: Int = shiftAmount % 26

        // String builder to put together the final string without copying the data
        var outputBuilder: StringBuilder = new StringBuilder()

        // Loop through the input string
        for (i <- 0 until inputStr.length) {
            // Get the current character ASCII value
            var charVal: Int = inputStr.charAt(i)

            // Convert to uppercase
            if (charVal >= 97 && charVal <= 122) {
                charVal -= 32
            }

            // Only have to do work if it is uppercase ('A' - 'Z')
            if (charVal >= 65 && charVal <= 90) {
                // Compute the shift
                charVal += realShift

                // Check for wraparound on the 'Z' end
                var diff: Int = charVal - 90
                if (diff > 0) {
                    // Perform the wraparound
                    charVal = 65 + diff - 1
                } else {
                    // Check for wraparound on the 'A' end
                    diff = 65 - charVal
                    if (diff > 0) {
                        // Perform the wraparound
                        charVal = 90 - diff + 1
                    }
                }
            }
            // Add the character to the output
            outputBuilder.append(charVal.toChar)
        }

        // Return the string
        return outputBuilder.toString()
    }

    // Function to decrypt a string by the given shift amount
    def decrypt(inputStr: String, shiftAmount: Int): String = {
        // Compute the actual shift amount being used
        val realShift: Int = shiftAmount % 26

        // String builder to put together the final string without copying the data
        var outputBuilder: StringBuilder = new StringBuilder()

        // Loop through the input string
        for (i <- 0 until inputStr.length) {
            // Get the current character ASCII value
            var charVal: Int = inputStr.charAt(i)

            // Convert to uppercase
            if (charVal >= 97 && charVal <= 122) {
                charVal -= 32
            }

            // Only have to do work if it is uppercase ('A' - 'Z')
            if (charVal >= 65 && charVal <= 90) {
                // Compute the shift
                charVal -= realShift

                // Check for wraparound on the 'Z' end
                var diff: Int = charVal - 90
                if (diff > 0) {
                    // Perform the wraparound
                    charVal = 65 + diff - 1
                } else {
                    // Check for wraparound on the 'A' end
                    diff = 65 - charVal
                    if (diff > 0) {
                        // Perform the wraparound
                        charVal = 90 - diff + 1
                    }
                }
            }
            // Add the character to the output
            outputBuilder.append(charVal.toChar)
        }

        // Return the string
        return outputBuilder.toString()
    }

    // Function to solve a Caesar cipher
    def solve(inputStr: String, maxShiftAmount: Int) = {
        // Normalize the max shift to be between 0 and 26
        var realMaxShiftAmount = maxShiftAmount.abs
        if (realMaxShiftAmount > 26) {
            realMaxShiftAmount = realMaxShiftAmount % 26
        }

        // Loop through each shift amount
        for (curShift <- realMaxShiftAmount to 0 by -1) {
            // Print the result of running decrypt on the string
            println(s"Caesar ${curShift}: ${decrypt(inputStr, -curShift)}")
        }
    }

    def main(args: Array[String]) = {
        val encryptOut: String = encrypt("This is a test string from Alan", -18)
        println(encryptOut)
        val decryptOut: String = decrypt(encryptOut, -18)
        println(decryptOut)
        solve("HAL", 26)
    }
}