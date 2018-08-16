//
//  TestSGLite.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import SQLite

class TestSGLite: UIViewController {

    var database: Connection!
    
    let usersTable = Table("users")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            
            // create file users.sqlite3 stored localy on the user device
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            
            let database = try Connection(fileUrl.path)
            self.database = database
            
        }
        catch{
            print(error)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func createTable(_ sender: UIButton) {
        print("CREATE TABLE")
        
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email, unique: true)
        }
        
        do{
            try self.database.run(createTable)
            print("Created table")
        }
        catch{
            print(error)
        }

    }
    
    
    
    
    @IBAction func insertUser(_ sender: UIButton) {
    }
    
    
    
    
    @IBAction func listUser(_ sender: UIButton) {
    }
    
    
    
    
    @IBAction func updatetUser(_ sender: UIButton) {
    }
    
    
    
    
    
    @IBAction func deleteUser(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
