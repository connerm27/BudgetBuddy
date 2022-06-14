//
//  BudgetCategory.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 6/12/22.
//

import Foundation

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
