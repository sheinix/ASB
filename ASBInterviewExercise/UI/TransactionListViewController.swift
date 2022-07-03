//
//  ViewController.swift
//  ASBInterviewExercise
//
//  Created by ASB on 29/07/21.
//

import UIKit

class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = TransactionsViewModel(networkMngr: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        loadTransactionData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = Constants.Titles.TranasactionList
    }
    
    // Table Configuration:
    private func setupTableView() {
        self.tableView.register(UINib(nibName: TransactionDataTableViewCell.nibClass, bundle: nil),
                                forCellReuseIdentifier: Constants.ReuseIds.transactionTableViewCellId)
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Loadig methods
    private func loadTransactionData() {
        viewModel.fetchTransactionData(onCompletion: { [weak self] transactionList in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

// - MARK:  UITableViewDataSource
extension TransactionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIds.transactionTableViewCellId,
                                                       for: indexPath) as? TransactionDataTableViewCell else {
            return TransactionDataTableViewCell(style: .default, reuseIdentifier: Constants.ReuseIds.transactionTableViewCellId)
        }
        
        // Prepare data:
        let transaction = viewModel.transactionsList[indexPath.row]
        let txType = transaction.transactionType()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let stringDate = dateFormatter.string(from: transaction.transactionDate)

        // set data
        cell.summaryLabel.text = transaction.summary
        cell.transactionDateLabel.textColor = txType.color
        cell.transactionDateLabel.text = "\(txType.name) on \(stringDate)"
        
        return cell
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactionsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(20.0)
    }
}
