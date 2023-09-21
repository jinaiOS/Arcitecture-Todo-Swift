//
//  TodoCompleteViewModel.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/22.
//

import Foundation

class TodoCompleteViewModel {
    let completeData = CoreDataManager.sharedInstance.getTodos().filter { $0.isCompleted == true }
}
