// Encrypts a string with the given shift
function encrypt(inStr, shiftAmt) {
    // Take the mod because only woking between -25 and 25
    shiftAmt = shiftAmt % 26;
    // Convert the string to uppercase and split by character
    // And create a new array using the map function
    return inStr.toUpperCase().split('').map(c => {
        // Get the char code of the character
        let charNum = c.charCodeAt(0);
        // Only shift on letters
        if (charNum >= 65 && charNum <= 90) {
            // Do the shift
            let newChar = charNum + shiftAmt;
            if (newChar > 90) {
                // Handle Z wraparound
                newChar = 65 + newChar - 90 - 1;
            } else if (newChar < 65) {
                // Handle A wraparound
                newChar = 90 - 65 + newChar + 1;
            }
            // Set the charNum to be newChar if a shift was done
            charNum = newChar;
        }
        // Return the character based on the code
        return String.fromCharCode(charNum);
    // Join the array into one big string with no separation of characters
    }).join('');
}

// Function that decrypts a string with the given shift amount
function decrypt(inStr, shiftAmt) {
    // Decrypt is negative encrypt
    return encrypt(inStr, -shiftAmt);
}

// Function that recursively solves a caesar cipher
function solveHelper(inStr, shift) {
    // Print out the encrypt result and the shift amount
    console.log(`Caesar ${shift}: ${encrypt(inStr, shift)}`);
    // Only continue if the shift > 0
    if (shift > 0) {
        solveHelper(inStr, shift - 1);
    }
}

// Function that solves a caesar cipher
function solve(inStr, maxShift) {
    // Take the absolute value for the max shift
    maxShift = Math.abs(maxShift);
    if (maxShift > 26) {
        // Take mod if greater than 26 so we work with 0 - 26 inclusive
        maxShift = maxShift % 26;
    }
    // Start the helper function at the shift amount
    solveHelper(inStr, maxShift);
}

// Basic tests
console.log("Alan tests:");
let encryptOut = encrypt("This is a test string from Alan", 8);
console.log(encryptOut);
let decryptOut = decrypt(encryptOut, 8);
console.log(decryptOut);
solve("HAL", 26);

console.log("\nEncrypt and decrypt tests:");
// Negative shift
encryptOut = encrypt("This is a test string from Alan", -1);
console.log(encryptOut);
decryptOut = decrypt(encryptOut, -1);
console.log(decryptOut);
// Mod shift
encryptOut = encrypt("This is a test string from Alan", 27);
console.log(encryptOut);
decryptOut = decrypt(encryptOut, 27);
console.log(decryptOut);
// Empty string
encryptOut = encrypt("", 7);
console.log(encryptOut);
decryptOut = decrypt(encryptOut, 7);
console.log(decryptOut);
// No letters
encryptOut = encrypt("1234567890!@#$%^&*(){}", 7);
console.log(encryptOut);
decryptOut = decrypt(encryptOut, 7);
console.log(decryptOut);

console.log("\nSolve tests:");
// Negative max shift
solve("HAL", -26);
console.log();
// Mod shift
solve("HAL", 30);
