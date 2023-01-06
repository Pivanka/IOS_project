//
//  CurrencyRateTableViewCell.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 04.01.2023.
//

import UIKit

class CurrencyRateTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    @IBOutlet weak var rateBuyLabel: UILabel!
    
    @IBOutlet weak var rateSellLabel: UILabel!
    
    @IBOutlet weak var currencyIconLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCellWith(model: CurrencyRateResponseResultModel)
    {
        if  let targetCurrencyCode = CurrencyCodes.codes[Int(model.currencyCodeA!)]{
            currencyNameLabel.text = targetCurrencyCode.code
            currencyIconLabel.text = targetCurrencyCode.icon
        }
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 1
        formatter.numberStyle = .currencyISOCode
        formatter.currencyCode = CurrencyCodes.codes[Int(model.currencyCodeB!)]?.code
        rateBuyLabel.text = formatter.string(for: model.rateBuy)
        rateSellLabel.text = formatter.string(for: model.rateSell)
    }
    
}
