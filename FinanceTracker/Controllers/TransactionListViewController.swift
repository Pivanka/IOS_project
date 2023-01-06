
import UIKit

class TransactionListViewController: UITableViewController, TransactionDetailsViewControllerDelegate {
    
    let transactionCellIdentifier = "transactionItem"
    
    var transactions:[Transaction] = [Transaction]()
    var account: Account?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let account = account{
            self.title = account.name
            
            transactions = DataManager.shared.getTransactions(account: account)
        }
    }
    
    // MARK: - TableView data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: transactionCellIdentifier, for: indexPath) as! TransactionTableViewCell
        
        let transaction = transactions[indexPath.row]
        
        configureTransactionCell(for: cell, with: transaction)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteTransactionAction(indexPath: indexPath)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func deleteTransactionAction(indexPath: IndexPath) {
        let transaction = transactions[indexPath.row]
        let areYouSureAlert = UIAlertController(title: "Are you sure you want to delete this transaction?", message: "", preferredStyle: .alert)
        let yesDeleteAction = UIAlertAction(title: "Yes", style: .destructive) { [self] (action) in
            DataManager.shared.deleteTransaction(transaction: transaction)
            transactions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        let noDeleteAction = UIAlertAction(title: "No", style: .default) { (action) in
            //no action
        }
        areYouSureAlert.addAction(noDeleteAction)
        areYouSureAlert.addAction(yesDeleteAction)
        self.present(areYouSureAlert, animated: true, completion: nil)
    }
    
    func configureTransactionCell(for cell: TransactionTableViewCell, with transaction: Transaction)
    {
        cell.transactionName.text = transaction.name
        cell.transactionCategory.text = categoryName(category: transaction.category)
        cell.transactionAmount.text = String(describing: transaction.amount ?? 0)
        
        cell.iconImage.image = UIImage(named: categoryName(category: transaction.category))
    }
    
    
    func addItemViewControllerDidCancel(_ controller: TransactionDetailsTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addTransactionViewController(_ controller: TransactionDetailsTableViewController, transactionDidAdded transactionToAdd: Transaction) {
        
        transactionToAdd.account = account
        account?.addToTransactions(transactionToAdd)
        DataManager.shared.save()
        
        let newRowIndex = transactions.count
        
        transactions.append(transactionToAdd)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func editTransactionViewController(_ controller: TransactionDetailsTableViewController, transactionDidEdited transactionToEdit: Transaction) {
        
        DataManager.shared.save()
        
        self.tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddTransaction"
        {
            let controller = segue.destination as! TransactionDetailsTableViewController
            
            controller.delegate = self
        }
        
        if segue.identifier == "EditTransaction"
        {
            let controller = segue.destination as! TransactionDetailsTableViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! TransactionTableViewCell)
            {
                controller.transactionToEdit = transactions[indexPath.row]
            }
        }
    }
    
}

