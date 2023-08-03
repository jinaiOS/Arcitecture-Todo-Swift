//
//  ViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tvMain: UITableView!
    @IBOutlet weak var vBlankList: UIView!
    
    var todoList: [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        UserDefaultsManager.sharedInstance.loadTasks()
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "TodoListTableViewCell", bundle: nil)
        tvMain.register(nibName, forCellReuseIdentifier: "TodoListTableViewCell")
        tvMain.delegate = self
        tvMain.dataSource = self
    }
    
    @IBAction func addListButtonTouched(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "AddTodo", bundle: nil)
        if let vc: AddTodoViewController = storyboard.instantiateViewController(withIdentifier: "AddTodoViewController") as? AddTodoViewController {
            // 뷰 컨트롤러를 나타냅니다.
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        // 메시지창 컨트롤러 인스턴스 생성
//        let alert = UIAlertController(title: "할 일 추가", message: "", preferredStyle: UIAlertController.Style.alert)
//        alert.addTextField() { (textField) in
//            textField.placeholder = "할 일을 입력하세요"
//        }
//
//        // 메시지 창 컨트롤러에 들어갈 버튼 액션 객체 생성
//        let cancelAction =  UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
//        let defaultAction = UIAlertAction(title: "추가", style: UIAlertAction.Style.cancel) {_ in
//            self.todoList.append(["title": alert.textFields?[0].text ?? "", "isSelcted": "0"])
//            print(self.todoList)
//            self.tvMain.reloadData()
//        }
//
//        //메시지 창 컨트롤러에 버튼 액션을 추가
//        alert.addAction(cancelAction)
//        alert.addAction(defaultAction)
//
//        //메시지 창 컨트롤러를 표시
//        self.present(alert, animated: false)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.sharedInstance.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as?
                TodoListTableViewCell else {
            return UITableViewCell()
        }
        
        if UserDefaultsManager.sharedInstance.memoList.count == 0 {
            tvMain.isHidden = true
            vBlankList.isHidden = false
        } else {
            tvMain.isHidden = false
            vBlankList.isHidden = true
        }
        
        cell.lblTitle.text = UserDefaultsManager.sharedInstance.memoList[indexPath.row].title
        
        if UserDefaultsManager.sharedInstance.memoList[indexPath.row].done == false {
            cell.switchButton.isOn = false
        } else {
            cell.switchButton.isOn = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        if let firstVC: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            // 뷰 컨트롤러를 구성 합니다.
//            firstVC.dataList.removeAll()
//            firstVC.dataList.append(UserDefaultsManager().memoList[indexPath.row].title)
//            firstVC.dataList.append(UserDefaultsManager().memoList[indexPath.row].)
//            firstVC.dataList.append(UserDefaultsManager().memoList[indexPath.row]["title"])
            // 뷰 컨트롤러를 나타냅니다.
            self.navigationController?.pushViewController(firstVC, animated: true)
        }
    }
}

