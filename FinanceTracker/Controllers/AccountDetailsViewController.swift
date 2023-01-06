
import UIKit

class AccountDetailsViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var accountNameTextField: UITextField!
    @IBOutlet var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AccountDetailsViewControllerDelegate?
    var account: Account?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        
        if let account = account{
            title = "Edit Account"
            accountNameTextField.text = account.name
            
            doneBarButton.isEnabled = true
        }
        else
        {
            doneBarButton.isEnabled = false
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    //MARK: - First Responder
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountNameTextField.becomeFirstResponder()
    }
    
    //MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.accountDetailsViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any){
        
        if let account = account {
            
            account.name = accountNameTextField.text!
            delegate?.accountDetailsViewController(self, didFinishEditing: account)
        }
        else
        {
            let account = DataManager.shared.account(name: accountNameTextField.text!)
            
            delegate?.accountDetailsViewController(self, didFinishAdding: account)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: - Text Field Delegates
    
    func setupTextFields()
    {
        accountNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard accountNameTextField.isEmpty() else {
            doneBarButton.isEnabled = false
            return
        }
        
        doneBarButton.isEnabled = true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        
        return true
    }
    
    
}
