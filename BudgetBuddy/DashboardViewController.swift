//
//  DashboardViewController.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 4/6/22.
//

import UIKit



class DashCell:UITableViewCell {
    
    @IBOutlet weak var Category:UILabel!
    @IBOutlet weak var Amount:UILabel!
    @IBOutlet weak var AmountLeft: UILabel!
    @IBOutlet weak var progressBar: ProgressBar!
    
}


class DashboardViewController: UIViewController {
    
    // Initializer
    // Documentation of what NSCoder is:
    /*
        NSCoder declares the interface used by concrete subclasses to transfer objects and other values between memory and some other format.
        This capability provides the basis for archiving (storing objects and data on disk) and distribution (copying objects and data items
        between different processes or threads).
     
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("dVC:\(#function)")
    }

    // Variables
    @IBOutlet weak var monthBudgetLabel: UILabel!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // animation count
    var countFired: CGFloat = 0
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var message2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prints to console viewDidLoad()
        print("dVC:\(#function)")
        
        // Screen setup for dashboard
        screenSetup()
        
        // Table View Data Source
        tableView.dataSource = self
        
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        if(Items.sharedInstance.getCount() > 0) {
            message.isHidden = true
            message2.isHidden = true
        } else {
            message.isHidden = false
            message2.isHidden = false
        }
        
        
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

extension DashboardViewController {
    
    private func screenSetup() {
        // Show Month
        monthBudgetLabel.text = "\(getDate()) Budget"
        
        // Set Row Height for larger, for table cells
        tableView.rowHeight = 300
        
        message.isHidden = true
        message2.isHidden = true
        
        // show message if nothing in table
        if(Items.sharedInstance.getCount() > 0) {
            message.isHidden = true
            message2.isHidden = true
        }
        
    }
    
    func getDate() -> String {
        // Creates a date instance
        let date = Date()
        // Turn date into string of the month
        let month = Calendar.current.component(.month, from: date)
        // Array of Months of the year as String
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        // return variable, uses month as integer, to find string of month in array (-1, indexed from 0)
        let stringMonth = months[month-1]
        
        
        // Returns the current month as a string
        return stringMonth
        
        
    }
    
    
    func getAmountLeft(indexNum:Int) -> Float {
        
        // Budget Data
        let budgData = Items.sharedInstance.array[indexNum]
        // Get Total Budget Amount
        let amount:Float = Float(budgData.amount) ?? 0
        // Get name of Budget Category
        let name:String = budgData.category
        
        // Will sum up the transactions in the category
        var totalTran:Float = 0
        
        // Go through transactions list, if category matches, sum transactions
        for tran in TransactionSingle.sharedInstance.array {
            
            if(tran.budgetCategory == name) {
                let tranAmount:Float = Float(tran.transactionamount) ?? 0
                totalTran += tranAmount
            }
            
            
        }
        
        
        // Return string of category amount - total transactions
        let returnedAmount:Float = amount-totalTran
        
        
        return returnedAmount
        
    }
    
    
    
    
}


extension DashboardViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Items.sharedInstance.getCount()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DashCell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! DashCell
        
        // Get budget data
        let budgData = Items.sharedInstance.array[indexPath.row]
        
        
        
        
        // set up cell view
        cell.Category?.text = budgData.category
        cell.Amount?.text = "$\(budgData.amount)"
        cell.AmountLeft?.text = "$\(getAmountLeft(indexNum:indexPath.row))"
        

        
        // Makes timer animation for circle showing progress
        Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { (timer) in
            self.countFired += 1
            
            // Get total subtracted
            let getSub:CGFloat = CGFloat(self.getAmountLeft(indexNum:indexPath.row))
            
            
            DispatchQueue.main.async { [self] in
                cell.progressBar?.progressLabel = min(self.countFired, getSub)
                
                if cell.progressBar?.progressLabel == getSub {
                    timer.invalidate()
                    
                }
            }
        }
        
        
        // Makes timer animation for circle showing progress
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.countFired += 1
            
            // Get total subtracted
            let getSub:CGFloat = CGFloat(self.getAmountLeft(indexNum:indexPath.row))
            
            //get Total amount
            let getTotal:CGFloat = CGFloat(Float(budgData.amount) ?? 0)
            
            //equation
            let amountLeft = getTotal - getSub
            
            // %/100 - is/of
            let result = 100 - ((amountLeft*100) / getTotal)
            
            DispatchQueue.main.async { [self] in
                cell.progressBar?.progress = min(0.03 * self.countFired, result/100)
                
                if cell.progressBar?.progress == result/100 {
                    timer.invalidate()
                    
                }
            }
        }
        
        return cell
    }
    
    
    
    
}
