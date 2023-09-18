//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/03.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    var context: NSManagedObjectContext {
        return AppDelegate().persistentContainer.viewContext
    }
    
    var todoEntity: NSEntityDescription? {
        return  NSEntityDescription.entity(forEntityName: "TodoModel", in: context)
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTodos() -> [TodoModel] {
        do {
            let request = TodoModel.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func getTodos() -> [Todo] {
        var todos: [Todo] = []
        let fetchResults = fetchTodos()
        for result in fetchResults {
            let todo = Todo(id: UUID(), title: result.title, createDate: result.createDate, modifyDate: result.modifyDate)
            todos.append(todo)
        }
        return todos
    }
    
    func insertTodo(_ todo: Todo) {
        if let entity = todoEntity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            managedObject.setValue(todo.id, forKey: "id")
            managedObject.setValue(todo.title, forKey: "title")
            managedObject.setValue(todo.createDate, forKey: "createDate")
            managedObject.setValue(todo.modifyDate, forKey: "modifyDate")
            managedObject.setValue(todo.isCompleted, forKey: "isCompleted")
            saveToContext()
        }
    }
    
    func updateTodo(_ todo: Todo) {
        let fetchResults = fetchTodos()
        for result in fetchResults {
            if result.id == todo.id {
                result.title = "업데이트한 제목"
            }
        }
        saveToContext()
    }
    
    func deleteBookmark(_ todo: Todo) {
        let fetchResults = fetchTodos()
        let notice = fetchResults.filter({ $0.id == todo.id })[0]
        context.delete(notice)
        saveToContext()
    }
    
    func deleteAllBookmarks() {
        let fetchResults = fetchTodos()
        for result in fetchResults {
            context.delete(result)
        }
        saveToContext()
    }
}
