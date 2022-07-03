//
//  TransactionDetailViewController.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import UIKit
import SnapKit

class TransactionDetailViewController: UIViewController {

    var viewModel: TransactionViewModel
    var tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    
    init(viewModel: TransactionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
    }
    
    private func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ReuseIds.detailTableViewCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.navigationItem.title = Constants.Titles.TransactionTitle
    }
}

// - MARK:  UITableViewDataSource
extension TransactionDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let section = DetailViewLayout(rawValue: indexPath.section) else {
            return UITableViewCell(style: .default, reuseIdentifier: Constants.ReuseIds.detailTableViewCellId)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIds.detailTableViewCellId, for: indexPath)
        cell.textLabel?.text = section.cellValueFrom(viewModel.transaction)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailViewLayout.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = DetailViewLayout(rawValue: section) else { return nil }
        return section.sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = DetailViewLayout(rawValue: section) else { return 0 }
        return section.rowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = DetailViewLayout(rawValue: indexPath.section) else { return 0 }
        return section.rowHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = DetailViewLayout(rawValue: indexPath.section) else { return 0 }
        return section.rowHeight
    }
}
    

// - MARK:  UITableViewDelegate
extension TransactionDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
