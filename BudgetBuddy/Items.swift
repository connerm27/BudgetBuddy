//
//  Items.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 4/8/22.
//

import Foundation

// Uses Singleton Design pattern to allow all tabviews to access the shared
// array of budgetCategories, so each can pull from it
class Items {
    // Shared instance of the array
    static let sharedInstance = Items()
    // The array of BudgetCategory Objects
    var array = [BudgetCategory]()
    
    // Removes a budget category from the array
    func removeItem(removeIndex:Int) {
        array.remove(at:removeIndex)
    }
    
    // gets the number of items in the array -> under-utilized
    func getCount() -> Int {
        return array.count
                
    }
}


//Ite
