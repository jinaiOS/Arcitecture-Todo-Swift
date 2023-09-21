//
//  Todo+CoreDataProperties.swift
//  
//
//  Created by 김지은 on 2023/09/14.
//
//

import Foundation
import CoreData


extension TodoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var image: String
    @NSManaged public var createDate: Date
    @NSManaged public var modifyDate: Date
    @NSManaged public var isCompleted: Bool
    @NSManaged public var isDelete: Bool

}
