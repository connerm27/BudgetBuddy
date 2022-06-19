//
//  TransactionSingle.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 4/26/22.
//

import Foundation

// Creates Singleton instance of an array that can hold transaction objects, and be shared
// By each tab within our app
class TransactionSingle {
    
    // Shared instance Singleton
    static let sharedInstance = TransactionSingle()
    // Shared array of transaction objects
    var array = [Transaction]()
    
    // Removes an transaction from the array
    func removeItem(removeIndex:Int) {
        array.remove(at:removeIndex)
        
    }
    
    // Removes associated transactions with categorys (when you need to delete a category, delete associated transactions
    func removeCategory(category:String) {
        var c:Int = 0
        for i in array {
            if(i.budgetCategory == category) {
                array.remove(at:c)
                c = c-1
            }
            c+=1
        }
    }
    
    
    
    
}
