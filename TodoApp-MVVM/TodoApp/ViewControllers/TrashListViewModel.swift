//
//  TrashListViewModel.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/22.
//

import Foundation

class TrashListViewModel {
    var trashList = CoreDataManager.sharedInstance.getTodos().filter { $0.isDelete == true }
}
