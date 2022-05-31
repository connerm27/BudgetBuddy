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
    static let sharedInstance = Items()
    var array = [BudgetCategory]()
    
    func removeItem(removeIndex:Int) {
        array.remove(at:removeIndex)
    }
    
    func getCount() -> Int {
        return array.count
                
    }
}


//Ite
