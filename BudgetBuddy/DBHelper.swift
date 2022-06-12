//
//  DBHelper.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 6/12/22.
//


import Foundation
import SQLite3

class DBHelper {
    
    // initialize
    init() {
        db = openDatabase()
        createTable()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        
        var db:OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
            
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
        
        
        
    }
    
    
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY, name TEXT, age INTEGER);"
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created.")
            } else {
                print("person table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
        
        
    }
    
    
    // insert function
    func insert(id:Int, name:String, age:Int) {
        let persons = read()
        for p in persons {
            if p.id == id {
                return
            }
        }
        let insertStatementString = "INSERT INTO person (Id, name, age) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(age))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row")
            } else {
                print("Error: Could not insert row")
            }
            
            
        } else {
            print ("Error: INSERT statement could not be prepared")
        }
        
        sqlite3_finalize(insertStatement)
}

    
    func read() -> [Person] {
        
        // SQL Query Statement selects from database
        let queryStatementString = "SELECT * FROM person;"
        
        var queryStatement: OpaquePointer? = nil

        // empty array of Person Objects
        var psns: [Person] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let year = sqlite3_column_int(queryStatement, 2)
                
                // AFter getting data for each column, add to psns array
                psns.append(Person(id: Int(id), name: name, age: Int(year)))
                print("Query Result: ")
                print("\(id) | \(name) | \(year)")
            }
            
            
        } else {
            
            print("Error: select statement could not be prepared")
            
        }
        
        sqlite3_finalize(queryStatement)
    
        
        return psns
        
    }
    
    
    
    func deleteById(id:Int) {
        let deleteStatementString = "DELETE FROM persons WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row")
            } else {
                print("Error: could not delete row")
            }
            
            
        } else {
            print("Error: could not prepare delete statement")
            
        }
        
        sqlite3_finalize(deleteStatement)
        
        
    }
    
    
    
    
    
}
