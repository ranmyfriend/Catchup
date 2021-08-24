//
//  CoreDataManager.swift
//  GreenGarden
//
//  Created by BKS-GGS on 21/08/21.
//

import Foundation
import CoreData

/*
 bks-ggs@BKS-GGSs-MBP Application Support % sqlite3 GreenGardenModel.sqlite
 SQLite version 3.32.3 2020-06-18 14:16:19
 Enter ".help" for usage hints.
 sqlite> .tables
 ZVEGETABLE    Z_METADATA    Z_MODELCACHE  Z_PRIMARYKEY
 sqlite> select * from zvegetable;
 sqlite> .quit
 */

class CoreDataManager {
  
  let persistentContainer: NSPersistentContainer
  
  static let shared = CoreDataManager()
  private init() {
    persistentContainer = NSPersistentContainer(name: "GreenGardenModel")
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Failed to initialize Core Data \(error)")
      }
    }
    
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    print(directories[0])
  }
  
  var viewContext: NSManagedObjectContext {
     persistentContainer.viewContext
  }
  
  func save() throws {
    do {
      try viewContext.save()
    } catch {
      print(error)
    }
  }
  
}
