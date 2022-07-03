//
//  TransactionDataTableViewCell.swift
//  ASBInterviewExercise
//
//  Created by Juan Nuvreni on 4/07/22.
//

import UIKit

class TransactionDataTableViewCell: UITableViewCell {
    
    static let nibClass: String = "TransactionDataTableViewCell"
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
