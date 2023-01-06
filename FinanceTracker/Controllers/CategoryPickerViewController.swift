
import UIKit

protocol CategoryPickerViewControllerDelegate : AnyObject {
    func categoryPiker(_ picker: CategoryPickerViewController, didPick category: Category)
}

class CategoryPickerViewController : UITableViewController
{
    
    let cellIdentifier = "iconCell"
    weak var delegate: CategoryPickerViewControllerDelegate?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let category = Category.allCases[indexPath.row]
        
        cell.textLabel?.text = categoryName(category: category)
        cell.imageView?.image = UIImage(named: categoryName(category: category))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate{
            
            let category =  Category.allCases[indexPath.row]
            
            delegate.categoryPiker(self, didPick: category)
        }
    }
}
