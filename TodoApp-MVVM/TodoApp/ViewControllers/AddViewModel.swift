//
//  AddViewModel.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/22.
//

import Foundation

class AddViewModel {
    func addTodo(title: String, image: String, createDate: Date, modifyDate: Date){
        CoreDataManager.sharedInstance.insertTodo(Todo(id: UUID.init(), title: title, image: image, createDate: createDate, modifyDate: modifyDate))
    }
}
