//
//  UIViewController+Extension.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/03.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyBoardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
