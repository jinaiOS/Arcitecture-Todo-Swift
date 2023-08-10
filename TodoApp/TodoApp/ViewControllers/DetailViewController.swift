//
//  DetailViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {

    /** @brief title text field */
    @IBOutlet weak var tfTitle: UITextField!
    /** @brief date text field */
    @IBOutlet weak var tfDate: UITextField!
    /** @brief content text field */
    @IBOutlet weak var tfContent: UITextView!
    
    // 넘겨받는 투두 데이터 리스트
    var dataList: [String?] = []
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightButton
        tfTitle.text = dataList[0]
        tfDate.text = dataList[1]
        tfContent.text = dataList[2]
        
        textFieldEnabled(isEnabled: false)
    }
    
    func textFieldEnabled(isEnabled: Bool) {
        tfTitle.isEnabled = isEnabled
        tfDate.isEnabled = isEnabled
        tfContent.isEditable = isEnabled
    }

    @objc func buttonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Edit" {
            textFieldEnabled(isEnabled: true)
            sender.title = "Done"
        } else {
            textFieldEnabled(isEnabled: false)
            sender.title = "Edit"
        }
    }
}
