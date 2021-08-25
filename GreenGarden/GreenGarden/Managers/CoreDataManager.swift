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
  
  var backgroundContext: NSManagedObjectContext {
    persistentContainer.newBackgroundContext()
  }
  
  func save() throws {
    do {
      try viewContext.save()
    } catch {
      print(error)
    }
  }
  
  func importData() async throws {
    
    func removeAlldata() {
      
      let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Vegetable")
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
      
      do {
        try viewContext.execute(deleteRequest)
      } catch {
        print(error)
      }
    }
    
    let vegetableDTOs = try await Webservice().getAllVegetables(url: Constants.Urls.getAllVegetables)
    
    // remove existing data
    removeAlldata()
    
    // insert vegetables in the database
    for vegetableDTO in vegetableDTOs {
      
      try await backgroundContext.perform {
        let vegetable = Vegetable(context: self.viewContext)
        vegetable.vegetableId = Int32(vegetableDTO.vegetableId)
        vegetable.name = vegetableDTO.name
        vegetable.vegetableDescription = vegetableDTO.description
        vegetable.seedDepth = vegetableDTO.seedDepth
        vegetable.thumbnailImage = vegetableDTO.thumbnailImage
        vegetable.growingSoilTemp = vegetableDTO.growingSoilTemp
        vegetable.sowingDescription = vegetableDTO.sowingDescription
        vegetable.growingDescription = vegetableDTO.growingDescription
        
        try self.save()
      }
      
    }
  
    
  }
  
}
