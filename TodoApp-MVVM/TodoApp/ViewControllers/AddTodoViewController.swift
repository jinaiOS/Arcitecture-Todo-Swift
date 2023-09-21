//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/03.
//

import Foundation
import UIKit

class AddTodoViewController: UIViewController, UINavigationControllerDelegate {
    
    /** @brief title text field */
    @IBOutlet weak var tfTitle: UITextField!
    /** @brief date text field */
    @IBOutlet weak var tfDate: UITextField!
    /** @brief main scrollview */
    @IBOutlet weak var svMain: UIScrollView!
    /** @brief content text field */
    @IBOutlet weak var textVContent: UITextView!
    /** @brief image */
    @IBOutlet weak var imgAdd: UIImageView!
    
    // UIDatePicker 객체 생성을 해줍니다.
    let datePicker = UIDatePicker()
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightButton
        self.navigationItem.title = "Add"
        tfTitle.delegate = self
        tfTitle.becomeFirstResponder()
        tfDate.delegate = self
        setupDatePicker()
        self.hideKeyBoardWhenTappedAround()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgPicker(_:)))
        imgAdd.addGestureRecognizer(tapGesture)
        imgAdd.isUserInteractionEnabled = true
    }
    
    @objc func buttonPressed(_ sender: Any) {
        if let data = imgAdd.image?.pngData() {
            let dataStr = data.base64EncodedString(options: .lineLength64Characters)
            CoreDataManager.sharedInstance.insertTodo(Todo(id: UUID.init(), title: tfTitle.text ?? "", image: dataStr, createDate: (tfDate.text?.toDate())!, modifyDate: (tfDate.text?.toDate())!))
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func imgPicker(_ gesture: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: true)
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
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시된다고 합니다.
        // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시되겠죠?
        tfDate.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        tfDate.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        tfDate.resignFirstResponder()
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

extension AddTodoViewController : UIImagePickerControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 창 닫기
        print("이미지 선택하지않고 취소한 경우")
        
        self.dismiss(animated: false) { () in
            // 알림 창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("이미지 선택")
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgAdd.image = img
        }
    }
}
