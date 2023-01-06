import UIKit

class TransactionDetailsTableViewController: UITableViewController, UITextFieldDelegate, CategoryPickerViewControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var iconNameLabel: UILabel!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var  delegate: TransactionDetailsViewControllerDelegate?
    
    var category: Category = .other
    
    var transactionToEdit: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        
        if let transaction = transactionToEdit
        {
            title = "Edit Transaction"
            doneBarButton.isEnabled = true
            
            nameField.text = transaction.name
            amountField.text = String(describing: transaction.amount ?? 0)
            
            if let dateCreated = transaction.dateCreated
            {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd' 'HH:mm"
                dateCreatedLabel.text = dateFormater.string(from: dateCreated)
                print(dateFormater.string(from: dateCreated))
            }
            else
            {
                dateCreatedLabel.text = "Date is unavailable"
            }
            
            category = transaction.category
        }
        else
        {
            title = "Add Transaction"
            doneBarButton.isEnabled = false
        }
        
        iconNameLabel.text = categoryName(category: category)
        iconImage.image = UIImage(named: categoryName(category: category))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    //MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        
        if let transaction = transactionToEdit
        {
            
            transaction.name = nameField.text!
            transaction.category = category
            
            delegate?.editTransactionViewController(self, transactionDidEdited: transaction)
        }
        else
        {
            let amount: Decimal = Decimal(string: amountField.text!) ?? 0
            
            let transaction = DataManager.shared.transaction(name: nameField.text!, amount: amount, dateCreated: Date.now, category: self.category)
            
            delegate?.addTransactionViewController(self, transactionDidAdded: transaction)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickCategory"
        {
            let controller = segue.destination as! CategoryPickerViewController
            
            controller.delegate = self
        }
    }
    
    //MARK: - First Responder
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        nameField.becomeFirstResponder()
    }
    
    //MARK: - Icon Picker Delegate
    
    func categoryPiker(_ picker: CategoryPickerViewController, didPick category: Category) {
        
        self.category = category
        self.iconNameLabel.text = categoryName(category: category)
        self.iconImage.image = UIImage(named: categoryName(category: category))
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Text Field Delegates
    
    func setupTextFields()
    {
        nameField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        amountField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard nameField.isEmpty(),
              amountField.isEmpty()
        else {
            doneBarButton.isEnabled = false
            return
        }
        
        doneBarButton.isEnabled = true
    }
    
}
