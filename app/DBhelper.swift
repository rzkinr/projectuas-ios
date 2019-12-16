//
//  DBhelper.swift
//  app
//
//  Created by RIzkiNur on 24/11/19.
//  Copyright © 2019 vokasi. All rights reserved.
//

import Foundation
import SQLite3

class DBhelper
{
    //Open database
    init()
    {
        db = openDatabase()
        createTable()
        createTableUsers()
    }
    
    let dbPath: String = "bukuDB.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    //data buku
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS buku(Id INTEGER PRIMARY KEY AUTOINCREMENT, esbn TEXT, judulbuku TEXT, pengarangbuku TEXT, penerbitbuku TEXT, kategoribuku TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Buku table created.")
            } else {
                print("Buku table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(esbn: String, judulbuku: String, pengarangbuku: String, penerbitbuku: String, kategoribuku: String )
    {
        
        let insertStatementString = "INSERT INTO buku(esbn, judulbuku, pengarangbuku, penerbitbuku, kategoribuku) VALUES(?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (esbn as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (judulbuku as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (pengarangbuku as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (penerbitbuku as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (kategoribuku as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
        
    func read() -> [Buku] {
        let queryStatementString = "SELECT * FROM buku;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Buku] = [] //setting structure table
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //read in table
                let id = sqlite3_column_int(queryStatement, 0)
                let esbn = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let judulbuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let pengarangbuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let penerbitbuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let kategoribuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                psns.append(Buku(Id: Int(id), esbn: esbn, judulbuku: judulbuku, pengarangbuku: pengarangbuku, penerbitbuku: penerbitbuku, kategoribuku: kategoribuku))
                print("Query Result:")
                print("\(id) | \(esbn) | \(judulbuku) | \(pengarangbuku) | \(penerbitbuku) | \(kategoribuku)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func readsingle(kategoribuku: String) ->[Buku]{
        let queryStatementString = "SELECT * FROM buku WHERE kategoribuku = ?;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Buku] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (kategoribuku as NSString).utf8String, -1, nil)
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let esbn = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let judulbuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let pengarangbuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let penerbitbuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let kategoribuku = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                psns.append(Buku(Id: Int(id), esbn: esbn, judulbuku: judulbuku, pengarangbuku: pengarangbuku, penerbitbuku: penerbitbuku, kategoribuku: kategoribuku))
                print("Query Result:")
                print("\(id) | \(esbn) | \(judulbuku) | \(pengarangbuku) | \(penerbitbuku) | \(kategoribuku)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func update(esbn: String, judulbuku: String, pengarangbuku: String, penerbitbuku: String, kategoribuku: String, Id: Int)
    {
        let insertStatementString = "UPDATE buku SET esbn=?, judulbuku=?, pengarangbuku=?, penerbitbuku=?, kategoribuku=? WHERE Id=?;"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (esbn as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (judulbuku as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (pengarangbuku as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (penerbitbuku as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (kategoribuku as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 6, Int32(Id))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM buku WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    //user
    
    func createTableUsers() {
        let createTableString = "CREATE TABLE IF NOT EXISTS users(Id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, katasandi TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Users table created.")
            } else {
                print("Users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertUsers(nama: String, katasandi: String)
    {
        let insertStatementString = "INSERT INTO users(nama, katasandi) VALUES(?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (nama as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (katasandi as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readUsers() -> [Users]{
        let queryStatementString = "SELECT * FROM users;"
        var queryStatement: OpaquePointer? = nil
        var usr: [Users] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //read in table
                let id = sqlite3_column_int(queryStatement, 0)
                let nama = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let katasandi = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                usr.append(Users(Id: Int(id), nama: nama, katasandi: katasandi))
                print("Query Result:")
                print("\(id) | \(nama) | \(katasandi)")
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return usr
    }
    
    func readUsers(nama: String, katasandi: String) -> [Users]{
        let queryStatementString = "SELECT * FROM users WHERE nama=? AND katasandi=?;"
        var queryStatement: OpaquePointer? = nil
        var usr: [Users] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (nama as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (katasandi as NSString).utf8String, -1, nil)
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //read in table
                let id = sqlite3_column_int(queryStatement, 0)
                let namaa = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let katasandii = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                usr.append(Users(Id: Int(id), nama: namaa, katasandi: katasandii))
                print("Query Result:")
                print("\(id) | \(namaa) | \(katasandii)")
            }
            
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return usr
    }
}
