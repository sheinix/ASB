//
//  Transaction.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation

// Defines the concerete data type of a transaction
struct Transaction: TransactionData {
    var id: Int
    var transactionDate: Date
    var summary: String
    var debitValue: Double
    var creditValue: Double
}

// Coding keys for Decodable Protocol
enum CodingKeys: String, CodingKey {
    case id
    case transactionDate
    case summary
    case debit
    case credit
}

// Make TransactionData Decodable to mapp the Network Response
extension Transaction: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        summary = try values.decode(String.self, forKey: .summary)
        debitValue = try values.decode(Double.self, forKey: .debit)
        creditValue = try values.decode(Double.self, forKey: .credit)
        
        // Custom handling for String/Date Conversion:
        let stringDate = try values.decode(String.self, forKey: .transactionDate)
        // Decode/map to Date:
        transactionDate = Transaction.decodeDateFrom(stringDate)
    }
    
    /// Maps a String to a Date using a custom iso8601Full fomatter
    /// - Parameter stringDate: The date in String format
    /// - NOTE: This method might return current Date if its unable to perform proper conversion of string to date format
    /// - Returns: The Date corresponding to the String, or the current Date if cannot decode it
    static func decodeDateFrom(_ stringDate: String) -> Date {
        return DateFormatter.iso8601Full.date(from: stringDate) ?? Date()
    }
}
