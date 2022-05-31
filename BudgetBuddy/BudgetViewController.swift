//
//  BudgetViewController.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 4/6/22.
//

import UIKit

// Budget Category -- Structure
struct BudgetCategory {
    
    var category: String
    var amount: String
    
}

// Class for Table View Cell
class BudgetCell:UITableViewCell {
    
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var Amount: UILabel!
    
    
}


class BudgetViewController: UIViewController, UITableViewDataSource {
    

    // Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("bVC:\(#function)")
    }
    
    // Outlet for view that contains "Add to Budget" Form
    @IBOutlet weak var addToBudgetForm: UIView!
    
    // + Button Outlet
    @IBOutlet weak var atbButton: UIButton!
    // X Button Outlet
    @IBOutlet weak var xButton: UIButton!
    
    
    // Budget Category Text Field Value
    @IBOutlet weak var budgetCategoryValue: UITextField!
    
    
    // Amount per Month text field value
    @IBOutlet weak var AmountPerMonthValue: UITextField!
    

    // How long for labels to fade away (animation)
    private var fadeDuration: TimeInterval = 0.8
    
    // Programmatic components
    var success: UILabel!
    
    
    // Table View 
    @IBOutlet weak var tableView: UITableView!
    
    // Dynamic row in table
    var numberOfRows: Int = 0
    
    
    
    
    // target action, this will show addToBudgetForm
    @IBAction func addToBudgetButton(_ sender: Any) {
        // Shows budgetForm View, shows X button, hides atb button
        addToBudgetForm.isHidden = false
        xButton.isHidden = false
        atbButton.isHidden = true
        
        
    }
    
    // Clears/hides addToBudgetForm View
    @IBAction func clearAddButton(_ sender: Any) {
        // Hides budgetForm View, hides X button, shows atb button
        addToBudgetForm.isHidden = true
        xButton.isHidden = true
        atbButton.isHidden = false
        
    }
    
    @IBAction func addToBudgetSubmit(_ sender: Any) {
        // Get Values from fields as vars
        let BudgetCategoryText:String = budgetCategoryValue.text ?? "N/A"
        let AmountPerMonthText:String = AmountPerMonthValue.text ?? "0"
        
        
        // Check to see if category is already in budget
        var flag:Bool = false
        
        for i in Items.sharedInstance.array {
            // if text in text field category equals a category in our shared instnace
            if(BudgetCategoryText == i.category) {
                flag = true
            }
        }
        
        // Conditional
        // If category no in array, create object and append to array
        // else error
        
        if(flag == false) {
        
        // Create Budget Category Object
        let budgetCategoryInstance = BudgetCategory(category: BudgetCategoryText, amount: AmountPerMonthText)
        
        // Add object to share array instance
        Items.sharedInstance.array.append(budgetCategoryInstance)
            
        //Dynamically add row to table
        addRow()
            
        } else {
            // Indication of failure
            
        }
        
        
        // Clear Text Field text
        budgetCategoryValue.text = ""
        AmountPerMonthValue.text = ""
        
        // Hides budgetForm View, hides X button, shows atb button
        addToBudgetForm.isHidden = true
        xButton.isHidden = true
        atbButton.isHidden = false
    
    
        
   
        
        // print items from shared instance to console (for debugging)
        for i in Items.sharedInstance.array {
            print("\(i.category) AND ")
            print("\(i.amount) \n")
        }
        
        
        
   
        
        // dismiss keyboard
        self.AmountPerMonthValue.endEditing(true)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("bVC:\(#function)")
        setupScreen()
        
        // Do any additional setup after loading the view.
        
        
        // Table View
        tableView.dataSource = self
        
        // Adding gesture to end editing of text fields
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                
        view.addGestureRecognizer(tap)
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BudgetViewController {
    
    
    private func setupScreen() {
        // Initializes button hidden value
        addToBudgetForm.isHidden = true
        xButton.isHidden = true
        
        // Send Table View to the back
        tableView.superview?.sendSubviewToBack(tableView)
        
        // Set Row Height to be larger
        tableView.rowHeight = 75
    }
    
    
    
    // Function to dynamically add to rows
    private func addRow() {
        // add one to number of row
        numberOfRows += 1
        
        // Reload table
        tableView.reloadData()
        
        
    }
    
    private func removeRow() {
        // subtract one from number of row
        numberOfRows = numberOfRows-1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BudgetCell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! BudgetCell
        
        // Fetch Data
        let theBudg = Items.sharedInstance.array[indexPath.row]
        
        
      /* cell.textLabel?.text = "\(Items.sharedInstance.array[indexPath.row].category) - $\(Items.sharedInstance.array[indexPath.row].amount)"*/
        
        cell.Category?.text = theBudg.category
        cell.Amount?.text = "$\(theBudg.amount)"
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        Items.sharedInstance.removeItem(removeIndex: indexPath.row)
        removeRow()
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        tableView.reloadData()
        
    }
    

    


    

    
}




