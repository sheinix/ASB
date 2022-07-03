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
        // Do any additional setup after loading the view.
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

