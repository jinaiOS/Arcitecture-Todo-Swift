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
    
    func fetchTodos() -> [Todo] {
           do {
               let request = Todo.fetchRequest()
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
            let fetchResults = fetchBookmarks()
            let notice = fetchResults.filter({ $0.url == notice.url })[0]
            context.delete(notice)
            saveToContext()
        }
        
        func deleteAllBookmarks() {
            let fetchResults = fetchBookmarks()
            for result in fetchResults {
                context.delete(result)
            }
            saveToContext()
        }
}
