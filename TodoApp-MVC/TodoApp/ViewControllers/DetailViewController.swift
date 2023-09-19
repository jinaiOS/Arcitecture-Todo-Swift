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
    var dataList: Todo?
    // UIDatePicker 객체 생성을 해줍니다.
    let datePicker = UIDatePicker()
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightButton
        tfTitle.text = dataList?.title
        tfDate.text = dataList?.createDate.toString()        
        tfTitle.delegate = self
        tfDate.delegate = self
        setupDatePicker()
        self.hideKeyBoardWhenTappedAround()
        
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
    
    private func setupDatePicker() {
        // datePickerModed에는 time, date, dateAndTime, countDownTimer가 존재합니다.
        datePicker.datePickerMode = .date
        // datePicker 스타일을 설정합니다. wheels, inline, compact, automatic이 존재합니다.
        datePicker.preferredDatePickerStyle = .inline
        // 원하는 언어로 지역 설정도 가능합니다.
        datePicker.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 동작을 설정해 줌
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        datePicker.minimumDate = Date()
        // textField의 inputView가 nil이라면 기본 할당은 키보드입니다.
        tfDate.inputView = datePicker
        // textField에 오늘 날짜로 표시되게 설정
        tfDate.text = dateFormat(date: Date())
    }
    
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
        tfDate.text = dateFormat(date: sender.date)
    }
    
    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
}

extension DetailViewController : UITextFieldDelegate {
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
