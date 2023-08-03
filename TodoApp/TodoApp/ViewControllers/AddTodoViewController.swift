//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/03.
//

import Foundation
import UIKit

class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var svMain: UIScrollView!
    @IBOutlet weak var textVContent: UITextView!
    
    // Create right UIBarButtonItem.
       lazy var rightButton: UIBarButtonItem = {
           let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
           button.tag = 2
           
           return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightButton
        tfTitle.delegate = self
        tfDate.delegate = self
        self.hideKeyBoardWhenTappedAround()
    }
    
    @objc func buttonPressed(_ sender: Any) {
        UserDefaultsManager.sharedInstance.memoList.append(MemoListModel(title: tfTitle.text ?? "", date: tfTitle.text ?? "", content: textVContent.text ?? ""))
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddTodoViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        let maxLength = 15
        
        return newLength <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // 키보드 내리면서 동작
        textField.resignFirstResponder()
        return true
    }
}

