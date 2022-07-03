//
//  DetailViewConfiguration.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation
import UIKit

/// This enum handles the layout configuration of the tableView from detailView
enum DetailViewLayout: Int, CaseIterable {
    case priceSection = 0
    case dateSection
    case summarySection
    case transactionTypeSection
    case transactionIdSection
    
    var rowsInSection: Int {
       return 1
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .priceSection: return CGFloat(70.0)
        case .summarySection: return CGFloat(80)
        case .transactionTypeSection, .transactionIdSection, .dateSection: return CGFloat(40.0)
        }
    }
    
    var sectionTitle: String {
        switch self {
        case .summarySection: return "Summary"
        case .transactionTypeSection: return "Type"
        case .transactionIdSection: return "Transaction ID"
        case .priceSection: return ""
        case .dateSection: return "Date"
        }
    }
    
    func cellValueFrom(_ transaction: TransactionData) -> String {
        switch self {
        case .summarySection:
            return transaction.summary
        case .transactionTypeSection:
            return transaction.transactionType().name
        case .transactionIdSection:
            return "\(transaction.id)"
        case .priceSection:
            return "$\(transaction.txValue(displayFormat: "%.2f"))"
        case .dateSection:
            return transaction.txDateFormatted()
        }
    }
}
