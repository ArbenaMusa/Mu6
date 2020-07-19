//
//  DBHelper.swift
//  Mu6
//
//  Created by Arbena on 19.7.20.
//  Copyright © 2020 am. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper{
    var db: OpaquePointer?
    var path: String = "mudatabase.sqlite"
    
    init(){
        self.db = createDB()
        self.createTable()
    }
    
    // MARK: - Database creation
    
    func createDB() -> OpaquePointer? {
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        
        var db: OpaquePointer? = nil
               
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error on opening database!")
            return nil
        }
        else{
            print("Database has been created successfully!")
            return db
        }
    }
    
    // MARK: - Table creation
    
    func createTable(){
        let query = "CREATE TABLE IF NOT EXISTS Scores(id INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER)"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table has been created successfully!")
            }
            else{
                print("Table creation failed!")
            }
        }
        else{
            print("Preparation failed!")
        }
    }
    
    // MARK: - Data insertion
    
    func insert(score: Int){
        let query = "INSERT INTO Scores(score) VALUES (?)"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(score))
        
            print(String(score))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data has been inserted successfully!")
            }
            else{
                print("Data hasn't been inserted!")
            }
        }
        else{
            print("query is not as required")
        }
    }
    
    // MARK: - Data retrieval
    
    func read() -> [ScoreModel]{
        var list = [ScoreModel]()
        
        let query = "SELECT * FROM Scores"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let score = Int(sqlite3_column_int(statement, 1))
                
                let scoreModel = ScoreModel(id: id, score: score)
                
                list.append(scoreModel)
            }
        }
        return list
    }
    
    // MARK: - Data maximum
    
    func getHighest() -> Int{
        var highestScore = 0
        
        let query = "SELECT MAX(score) FROM Scores"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let score = Int(sqlite3_column_int(statement, 0))
                highestScore = score
            }
        }
        return highestScore
    }
}
