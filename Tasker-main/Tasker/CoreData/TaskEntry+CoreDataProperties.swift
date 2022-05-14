//
//  TaskEntry+CoreDataProperties.swift
//  Tasker
//
//  Created by Rohan Rawat on 3/12/22.

import Foundation
import CoreData


extension TaskEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntry> {
        return NSFetchRequest<TaskEntry>(entityName: "TaskEntry")
    }

    @NSManaged public var entryDate: Date?
    @NSManaged public var summary: String?
    @NSManaged public var task: String?
    @NSManaged public var priority: Int16

}

extension TaskEntry : Identifiable {

}
