//
//  Transaction.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 6/12/22.
//

import Foundation

// Transaction Structure
struct Transaction {
    // Budget Category
    var budgetCategory:String
    // Brief Description
    var briefDescription:String
    // Transaction Amount
    var transactionamount:String
    
    //Initialization
    init(budgetCategory:String, briefDescription:String, transactionamount:String) {
        self.budgetCategory = budgetCategory
        self.briefDescription = briefDescription
        self.transactionamount = transactionamount
        
        
    }
    
}
