//
//  TransactionDataProtocol.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation

/// Defines all the properties and methods for a Transaction
protocol TransactionData {
    var id: Int { get }
    var transactionDate: Date { get }
    var summary: String { get }
    var debitValue: Double { get }
    var creditValue: Double { get }
    
    // Helpers:
    
    /// Defines which transaction type is based on the amount in the `credit` field
    /// - NOTE: This method uses only `credit` field and ignores the `debit` one to determine the type.
    ///  if both fields are different than zero, it will default to a credit
    /// - Returns: A `TransactionType` enum indicating if its a debit or credit
    func transactionType() -> TransactionType
    
    /// Returns the value of the transaction checking against zero each field debitValue and creditValue.
    /// - NOTE: Defaults to credit if debit/credit fields are inconsistent
    func txValue() -> Double
    
    /// Returns the value of the transaction formatted with the displayFormat string passed as parameter
    /// - Parameter displayFormat: The format string to format the Double value (e.g. "%.2f")
    /// - Returns: a `String` representing the value of the transaction formatted
    func txValue(displayFormat: String) -> String
    
    /// Returns the date of the transaction formmated as String with .dateStyle full
    func txDateFormatted() -> String
    
    /// Gets the GST paid on each transaction
    func getGSTTax() -> Double
}

/// Extends the protocol with default implementation for methods
extension TransactionData {
    func transactionType() -> TransactionType {
        return creditValue == 0 ? .debit : .credit
    }
    
    /// Returns the value based on which credit or debit is zero
    func txValue() -> Double {
        return transactionType() == .debit ? debitValue : creditValue
    }
    
    func txValue(displayFormat: String) -> String {
        return String(format: displayFormat, txValue())
    }
    
    func txDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: transactionDate)
    }
    
    func getGSTTax() -> Double {
        return round(txValue() - (txValue()/Constants.Numbers.GSTTaxMultiplier))
    }
}
