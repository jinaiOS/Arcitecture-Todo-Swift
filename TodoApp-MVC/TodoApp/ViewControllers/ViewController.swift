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
    var memoList = CoreDataManager.sharedInstance.readCoreData()
    var memoListData : Array<[MemoListModel]> = [[]]
    let sectionHeader = ["사과", "배", "포도", "망고", "딸기", "바나나", "파인애플"]
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoList = memoList.filter({ $0.category != "" })

        memoListData.remove(at: 0)
        memoListData.append(memoList.filter({ i in i.category == "사과" }))
        memoListData.append(memoList.filter({ i in i.category == "배" }))
        memoListData.append(memoList.filter({ i in i.category == "포도" }))
        memoListData.append(memoList.filter({ i in i.category == "망고" }))
        memoListData.append(memoList.filter({ i in i.category == "딸기" }))
        memoListData.append(memoList.filter({ i in i.category == "바나나" }))
        memoListData.append(memoList.filter({ i in i.category == "파인애플" }))
        memoListData = memoListData.filter({ !$0.isEmpty })
        
        registerXib() // 테이블 뷰 쎌 등록
        
        userNotificationCenter.delegate = self
        
//        requestNotificationAuthorization()
//        for i in todoList.filter { $0.done == false } {
//            if i.done == false {
//                
//            }
//        }
//        sendNotification(year: <#T##Int#>, month: <#T##Int#>, day: <#T##Int#>, title: <#T##String?#>, body: <#T##String?#>)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaultsManager.sharedInstance.loadTasks()
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
        return memoListData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as?
                TodoListTableViewCell else {
            return UITableViewCell()
        }
        
        let todoList = memoListData[indexPath.section]
        
        if todoList.count == 0 {
            // 투두리스트 개수가 0개일 때
            tvMain.isHidden = true
            vBlankList.isHidden = false
        } else {
            tvMain.isHidden = false
            vBlankList.isHidden = true
        }
        
        cell.switchButton.isOn = false
        
        cell.lblTitle.text = todoList[indexPath.row].title // 제목 설정
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        if let firstVC: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            // 뷰 컨트롤러를 구성 합니다.
            firstVC.dataList.removeAll()
            firstVC.dataList.append(UserDefaultsManager.sharedInstance.memoList.filter { $0.done == false }[indexPath.row].title)
            firstVC.dataList.append(UserDefaultsManager.sharedInstance.memoList.filter { $0.done == false }[indexPath.row].date)
            firstVC.dataList.append(UserDefaultsManager.sharedInstance.memoList.filter { $0.done == false }[indexPath.row].content)
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
        UserDefaultsManager.sharedInstance.trashList.append( UserDefaultsManager.sharedInstance.memoList.filter { $0.done == false }[indexPath.row])
//        UserDefaultsManager.sharedInstance.memoList.filter { $0.done == false }.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoListData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "end"
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
