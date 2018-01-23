//
//  DBManager.swift
//  DataBase
//
//  Created by HeMu on 05/07/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit

class DBManager: NSObject {

    static let shared : DBManager = {
        let instance = DBManager()
        return instance
    }()
   
    var pathToDatabase: String!

    let databaseFileName = "DataBase.sqlite"
    
    var database:FMDatabase!
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
        
       // UserDefaultsModel.shared.setUserDefaultsValues(value: "\(self.getDocumentsDirectory())", key: "localDBBaseURL")
        print(pathToDatabase)
    }
    
    //register
     let person_id            = "p_id"
     let person_Fname         = "F_Name"
     let person_Lname         = "L_Name"
     let person_city          = "city"
     let person_address       = "address"
    
    func createDatabase() -> Bool {
        var created = false
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    
                    let createRegisterTable = "create table person (\(person_id) integer primary key autoincrement not null, \(person_Fname) text, \(person_Lname) text , \(person_city) text , \(person_address) text )"
                do {
                        try database.executeUpdate(createRegisterTable, values: nil)
                        created = true
                        
                    } catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        return created
    }

    
    func insertIntoPerson(p_info : NSDictionary ,completion : @escaping () -> Void) {
        if openDatabase(){
            
            let p_fname = p_info.value(forKey: "p_fname") as! String
            let p_lname = p_info.value(forKey: "p_lname") as! String
            let p_add   = p_info.value(forKey: "p_add") as! String
            let p_city  = p_info.value(forKey: "p_city") as! String
            
            let sql    = "INSERT INTO person ('\(person_Fname)','\(person_Lname)','\(person_city)','\(person_address)') VALUES('\(p_fname)','\(p_lname)','\(p_city)','\(p_add)')"
            do {
                try database.executeUpdate(sql, values: nil)
            } catch {
                print("error in insert \n\n\n======== \(error.localizedDescription) ")
            }
            database.close()
        }
        completion()
    }

    
    
    func UpdateInfoPerson(p_info : NSDictionary ,completion : @escaping () -> Void) {
        if openDatabase() {
           
            let p_id    = p_info.value(forKey: "p_id") as! String
            let p_fname = p_info.value(forKey: "p_fname") as! String
            let p_lname = p_info.value(forKey: "p_lname") as! String
            let p_add   = p_info.value(forKey: "p_add") as! String
            let p_city  = p_info.value(forKey: "p_city") as! String
            
            let sql    = "UPDATE person SET '\(person_Fname)' = '\(p_fname)','\(person_Lname)' = '\(p_lname)' ,'\(person_city)' = '\(p_city)','\(person_address)' = '\(p_add)' where p_id = '\(p_id)' "
            
            do {
                try database.executeUpdate(sql, values: nil)
            } catch {
                print("error in insert \n\n\n======== \(error.localizedDescription) ")
            }
            database.close()
        }
        completion()
    }
    
    
    func removeInfoPerson(p_info : NSDictionary ,completion : @escaping () -> Void) {
        
        if openDatabase() {
            let p_id = p_info.value(forKey: "p_id") as! String
            let sql  = "DELETE From person where p_id = '\(p_id)' "
            do {
                try database.executeUpdate(sql, values: nil)
            } catch {
                print("error in insert \n\n\n======== \(error.localizedDescription) ")
            }
            database.close()
        }
        completion()
    }
    
    
    func insertIntoPerson(completion : @escaping () -> Void) {
        
        if openDatabase() {
            let sql    = "Select * From person"
            do {
                try database.executeQuery(sql, values: nil)
            } catch {
                print("error in insert \n\n\n======== \(error.localizedDescription) ")
            }
            database.close()
        }
        completion()
    }
    
    
    func getPersonInfo(completion : @escaping (_ result : NSMutableArray) -> Void ) {
        var result : FMResultSet
        let person_data : NSMutableArray = NSMutableArray()
        if openDatabase() {
            do {
               let sql    = "Select * From person Order By F_Name ASC"
               result = try database.executeQuery(sql, values: nil)
               while (result.next()) {
                
                    let id          =  Int(result.int(forColumn: self.person_id))
                    let Fname       =  result.string(forColumn: self.person_Fname)
                    let Lname       =  result.string(forColumn: self.person_Lname)
                    let city        =  result.string(forColumn: self.person_city)
                    let address     =  result.string(forColumn: self.person_address)
                
                    let person : PersonModel = PersonModel.init(person_id: "\(id)", person_Fname: Fname!, person_Lname: Lname!, person_city: city!, person_address: address!)
                    person_data.add(person)
               }
            } catch {
                print("error   \(error.localizedDescription)")
            }
            database.close()
        }
        completion(person_data as NSMutableArray)
    }
    
    func checkDbExsistence() -> Bool{
        var exsist = false
        if FileManager.default.fileExists(atPath: pathToDatabase) {
            exsist = true
        }
        return exsist
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
}
