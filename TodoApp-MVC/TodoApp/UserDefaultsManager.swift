//
//  UserDefaultsManager.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/03.
//

import Foundation

class UserDefaultsManager {
    
    static let sharedInstance = UserDefaultsManager()
    
    var memoList = [MemoListModel]() {
        didSet {
            self.saveTasks()
        }
    }
    
    var trashList = [MemoListModel]() {
        didSet {
            self.trashTasks()
        }
    }
    
    func saveTasks() {
        let data = self.memoList.map {
            [
                "title": $0.title,
                "date": $0.date,
                "content": $0.content,
                "category": $0.category,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "memoList")
        
    }
    
    func loadTasks() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "memoList") as? [[String: Any]] else { return }
        // "tasks"에 대한 value가 Any?타입으로 반환되는데, 이 Any를 [[String: Any]] 로 타입캐스팅한 것.
        self.memoList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let date = $0["date"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let category = $0["category"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return MemoListModel(title: title, date: date, content: content, category: category, done: done)
        }
    }
    
    func trashTasks() {
        let data = self.trashList.map {
            [
                "title": $0.title,
                "date": $0.date,
                "content": $0.content,
                "category": $0.category,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "trashList")
    }
    
    func loadTrashTasks() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "trashList") as? [[String: Any]] else { return }
        // "tasks"에 대한 value가 Any?타입으로 반환되는데, 이 Any를 [[String: Any]] 로 타입캐스팅한 것.
        self.trashList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let date = $0["date"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let category = $0["category"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return MemoListModel(title: title, date: date, content: content, category: category, done: done)
        }
    }
}
