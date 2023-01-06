//
//  AccountTableViewCell.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 18.12.2022.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var spendingsLabel: UILabel!
    @IBOutlet weak var incomesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
