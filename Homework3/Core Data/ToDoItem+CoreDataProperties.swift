//
//  ToDoItem+CoreDataProperties.swift
//  
//
//  Created by detaysoft on 21.09.2022.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var isChecked: Bool
    @NSManaged public var name: String?
    @NSManaged public var isImportant: Bool
    @NSManaged public var createdDate: Date
}
