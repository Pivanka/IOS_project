
import UIKit

class AccountsListViewController: UITableViewController, AccountDetailsViewControllerDelegate, UINavigationControllerDelegate {
    
    let cellIdentifier = "accountCell"
    
    var accounts = [Account]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accounts = DataManager.shared.getAllAccounts()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return accounts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccountTableViewCell
        
        let account = accounts[indexPath.row]
        
        cell.accountNameLabel!.text = account.name
        cell.spendingsLabel!.text = String(describing: getStatistics(for: account, by: {$0.amount?.decimalValue ?? 0 < 0}))
        cell.incomesLabel!.text = String(describing: getStatistics(for: account, by: {$0.amount?.decimalValue ?? 0 > 0}))
        cell.accessoryType = .detailDisclosureButton
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UserDefaults.standard.set(indexPath.row, forKey: "SelectedAccountIndex")
        
        let selectedAccount = accounts[indexPath.row]
        
        performSegue(withIdentifier: "ShowAccount", sender: selectedAccount)
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteAccountAction(indexPath: indexPath)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func deleteAccountAction(indexPath: IndexPath) {
        let account = accounts[indexPath.row]
        let areYouSureAlert = UIAlertController(title: "Are you sure you want to delete this account?", message: "", preferredStyle: .alert)
        let yesDeleteAction = UIAlertAction(title: "Yes", style: .destructive) { [self] (action) in
            DataManager.shared.deleteAccount(account: account)
            accounts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        let noDeleteAction = UIAlertAction(title: "No", style: .default) { (action) in
            //do nothing
        }
        areYouSureAlert.addAction(noDeleteAction)
        areYouSureAlert.addAction(yesDeleteAction)
        self.present(areYouSureAlert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "AccountDetailsViewController") as! AccountDetailsViewController
        
        controller.delegate = self
        
        let account = accounts[indexPath.row]
        controller.account = account
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAccount"
        {
            let controller = segue.destination as! TransactionListViewController
            
            controller.account = sender as? Account
        }
        
        if segue.identifier == "AddAccount"
        {
            let controller = segue.destination as! AccountDetailsViewController
            
            controller.delegate = self
        }
    }
    
    
    //MARK: - Delegate
    
    func accountDetailsViewControllerDidCancel(_ controller: AccountDetailsViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func accountDetailsViewController(_ controller: AccountDetailsViewController, didFinishAdding account: Account) {
        
        DataManager.shared.save()
        let newRowIndex = accounts.count
        
        accounts.append(account)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func accountDetailsViewController(_ controller: AccountDetailsViewController, didFinishEditing account: Account) {
        
        DataManager.shared.save()
        self.tableView.reloadData()
        
        navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self
        {
            UserDefaults.standard.set(-1, forKey: "SelectedAccountIndex")
        }
    }
}

extension AccountsListViewController
{
    
    func getStatistics(for account: Account, by predicate: (Transaction) ->Bool) -> Decimal
    {
        let transactions = DataManager.shared.getTransactions(account: account).filter(predicate)
        
        return transactions.map{$0.amount! as Decimal}.reduce(0, +)
    }
}
