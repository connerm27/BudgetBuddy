//
//  ViewController.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 3/22/22.
//

import UIKit



// Classes
// Style Transaction Cell
class TransactionCell: UITableViewCell {
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Amount: UILabel!
    
    
}


class ViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        
        
        super.init(coder: aDecoder)
        print("tVC:\(#function)")
    }
    
    
    // Outlet for + button on Transaction view
    
    @IBOutlet weak var atButton: UIButton!
    
    
    // Outlet for X button on transaction view
    @IBOutlet weak var xButton: UIButton!
    
    // View that contains form for adding a new transaction
    @IBOutlet weak var addTransactionView: UIView!
    
    // Brief Description Text Field
    @IBOutlet weak var briefDescriptionField: UITextField!
    
    // Transaction Amount Text Field
    @IBOutlet weak var tAmountField: UITextField!
    
    // Budget Category Picker
    @IBOutlet weak var picker: UIPickerView!
    
    
    // Value selected from picker
    var valueSelected:String = ""
    
    
    // Transaction Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Dynamic row in table
    var numberOfRows: Int = 0
    
    
    // Actions
    
    // Presents Add Transaction View
    @IBAction func presentForm(_ sender: Any) {
        
        // Show add transaction view form
        addTransactionView.isHidden = false
        
        // hide add button
        atButton.isHidden = true
        
        // show discard button
        xButton.isHidden = false
        
        // reload picker data (call delegate to receive new updates)
        picker.reloadAllComponents()
    }
    
    // Discards (hides) Add Transaction View
    @IBAction func discardForm(_ sender: Any) {
        // hides add transaction view form
        addTransactionView.isHidden = true
        
        // shows add button
        atButton.isHidden = false
        
        // hides discard buton
        xButton.isHidden = true
    }
    
    // Submits form (add transaction view form)
    @IBAction func addTransactionSubmit(_ sender: Any) {
        
        // Get Values from Text Fields
        let briefDescriptionText:String = briefDescriptionField.text ?? "N/A"
        let tAmountText:String = tAmountField.text ?? "0"
        
        
        // Do not add transaction, if category equals nothing
        
        if(valueSelected != "") {
            // Create transactio object from form data
            let transactionInstance = Transaction(budgetCategory: valueSelected, briefDescription: briefDescriptionText, transactionamount: tAmountText, transactionId:0)
            
            
            // Insert Object into database
            db.insertTransaction(category: transactionInstance.budgetCategory, description: transactionInstance.briefDescription, amount: transactionInstance.transactionamount)
            
            // Read in the new object to the shared instance array
            db.readTransactions()
            
            
            //Dynamically add row to table
            addRow()
        } else if(numberOfRows == 1) {
            // handles no action, one category showing
            // Create transaction object from form data
            let transactionInstance = Transaction(budgetCategory: TransactionSingle.sharedInstance.array[0].budgetCategory, briefDescription: briefDescriptionText, transactionamount: tAmountText, transactionId:0)
            
            // Insert Object into database
            db.insertTransaction(category: transactionInstance.budgetCategory, description: transactionInstance.briefDescription, amount: transactionInstance.transactionamount)
            
            // Read in the new object to the shared instance array
            db.readTransactions()
            
            //Dynamically add row to table
            addRow()
            
        } else {
            // handles if "nothing" is present, transaction field(s) are empty
        }
        
        
        
        
        // print for debugging
        for i in TransactionSingle.sharedInstance.array {
            print("\(i.budgetCategory) AND ")
            print("\(i.briefDescription) AND ")
            print("\(i.transactionamount)")
        }
        
        // Clear input fields
        briefDescriptionField.text = ""
        tAmountField.text = ""
        
        // hides the add transaction view, hides x button, shows at button
        addTransactionView.isHidden = true
        xButton.isHidden = true
        atButton.isHidden = false
        
      
        
        // dismiss keyboard
        self.tAmountField.endEditing(true)
        
        
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("tVC:\(#function)")
        // Do any additional setup after loading the view.
        
        // Any initial setup for the view
        setupScreen()
        
        
        // Data source/Delegate for picker
        self.picker.delegate = self
        self.picker.dataSource = self
        
       
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        // data source for tableView
        self.tableView.dataSource = self
        
        // Adding gesture to end editing of text fields
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                
        view.addGestureRecognizer(tap)
        
        db.readTransactions()
        
        
       
    }
    
    
    


    


}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource {

    // PICKER VIEW
    // Picker stubs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Items.sharedInstance.array.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Items.sharedInstance.array[row].category
        }
    
    // Saves current value selected to value selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        valueSelected = Items.sharedInstance.array[row].category as String
     }
    
    // TABLE VIEW
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        // return number of rows in shared instance
        return TransactionSingle.sharedInstance.array.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TransactionCell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! TransactionCell
        
        // Fetch Data
        let theTran = TransactionSingle.sharedInstance.array[indexPath.row]
        
        // Fill custom cell with data
        cell.Category?.text = theTran.budgetCategory
        cell.Description?.text = theTran.briefDescription
        cell.Amount?.text = "-$\(theTran.transactionamount)"
        
        
         
        return cell
    }
    
    func tableView(_ tableView:UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        db.deleteTransactionById(id: TransactionSingle.sharedInstance.array[indexPath.row].transactionId)
        TransactionSingle.sharedInstance.removeItem(removeIndex: indexPath.row)
        removeRow()
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        tableView.reloadData()
        
        
    }
    
    
    
    
    
}


extension ViewController {
    
    // Function to setup screen initially
    private func setupScreen() {
        // Initializes x button hidden, as well as the add transaction view
        addTransactionView.isHidden = true
        xButton.isHidden = true
        
        // Send Table View to the back
        tableView.superview?.sendSubviewToBack(tableView)
        
        // Set Row Height to be larger
        tableView.rowHeight = 100
        
    }
    
    // Function to add row dynamically to transaction table view
    private func addRow() {
        numberOfRows += 1
        
        //reload table
        tableView.reloadData()
        
    }
    
    // Function to remove row dynamically from transaction table view
    private func removeRow() {
        numberOfRows = numberOfRows-1
        
    
    }
    
    
    
}
