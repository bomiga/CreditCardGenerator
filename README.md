# 💳 Credit Card Generator

A Swift-based credit card number generator that creates mathematically valid credit card numbers using the Luhn algorithm. This project demonstrates algorithm implementation, data validation, and clean code practices.

## ✨ What It Does

This tool provides a simple way to generate valid, fake credit card numbers for testing and educational purposes. It features:
- **Interactive Mode:** A user-friendly command-line interface that guides you through the generation process.
- **Multiple Card Types:** Support for major credit card networks like Visa, MasterCard, Amex, and more.
- **Complete Card Data:** Generates not just the card number, but also a random CVC and a future expiration date.
- **Luhn Algorithm Validation:** All generated numbers are mathematically valid according to the Luhn algorithm.

## 🚀 Usage

This tool now runs in a user-friendly interactive mode by default. To start, simply run the script from your terminal:

```bash
swift CreditCardGenerator.swift
```

The script will then guide you through the process:

1.  **Welcome Message:** You will be greeted with a welcome message.
2.  **Select Card Type:** A menu of all supported card types will be displayed. Enter the number corresponding to your choice.
3.  **Enter Quantity:** You will be prompted to enter the number of cards you wish to generate.
4.  **View Results:** The details of the generated cards will be printed to the console.
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
- 🔴 **MasterCard** - 16 digits, starts with 5
- 🟢 **American Express** - 15 digits, starts with 34/37
- 🟠 **Discover** - 16 digits, starts with 6
- 🟣 **JCB** - 16 digits, starts with 35
- ⚫ **Diners Club** - 14 digits, starts with 36
- ⚪ **UnionPay** - 16 digits, starts with 62

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
-----------------------------------------
Generated Visa: 4558 2140 0038 9762
CVC: 123
Expires: 08/28
Valid: true
-----------------------------------------
Generated Mastercard: 5235 4147 1161 1292
CVC: 456
Expires: 11/29
Valid: true
-----------------------------------------
Generated Amex: 3448 757196 82072
CVC: 7890
Expires: 03/27
Valid: true
-----------------------------------------
Generated Discover: 6011 6725 0828 7339
CVC: 135
Expires: 05/30
Valid: true
-----------------------------------------
Generated JCB: 3528 1234 5678 9012
CVC: 246
Expires: 09/28
Valid: true
-----------------------------------------
Generated Diners Club: 3612 345678 1234
CVC: 357
Expires: 01/29
Valid: true
-----------------------------------------
Generated UnionPay: 6221 2612 3456 7890
CVC: 468
Expires: 06/30
Valid: true
-----------------------------------------
```

## ⚠️ Important Disclaimer

**This project is for educational purposes only.** The generated credit card numbers are mathematically valid but completely random. They are not associated with any real bank accounts, cannot be used for actual transactions, and should never be used for fraudulent activities.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Built with Swift to demonstrate algorithm implementation and financial data validation concepts.*
