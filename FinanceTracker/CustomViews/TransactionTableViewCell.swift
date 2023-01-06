//
//  TransactionTableViewCell.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 10.12.2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var transactionName: UILabel!
    @IBOutlet weak var transactionCategory: UILabel!
    @IBOutlet weak var transactionAmount: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
