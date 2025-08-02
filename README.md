# 💳 Credit Card Generator

A Swift-based credit card number generator that creates mathematically valid credit card numbers using the Luhn algorithm. This project demonstrates algorithm implementation, data validation, and clean code practices.

## ✨ What It Does

This tool generates valid credit card numbers for major card types including Visa, MasterCard, American Express, and Discover. All generated numbers pass the industry-standard Luhn algorithm validation but are completely random and not tied to any real accounts.

## 🧠 How It Works

### The Luhn Algorithm
The heart of this project is the Luhn algorithm (also known as the "modulus 10" algorithm), which is used by credit card companies to validate card numbers:

1. **Starting from the right**, double every second digit
2. If doubling results in a two-digit number, add those digits together
3. Sum all the digits
4. If the total is divisible by 10, the number is valid

### Generation Process
1. **Define card type rules** - Each card type has specific prefixes and lengths
2. **Generate random digits** for the middle portion
3. **Calculate check digit** using the Luhn algorithm to ensure validity
4. **Format the result** with proper spacing for readability

## 🚀 Usage

```swift
let generator = CreditCardGenerator()

// Generate a Visa card
let visaCard = generator.generateCard(type: .visa)
print("Visa: \(visaCard.formatted)")
// Output: 4532 1234 5678 9012

// Validate any credit card number
let isValid = generator.isValidLuhn("4532123456789012")
print("Valid: \(isValid)")
// Output: Valid: true
```

### Supported Card Types
- 🔵 **Visa** - 16 digits, starts with 4
- 🔴 **MasterCard** - 16 digits, starts with 5
- 🟢 **American Express** - 15 digits, starts with 34/37
- 🟠 **Discover** - 16 digits, starts with 6

## 🛠 Technical Details

- **Language**: Swift 5.0+
- **Platform**: macOS (Command Line Tool)
- **Dependencies**: Foundation only
- **Algorithm**: Luhn checksum validation
- **Architecture**: Struct-based with enum for card types

## 🎓 What I Learned

Building this project taught me:

- **Algorithm Implementation**: Converting mathematical concepts into working code
- **Data Validation**: Understanding how financial systems verify card numbers
- **Swift Best Practices**: Using enums, structs, and extensions effectively
- **Error Handling**: Debugging validation logic with real test cases
- **Code Organization**: Separating concerns between validation, generation, and formatting

## 📋 Example Output

```
Generated Visa: 4558 2140 0038 9762
Valid: true

Generated MasterCard: 5235 4147 1161 1292
Valid: true

Generated Amex: 3448 757196 82072
Valid: true

Generated Discover: 6005 6725 0828 7339
Valid: true
```

## ⚠️ Important Disclaimer

**This project is for educational purposes only.** The generated credit card numbers are mathematically valid but completely random. They are not associated with any real bank accounts, cannot be used for actual transactions, and should never be used for fraudulent activities.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Built with Swift to demonstrate algorithm implementation and financial data validation concepts.*
