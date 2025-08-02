//
//  CreditCardGenerator.swift
//  CreditCardGenerator
//
//  Created by bomiga on 02/08/2025.
//

import Foundation

struct CreditCardGenerator {
    // Define different credit card types and their rules
    enum CardType {
        case visa
        case mastercard
        case amex
        case discover
        
        var prefix: String {
            switch self {
            case .visa:
                return "4"
            case .mastercard:
                return "5"
            case .amex:
                return "34"  // or "37"
            case .discover:
                return "6"
            }
        }
        
        var length: Int {
            switch self {
            case .visa:
                return 16
            case .mastercard:
                return 16
            case .amex:
                return 15
            case .discover:
                return 16
            }
        }
        
        var name: String {
            switch self {
            case .visa: return "Visa"
            case .mastercard: return "MasterCard"
            case .amex: return "American Express"
            case .discover: return "Discover"
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
        default:
            // Standard format: 4532 1234 5678 9012
            return number.chunked(into: 4).joined(separator: " ")
        }
    }
    
    // Generate a valid credit card number function
    func generateCard(type: CardType) -> (number: String, formatted: String) {
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
        return (cardNumber, formatted)
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

let generator = CreditCardGenerator()

// Generate cards of different types
let visaCard = generator.generateCard(type: .visa)
print("-----------------------------------------")
print("Generated Visa: \(visaCard.formatted)")
print("Raw: \(visaCard.number)")
print("Valid: \(generator.isValidLuhn(visaCard.number))")
print("-----------------------------------------")

let mastercardCard = generator.generateCard(type: .mastercard)
print("Generated Mastercard: \(mastercardCard.formatted)")
print("Raw: \(mastercardCard.number)")
print("Valid: \(generator.isValidLuhn(mastercardCard.number))")
print("-----------------------------------------")

let amexCard = generator.generateCard(type: .amex)
print("Generated Amex: \(amexCard.formatted)")
print("Raw: \(amexCard.number)")
print("Valid: \(generator.isValidLuhn(amexCard.number))")
print("-----------------------------------------")

let discoverCard = generator.generateCard(type: .discover)
print("Generated Discover: \(amexCard.formatted)")
print("Raw: \(discoverCard.number)")
print("Valid: \(generator.isValidLuhn(discoverCard.number))")
print("-----------------------------------------")
