object Caesar {
    def encrypt(inputStr: String, shiftAmount: Int): String = {
        val realShift: Int = shiftAmount % 26

        var outputBuilder: StringBuilder = new StringBuilder()

        for (i <- 0 until inputStr.length) {
            var charVal: Int = inputStr.charAt(i)

            if (charVal >= 97 && charVal <= 122) {
                charVal -= 32;
            }

            if (charVal >= 65 && charVal <= 90) {
                charVal += realShift;

                var diff: Int = charVal - 90;
                if (diff > 0) {
                    charVal = 65 + diff - 1;
                } else {
                    diff = 65 - charVal;
                    if (diff > 0) {
                        charVal = 90 - diff + 1;
                    }
                }
            }
            outputBuilder.append(charVal.toChar)
        }

        return outputBuilder.toString()
    }

    def main(args: Array[String]) = {
        println(encrypt("This is a test string from Alan", 8));
    }
}