//
//  PastBudget.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 6/19/22.
//

import Foundation

class PastBudget {
    
    var month: String
    var year: String
    
    var transactions:TransactionSingle
    var categories:Items
    
    init(month:String, year:String, transactions:TransactionSingle, categories:Items) {
        
        self.month = month
        self.year = year
        
        self.transactions = transactions
        self.categories = categories
        
        
    }
    
    
    
}






/*


// Budget Category -- Class
class BudgetCategory {
    
    var category: String
    var amount: String
    var id: Int = 0
    
    
    init(category:String, amount:String, id:Int) {
        self.category = category
        self.amount = amount
        self.id = id
    }
    
}
*/
