# 💳 Credit Card Generator

A Swift-based credit card number generator that creates mathematically valid credit card numbers using the Luhn algorithm. This project demonstrates algorithm implementation, data validation, and clean code practices.

## ✨ What It Does

This tool provides a simple way to generate valid, fake credit card numbers for testing and educational purposes. It features:
- **Interactive Mode:** A user-friendly command-line interface that guides you through the generation process.
- **Multiple Card Types:** Support for major credit card networks with industry-standard IIN (Issuer Identification Number) ranges.
- **Complete Card Data:** Generates not just the card number, but also a random CVC and a future expiration date.
- **Luhn Algorithm Validation:** All generated numbers are mathematically valid according to the Luhn algorithm.
- **Smart Formatting:** Dynamic card number formatting based on card type (including special Diners Club formatting).
- **Generation Limits:** Built-in 10,000 card generation limit to prevent system overload.
- **Robust Validation:** Input validation and error handling for safe operation.

## 🚀 Usage

This tool now runs in a user-friendly interactive mode by default. To start, simply run the script from your terminal:

```bash
swift CreditCardGenerator.swift
```

The script will then guide you through the process:

1.  **Welcome Message:** You will be greeted with a welcome message.
2.  **Select Card Type:** A menu of all supported card types will be displayed. Enter the number corresponding to your choice.
3.  **Enter Quantity:** You will be prompted to enter the number of cards you wish to generate (up to 10,000).
4.  **View Results:** The details of the generated cards will be printed to the console with proper formatting.
5.  **Continue or Exit:** You can then choose to generate more cards or exit the program.

### Example Session

```
💳 Welcome to the Credit Card Generator!

Please select a card type to generate:
1. Visa
2. MasterCard
3. American Express
4. Discover
5. JCB
6. Diners Club
7. UnionPay
8. Exit

Enter your choice (1-8): 1
How many Visa cards would you like to generate? 2

Generating 2 Visa card(s)...
-----------------------------------------
Card: 4558 2140 0038 9762
CVC: 123
Expires: 08/28
Valid: true
-----------------------------------------
Card: 4123 4567 8901 2345
CVC: 456
Expires: 11/29
Valid: true
-----------------------------------------
```

### Supported Card Types
- 🔵 **Visa** - 16 digits, starts with 4
- 🔴 **MasterCard** - 16 digits, starts with 51-55 or 2221-2720
- 🟢 **American Express** - 15 digits, starts with 34 or 37
- 🟠 **Discover** - 16 digits, starts with 6011, 622126-622925, 644-649, or 65
- 🟣 **JCB** - 16 digits, starts with 3528-3589
- ⚫ **Diners Club** - 14 digits, starts with 36, 38, or 300-305
- ⚪ **UnionPay** - 16 digits, starts with 62 or 81

## 🛠 Technical Details

- **Language**: Swift 5.0+
- **Platform**: macOS (Command Line Tool)
- **Dependencies**: Foundation only
- **Algorithm**: Luhn checksum validation with proper check digit calculation
- **Architecture**: Class-based with enum for card types
- **IIN Compliance**: Uses industry-standard Issuer Identification Number ranges
- **Formatting**: Dynamic formatting based on card type (American Express: 4-6-5, Diners Club: 3-6-5 or 4-6-4, others: 4-4-4-4)
- **Safety Features**: Input validation, generation limits, and error handling

## 🎓 What I Learned

Building this project taught me:

- **Algorithm Implementation**: Converting mathematical concepts into working code
- **Data Validation**: Understanding how financial systems verify card numbers
- **Swift Best Practices**: Using enums, classes, and extensions effectively
- **Error Handling**: Implementing robust input validation and edge case handling
- **Code Organization**: Separating concerns between validation, generation, and formatting
- **Industry Standards**: Working with real-world IIN ranges and card formatting rules
- **Performance Considerations**: Implementing safeguards against excessive resource usage

## 📋 Example Output

```
-----------------------------------------
Card: 4558 2140 0038 9762
CVC: 123
Expires: 08/28
Valid: true
-----------------------------------------
Card: 5235 4147 1161 1292
CVC: 456
Expires: 11/29
Valid: true
-----------------------------------------
Card: 3782 822463 10005
CVC: 7890
Expires: 03/27
Valid: true
-----------------------------------------
Card: 6011 6725 0828 7339
CVC: 135
Expires: 05/30
Valid: true
-----------------------------------------
Card: 3528 123456 78901
CVC: 246
Expires: 09/28
Valid: true
-----------------------------------------
Card: 300 123456 78901
CVC: 357
Expires: 01/29
Valid: true
-----------------------------------------
Card: 6221 2612 3456 7890
CVC: 468
Expires: 06/30
Valid: true
-----------------------------------------
```

### Key Features Demonstrated:
- **Accurate IIN Ranges**: All card prefixes use industry-standard ranges
- **Proper Formatting**: Each card type follows its specific formatting rules
- **Luhn Validation**: Every generated card passes mathematical validation
- **Complete Data**: Includes card number, CVC, and realistic expiration dates
- **Error Prevention**: Built-in limits and validation prevent misuse

## ⚠️ Important Disclaimer

**This project is for educational purposes only.** The generated credit card numbers are mathematically valid but completely random. They are not associated with any real bank accounts, cannot be used for actual transactions, and should never be used for fraudulent activities.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Built with Swift to demonstrate algorithm implementation and financial data validation concepts.*
