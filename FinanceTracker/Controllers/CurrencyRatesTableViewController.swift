//
//  CurrencyRatesTableViewController.swift
//  FinanceTracker
//
//  Created by Богдан Конопольський on 04.01.2023.
//

import UIKit

class CurrencyRatesTableViewController: UITableViewController {
    
    private var currencyRates: [CurrencyRateResponseResultModel] = []
    private var activityIndicatorView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchRates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyRateCell", for: indexPath) as! CurrencyRateTableViewCell
        
        cell.configureCellWith(model: currencyRates[indexPath.row])
        
        return cell
    }
}

private extension CurrencyRatesTableViewController
{
    func setupUI()
    {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicatorView = activityIndicator
        activityIndicator.color = .systemBlue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = tableView.center
        tableView.addSubview(activityIndicator)
    }
    
    func fetchRates(){
        activityIndicatorView?.startAnimating()
        
        NetworkManager.fetchCurrencyRates(from: "https://api.monobank.ua/bank/currency") {
            result in DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(success):
                    guard let self = self
                    else {
                        self?.activityIndicatorView?.stopAnimating()
                        return  }
                    
                    self.currencyRates = Array(success.prefix(3))
                    self.activityIndicatorView?.stopAnimating()
                    self.tableView.reloadData()
                    
                case .failure(_):
                    self?.activityIndicatorView?.stopAnimating()
                    print("Fetching error")
                    
                }
            }
        }
    }
}
