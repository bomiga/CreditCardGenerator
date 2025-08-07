//
//  CreditCardGenerator.swift
//  CreditCardGenerator
//
//  Created by bomiga on 02/08/2025.
//

import Foundation

class CreditCardGenerator {
    // Define different credit card types and their rules
    enum CardType: CaseIterable {
        case visa
        case mastercard
        case amex
        case discover
        case jcb
        case dinersClub
        case unionPay

        var prefix: String {
            switch self {
            case .visa: return "4"
            case .mastercard: return "5"
            case .amex: return "34" // or "37"
            case .discover: return "6"
            case .jcb: return "35"
            case .dinersClub: return "36"
            case .unionPay: return "62"
            }
        }

        var length: Int {
            switch self {
            case .amex:
                return 15
            case .dinersClub:
                return 14
            default:
                return 16
            }
        }

        var cvcLength: Int {
            switch self {
            case .amex:
                return 4
            default:
                return 3
            }
        }

        var name: String {
            switch self {
            case .visa: return "Visa"
            case .mastercard: return "MasterCard"
            case .amex: return "American Express"
            case .discover: return "Discover"
            case .jcb: return "JCB"
            case .dinersClub: return "Diners Club"
            case .unionPay: return "UnionPay"
            }
        }
    }
    
    // Function to validate if a credit card number passes Luhn algorithm
    func isValidLuhn(_ number: String) -> Bool {
        // Step 1: Remove any spaces and convert to array of digits
        let digits = number.replacingOccurrences(of: " ", with: "")
            .compactMap { $0.wholeNumberValue}
        
        //print("Digits: \(digits)")  // Debug line
        
        // Step 2: Start from the right, double every second digit
        var sum = 0
        for (index, digit) in digits.reversed().enumerated() {
            var workingDigit = digit
            
            // If it's an even index (every second digit from right)
            if index % 2 == 1 {
                workingDigit *= 2
                // If result is > 9, add the digits together
                if workingDigit > 9 {
                    workingDigit = workingDigit / 10 + workingDigit % 10
                }
            }
            sum += workingDigit
            //print("Index: \(index), Original: \(digit), Working: \(workingDigit), Sum so far: \(sum)")  // Debug line
        }
        
        // Step 3: Check if sum is divisible by 10
        //print("Final sum: \(sum)")  // Debug line
        return sum % 10 == 0
    }
    
    // Calculate what the check digit should be for a partial number
    func calculateCheckDigit(_ partialNumber: String) -> Int {
        let digits = partialNumber.replacingOccurrences(of: " ", with: "")
            .compactMap { $0.wholeNumberValue }
        
        var sum = 0
        // Start from rightmost position (where check digit will go)
        for (index, digit) in digits.reversed().enumerated() {
            var workingDigit = digit
            
            // Since we're adding a check digit, this shifts everything
            // Now we double digits at even indices (0, 2, 4...)
            if index % 2 == 0 {  // Note: this is different from validation
                workingDigit *= 2
                if workingDigit > 9 {
                    workingDigit = workingDigit / 10 + workingDigit % 10
                }
            }
            sum += workingDigit
        }
        
        // Check digit makes total divisible by 10
        return (10 - (sum % 10)) % 10
    }
    
    // Formatting function
    func formatCardNumber(_ number: String, type: CardType) -> String {
        switch type {
        case .amex:
            // Amex format: 3782 822463 10005
            let part1 = String(number.prefix(4))
            let part2 = String(number.dropFirst(4).prefix(6))
            let part3 = String(number.dropFirst(10))
            return "\(part1) \(part2) \(part3)"
        case .dinersClub:
            // Diners Club format: 3612 345678 1234
            let part1 = String(number.prefix(4))
            let part2 = String(number.dropFirst(4).prefix(6))
            let part3 = String(number.dropFirst(10))
            return "\(part1) \(part2) \(part3)"
        default:
            // Standard format: 4532 1234 5678 9012
            return number.chunked(into: 4).joined(separator: " ")
        }
    }
    
    // Generate a valid credit card number function
    func generateCard(type: CardType) -> (number: String, formatted: String, cvc: String, expirationDate: String) {
        let totalLength = type.length
        let prefixLength = type.prefix.count
        let digitsToGenerate = totalLength - prefixLength - 1  // -1 for check digit
        
        // Start with the prefix
        var cardNumber = type.prefix
        
        // Generate random digits for the middle part
        for _ in 0..<digitsToGenerate {
            cardNumber += String(Int.random(in: 0...9))
        }
        
        // Calculate and append the check digit
        let checkDigit = calculateCheckDigit(cardNumber)
        cardNumber += String(checkDigit)
        
        let formatted = formatCardNumber(cardNumber, type: type)
        let cvc = generateCVC(for: type)
        let expirationDate = generateExpirationDate()

        return (cardNumber, formatted, cvc, expirationDate)
    }

    // Private helper to generate CVC
    private func generateCVC(for type: CardType) -> String {
        let cvcLength = type.cvcLength
        var cvc = ""
        for _ in 0..<cvcLength {
            cvc += String(Int.random(in: 0...9))
        }
        return cvc
    }

    // Private helper to generate a future expiration date
    private func generateExpirationDate() -> String {
        let currentYear = Calendar.current.component(.year, from: Date()) % 100 // Get last two digits of year
        let randomYearOffset = Int.random(in: 2...5) // Expires in 2 to 5 years
        let expiryYear = currentYear + randomYearOffset

        let randomMonth = Int.random(in: 1...12)

        return String(format: "%02d/%02d", randomMonth, expiryYear)
    }

    private func generateCards(for type: CardType) {
        print("How many \(type.name) cards would you like to generate? ", terminator: "")
        if let countString = readLine(), let count = Int(countString), count > 0 {
            print("\nGenerating \(count) \(type.name) card(s)...")
            for _ in 0..<count {
                let card = generateCard(type: type)
                printCardDetails(card)
            }
        } else {
            print("\nInvalid number. Please enter a positive integer.")
        }
    }

    private func printCardDetails(_ card: (number: String, formatted: String, cvc: String, expirationDate: String)) {
        print("-----------------------------------------")
        print("Card: \(card.formatted)")
        print("CVC: \(card.cvc)")
        print("Expires: \(card.expirationDate)")
        print("Valid: \(isValidLuhn(card.number))")
        print("-----------------------------------------")
    }

    func run() {
        print("💳 Welcome to the Credit Card Generator!")

        var shouldContinue = true
        while shouldContinue {
            print("\nPlease select a card type to generate:")

            let cardTypes = CardType.allCases
            for (index, cardType) in cardTypes.enumerated() {
                print("\(index + 1). \(cardType.name)")
            }
            print("\(cardTypes.count + 1). Exit")

            print("\nEnter your choice (1-\(cardTypes.count + 1)): ", terminator: "")

            if let choiceString = readLine(), let choice = Int(choiceString) {
                switch choice {
                case 1...cardTypes.count:
                    let selectedCardType = cardTypes[choice - 1]
                    generateCards(for: selectedCardType)
                case cardTypes.count + 1:
                    shouldContinue = false
                    print("Goodbye!\n")
                default:
                    print("\nInvalid choice. Please enter a number between 1 and \(cardTypes.count + 1).")
                }
            } else {
                print("\nInvalid input. Please enter a number.")
            }
        }
    }
    
}

// Helper extension for chunking strings
extension String {
    func chunked(into size: Int) -> [String] {
        return stride(from: 0, to: count, by: size).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: min(size, count - $0))
            return String(self[start..<end])
        }
    }
}

func main() {
    let app = CreditCardGenerator()
    app.run()
}

main()
