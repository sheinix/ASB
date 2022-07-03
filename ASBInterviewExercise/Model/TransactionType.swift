//
//  TransactionType.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation
import UIKit

// Defines the type of Transaction:
enum TransactionType {
    case credit
    case debit
    
    // Transaction Color Coding Extra Requirement:
    var color: UIColor {
        switch self {
        case .credit: return .green
        case .debit: return .red
        }
    }
    
    var name: String {
        return self == .credit ? "Credit" : "Debit"
    }
}
