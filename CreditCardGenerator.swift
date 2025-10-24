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
            case .mastercard:
                // MasterCard: 51-55 or 2221-2720
                let useNewRange = Bool.random()
                if useNewRange {
                    // New range: 2221-2720
                    return String(Int.random(in: 2221...2720))
                } else {
                    // Old range: 51-55
                    return "5\(Int.random(in: 1...5))"
                }
            case .amex:
                // American Express: 34 or 37
                return Bool.random() ? "34" : "37"
            case .discover:
                // Discover: 6011, 622126-622925, 644-649, or 65
                let option = Int.random(in: 0...3)
                switch option {
                case 0: return "6011"
                case 1: return String(Int.random(in: 622126...622925))
                case 2: return "64\(Int.random(in: 4...9))"
                case 3: return "65"
                default: return "6011"
                }
            case .jcb:
                // JCB: 3528-3589
                return String(Int.random(in: 3528...3589))
            case .dinersClub:
                // Diners Club: 36, 38, or 300-305
                let option = Int.random(in: 0...2)
                switch option {
                case 0: return "36"
                case 1: return "38"
                case 2: return String(Int.random(in: 300...305))
                default: return "36"
                }
            case .unionPay:
                // UnionPay: 62 or 81
                return Bool.random() ? "62" : "81"
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
            // Diners Club format varies by prefix
            // 300-305: 3-6-5 format (e.g., "300 123456 78901")
            // 36, 38: 4-6-4 format (e.g., "3612 345678 1234")
            if number.hasPrefix("30") {
                // 300-305 prefix: 3-6-5 format
                let part1 = String(number.prefix(3))
                let part2 = String(number.dropFirst(3).prefix(6))
                let part3 = String(number.dropFirst(9))
                return "\(part1) \(part2) \(part3)"
            } else {
                // 36, 38 prefix: 4-6-4 format
                let part1 = String(number.prefix(4))
                let part2 = String(number.dropFirst(4).prefix(6))
                let part3 = String(number.dropFirst(10))
                return "\(part1) \(part2) \(part3)"
            }
        default:
            // Standard format: 4532 1234 5678 9012
            return number.chunked(into: 4).joined(separator: " ")
        }
    }
    
    // Generate a valid credit card number function
    func generateCard(type: CardType) -> (number: String, formatted: String, cvc: String, expirationDate: String) {
        let totalLength = type.length
        
        // Start with the prefix (get it once to avoid inconsistent lengths)
        var cardNumber = type.prefix
        let prefixLength = cardNumber.count
        let digitsToGenerate = totalLength - prefixLength - 1  // -1 for check digit
        
        // Validate that we have a positive number of digits to generate
        guard digitsToGenerate >= 0 else {
            fatalError("Invalid card configuration: prefix length (\(prefixLength)) exceeds total length (\(totalLength))")
        }
        
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
        let expiryYear = (currentYear + randomYearOffset) % 100 // Handle overflow past 99

        let randomMonth = Int.random(in: 1...12)

        return String(format: "%02d/%02d", randomMonth, expiryYear)
    }

    private func generateCards(for type: CardType) {
        print("How many \(type.name) cards would you like to generate? ", terminator: "")
        if let countString = readLine(), let count = Int(countString), count > 0 {
            // Add upper limit to prevent excessive generation
            guard count <= 10000 else {
                print("\nError: Cannot generate more than 10,000 cards at once. Please enter a smaller number.")
                return
            }
            
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

    private func generateMixedCardsToFile() {
        print("How many mixed cards would you like to generate? ", terminator: "")
        if let countString = readLine(), let count = Int(countString), count > 0 {
            // Add upper limit to prevent excessive generation
            guard count <= 10000 else {
                print("\nError: Cannot generate more than 10,000 cards at once. Please enter a smaller number.")
                return
            }
            
            print("Enter filename (without extension): ", terminator: "")
            guard let filename = readLine(), !filename.isEmpty else {
                print("\nInvalid filename. Operation cancelled.")
                return
            }
            
            let sanitizedFilename = filename.trimmingCharacters(in: .whitespacesAndNewlines)
            let filePath = "\(sanitizedFilename).txt"
            
            print("\nGenerating \(count) mixed credit cards and saving to \(filePath)...")
            
            var fileContent = "💳 Mixed Credit Card Generator Output\n"
            fileContent += "Generated on: \(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))\n"
            fileContent += "Total cards: \(count)\n"
            fileContent += String(repeating: "=", count: 50) + "\n\n"
            
            let cardTypes = CardType.allCases
            var cardCounts: [String: Int] = [:]
            
            for i in 1...count {
                let randomCardType = cardTypes.randomElement()!
                let card = generateCard(type: randomCardType)
                
                // Count card types
                cardCounts[randomCardType.name, default: 0] += 1
                
                // Add card details to file content
                fileContent += "Card #\(i) - \(randomCardType.name)\n"
                fileContent += "-----------------------------------------\n"
                fileContent += "Card: \(card.formatted)\n"
                fileContent += "CVC: \(card.cvc)\n"
                fileContent += "Expires: \(card.expirationDate)\n"
                fileContent += "Valid: \(isValidLuhn(card.number))\n"
                fileContent += "-----------------------------------------\n\n"
            }
            
            // Add summary at the end
            fileContent += String(repeating: "=", count: 50) + "\n"
            fileContent += "SUMMARY\n"
            fileContent += String(repeating: "=", count: 50) + "\n"
            for (cardType, count) in cardCounts.sorted(by: { $0.key < $1.key }) {
                fileContent += "\(cardType): \(count) cards\n"
            }
            
            // Write to file
            do {
                try fileContent.write(toFile: filePath, atomically: true, encoding: .utf8)
                print("✅ Successfully generated \(count) cards and saved to '\(filePath)'")
                
                // Display summary to console
                print("\n📊 Summary:")
                for (cardType, count) in cardCounts.sorted(by: { $0.key < $1.key }) {
                    print("   \(cardType): \(count) cards")
                }
                print()
            } catch {
                print("❌ Error writing to file: \(error.localizedDescription)")
                print("Cards were generated but could not be saved to file.")
            }
        } else {
            print("\nInvalid number. Please enter a positive integer.")
        }
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
            print("\(cardTypes.count + 1). Generate Mixed Cards to File")
            print("\(cardTypes.count + 2). Exit")

            print("\nEnter your choice (1-\(cardTypes.count + 2)): ", terminator: "")

            if let choiceString = readLine(), let choice = Int(choiceString) {
                switch choice {
                case 1...cardTypes.count:
                    let selectedCardType = cardTypes[choice - 1]
                    generateCards(for: selectedCardType)
                case cardTypes.count + 1:
                    generateMixedCardsToFile()
                case cardTypes.count + 2:
                    shouldContinue = false
                    print("Goodbye!\n")
                default:
                    print("\nInvalid choice. Please enter a number between 1 and \(cardTypes.count + 2).")
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
        guard size > 0 else { return [self] }
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
