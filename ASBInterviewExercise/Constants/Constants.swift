//
//  Constants.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation

// TypeAlias:
typealias NetworkCompletionHandler = (Result<[TransactionData], Error>) -> Void

/// Defines all the Constants for this project divided by domain
struct Constants {
    
    struct Network {
        static let customRequestTimeOut: TimeInterval = 45.0
        static let transactionEndpoint: String = "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json"
    }
    
    struct ReuseIds {
        static let transactionTableViewCellId: String = "transactionTableViewCellId"
    }
    
    struct Titles {
        static let TranasactionList: String = "💸 ASB Transactions"
    }
}
