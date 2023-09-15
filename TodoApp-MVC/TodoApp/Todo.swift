//
//  Todo.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/03.
//

import Foundation

struct Todo {
    var id: UUID /// 각 Todo의 고유 ID
    var title: String /// 제목
    var createDate: Date /// 생성된 날짜
    var modifyDate: Date ///  생성된 날짜
    var isCompleted: Bool = false /// 완료여부
}


