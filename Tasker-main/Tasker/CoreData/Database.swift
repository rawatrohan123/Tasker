//
//  Database.swift
//  Tasker
//
//  Created by Rohan Rawat on 3/12/22.

import UIKit
import CoreData


// Set up database functions to retrieve information from CoreData Database.

struct Database {
    
    // database
    static let db: NSManagedObjectContext = {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        

        let persistentContainer = delegate.persistentContainer
        let context = persistentContainer.viewContext
        return context
    }()
    
    // Retrieve an entry from the database.
    static func createTask() -> TaskEntry {
            let task = NSEntityDescription.insertNewObject(forEntityName: "TaskEntry", into: db) as! TaskEntry

            return task
    }
    
    // Save all the items
    static func save() {
        do {
            try db.save()
        } catch {
            print("Error saving new task!")
        }
    }
    
    // Delete a task in the database.
    static func deleteTask(task: TaskEntry) {
        db.delete(task)
        save()
    }
    
    // Get all the tasks as a list of task enteries
    static func getTasks() -> [TaskEntry] {
        do {
            let fetchRequest = NSFetchRequest<TaskEntry>(entityName: "TaskEntry")
            let allTasks = try db.fetch(fetchRequest)

            return allTasks
        }
        catch {
            print("Error getting the tasks!")
            return []
        }
    }
}
