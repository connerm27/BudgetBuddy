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
    
    static let sharedInstance = TransactionSingle()
    var array = [Transaction]()
    
    func removeItem(removeIndex:Int) {
        array.remove(at:removeIndex)
        
    }
    
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
