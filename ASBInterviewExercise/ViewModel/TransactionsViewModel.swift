//
//  TransactionsViewModel.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

class TransactionsViewModel {
    
    private let networkManager: NetworkManageable
    var transactionsList: [TransactionData] = []
    
    init(networkMngr: NetworkManageable) {
        self.networkManager = networkMngr
    }
    
    public func fetchTransactionData(onCompletion: @escaping (_ udpatedTransactions: [TransactionData]) -> ()) {
        self.networkManager.fetchTransactionData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let transactions):
                self.transactionsList = transactions.sorted(by: { tx1, tx2 in
                    return tx1.transactionDate > tx2.transactionDate
                })
                onCompletion(self.transactionsList)
            case .failure(let error):
                debugPrint("Error: \(error)")
                onCompletion([])
            }
        }
    }}
