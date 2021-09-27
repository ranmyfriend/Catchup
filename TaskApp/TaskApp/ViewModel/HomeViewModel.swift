//
//  HomeViewModel.swift
//  TaskApp
//
//  Created by BKS-GGS on 27/09/21.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    
    // for new data sheet...
    @Published var isNewData = false
    
    // Checking and updating date
    
    // Storing update item
    @Published var updateItem: Task!
    
    let calender = Calendar.current
    func checkDate() -> String {
        if calender.isDateInToday(date) {
            return "Today"
        } else if calender.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            return "other day"
        }
    }
    
    func updateDate(value: String) {
        if value == "Today" {
            date = Date()
        } else if value == "Tomorrow" {
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        } else {
            // do something
        }
    }
    
    func writeData(context: NSManagedObjectContext) {
        
        //updating item
        if updateItem != nil {
            // means update old data
            updateItem.date = date
            updateItem.content = content
            try! context.save()
            //remvoing updating item if success
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        do {
           try context.save()
            isNewData.toggle()
            content = ""
            date = Date()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editItem(item: Task) {
        updateItem = item
            //toggleing the newDataView
        date = item.date!
        content = item.content!
        isNewData.toggle()
    }
 }
