//
//  NetworkManager.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import Foundation

struct NetworkManager: NetworkManageable {
    
    /// Fetches transaction data
    /// - Parameter completionHandler: The completion handler for this network request wrapped on a Result
    func fetchTransactionData(completionHandler: @escaping NetworkCompletionHandler) {
        
        // Get the RestClient
        guard let restClient = DIManager.shared.assembler.resolver.resolve(RestClient.self) else {
            completionHandler(.failure(Errors.DI_ResolverError.error))
            return
        }
        
        // Prepare the URL Request for Fetching data
        guard let dataUrl = URL(string: Constants.Network.transactionEndpoint) else {
            completionHandler(.failure(Errors.NetworkRequestError.error))
            return
        }
        
        let urlRequest = URLRequest(url: dataUrl,
                                    cachePolicy: .reloadRevalidatingCacheData,
                                    timeoutInterval: Constants.Network.customRequestTimeOut)
        
        // Do the Request:
        restClient.apiRequest(urlRequest) { dataResponse, urlResponse, error in
            
            // Check for errors
            guard error == nil else {
                completionHandler(.failure(Errors.NetworkRequestError.error))
                return
            }
            
            guard let data = dataResponse else {
                completionHandler(.failure(Errors.NetworkRequestError.error))
                return
            }
            
            // Parse information:
            do {
                let transactionsList = try JSONDecoder().decode([Transaction].self, from: data)
                
                // Return succesfully transaction list
                completionHandler(.success(transactionsList))
                
            } catch let networkError {
                debugPrint("Error:\(networkError)")
                completionHandler(.failure(Errors.NetworkRequestError.error))
            }
        }
    }
}
