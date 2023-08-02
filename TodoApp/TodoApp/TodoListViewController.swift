//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var tvMain: UITableView!
    
    var todoList: [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "TodoListTableViewCell", bundle: nil)
        tvMain.register(nibName, forCellReuseIdentifier: "TodoListTableViewCell")
        tvMain.delegate = self
        tvMain.dataSource = self
    }
    
    @IBAction func addListButtonTouched(_ sender: Any) {
        // 메시지창 컨트롤러 인스턴스 생성
        let alert = UIAlertController(title: "할 일 추가", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField() { (textField) in
            textField.placeholder = "할 일을 입력하세요"
        }
        
        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
        let cancelAction =  UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
        let defaultAction = UIAlertAction(title: "추가", style: UIAlertAction.Style.cancel) {_ in
            self.todoList.append(["title": alert.textFields?[0].text ?? "", "isSelcted": "0"])
            print(self.todoList)
            self.tvMain.reloadData()
        }
        
        //메시지 창 컨트롤러에 버튼 액션을 추가
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: false)
        
    }
    
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as?
                TodoListTableViewCell else {
            return UITableViewCell()
        }
        
        if todoList.count == 0 {
            tvMain.isHidden = true
        } else {
            tvMain.isHidden = false
        }
        
        cell.lblTitle.text = todoList[indexPath.row]["title"]
        
        if todoList[indexPath.row]["isSelcted"] == "0" {
            cell.switchButton.isOn = false
        } else {
            cell.switchButton.isOn = true
        }
        
        
        return cell
    }
}
