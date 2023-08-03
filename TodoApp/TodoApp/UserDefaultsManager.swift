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
    
    func saveTasks() {
        let data = self.memoList.map {
            [
                "title": $0.title,
                "date": $0.date,
                "content": $0.content,
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
            guard let done = $0["done"] as? Bool else { return nil }
            return MemoListModel(title: title, date: date, content: content, done: done)
        }
    }
}
//    @UserDefaultWrapper(key: "memoList", defaultValue: nil)
//    static var subjectList: [MemoListModel]?

//UserDefaultWrapper 정의
//@propertyWrapper
//struct UserDefaultWrapper<T: Codable> {
//    private let key: String
//    private let defaultValue: T?
//
//    init(key: String, defaultValue: T?) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }

//    var wrappedValue: T? {
//        get {
//            // 언아카이빙 정의 : JSONDecoder 사용
//            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
//                let decoder = JSONDecoder()
//                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
//                    return lodedObejct
//                }
//            }
//            return defaultValue
//        }
//        set {
//            // 아카이빙 정의 : JSONEncoder 사용
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(newValue) {
//                UserDefaults.standard.setValue(encoded, forKey: key)
//            }
//        }
//    }
//}

