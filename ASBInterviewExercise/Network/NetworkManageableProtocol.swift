//
//  NetworkManageableProtocol.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation

// Defines the Networking Methods classes must implement to fetch network data
protocol NetworkManageable {
    
    /// Fetches all the transaction data and returns
    /// - Parameter completionHandler: The completionBlock to handle the request response
    func fetchTransactionData(completionHandler: @escaping NetworkCompletionHandler)
}
