//
//  ProfileViewModel.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/22.
//

import Foundation

class ProfileViewModel {
    let todoList = CoreDataManager.sharedInstance.getTodos().filter { $0.isDelete == false }
}
