//
//  ViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit
import UserNotifications

protocol ViewControllerDelegate {
    func reloadData()
}

class ViewController: UIViewController, ViewControllerDelegate {
    
    /** @brief tableview todo list */
    @IBOutlet weak var tvMain: UITableView!
    /** @brief blank view */
    @IBOutlet weak var vBlankList: UIView!
    
    // 투두리스트 중 기간이 지나지 않은 리스트
    var viewModel = ViewModel()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib() // 테이블 뷰 쎌 등록
        
        userNotificationCenter.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getNotCompletedTodoList()
        tvMain.reloadData()
    }
    
    // 사용자에게 알림 권한 요청
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    // 알림 전송
    func sendNotification(year: Int, month: Int, day: Int, title: String?, body: String?) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = title ?? ""
        notificationContent.body = body ?? ""
        
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func reloadData() {
        tvMain.reloadData()
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
    }
    
    // 수정 버튼 클릭 시
    @IBAction func editButtonTouched(_ sender: UIBarItem) {
        if self.tvMain.isEditing {
            sender.title = "Edit"
            tvMain.setEditing(false, animated: true)
        } else {
            sender.title = "Done"
            tvMain.setEditing(true, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as?
                TodoListTableViewCell else {
            return UITableViewCell()
        }
                
        if viewModel.todoList.count == 0 {
            // 투두리스트 개수가 0개일 때
            tvMain.isHidden = true
            vBlankList.isHidden = false
        } else {
            tvMain.isHidden = false
            vBlankList.isHidden = true
        }
        
        cell.switchButton.isOn = viewModel.todoList[indexPath.row].isCompleted
        
        cell.lblTitle.text = viewModel.todoList[indexPath.row].title // 제목 설정
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        if let firstVC: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            // 뷰 컨트롤러를 구성 합니다.
            firstVC.dataList = viewModel.todoList[indexPath.row]
            // 뷰 컨트롤러를 나타냅니다.
            self.navigationController?.pushViewController(firstVC, animated: true)
        }
    }
    
    //Edit Mode에서 Row별 모드 지정
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Edit Mode의 +, - 버튼
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("delete")
        viewModel.deleteTodoList(index: indexPath.row)
        viewModel.getNotCompletedTodoList()
        tableView.deleteRows(at: [indexPath], with: .none)
        tableView.reloadData()
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
