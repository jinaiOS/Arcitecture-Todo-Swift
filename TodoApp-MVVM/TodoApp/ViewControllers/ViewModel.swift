//
//  ViewModel.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/21.
//

import Foundation

class ViewModel {
    var todoList: [Todo] = []
    
    func getNotCompletedTodoList() {
        todoList = CoreDataManager.sharedInstance.getTodos().filter { $0.isDelete == false && $0.isCompleted == false }
    }
    
    func deleteTodoList(index: Int) {
        CoreDataManager.sharedInstance.deleteTodo(todoList[index])
    }
}
