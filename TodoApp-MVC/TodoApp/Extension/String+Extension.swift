//
//  String+Extension.swift
//  TodoApp
//
//  Created by 김지은 on 2023/09/18.
//

import Foundation

extension String {
    func toDate() -> Date { //"yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: self)
        return date!
    }
}
