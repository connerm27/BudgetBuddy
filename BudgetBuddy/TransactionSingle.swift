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
    
    
    
}
