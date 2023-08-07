//
//  TrashListViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/07.
//

import UIKit

class TrashListViewController: UIViewController {
    
    @IBOutlet weak var tvMain: UITableView!
    
    // Create left UIBarButtonItem.
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(leftButtonPressed(_:)))
        button.tag = 1
        
        return button
    }()
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightButtonPressed(_:)))
        button.tag = 2
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.rightBarButtonItem = self.rightButton
        registerXib()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaultsManager.sharedInstance.loadTrashTasks()
        tvMain.reloadData()
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "TodoListTableViewCell", bundle: nil)
        tvMain.register(nibName, forCellReuseIdentifier: "TodoListTableViewCell")
        tvMain.delegate = self
        tvMain.dataSource = self
    }
    
    @objc func leftButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "CustomSideMenuNavigation") as? CustomSideMenuNavigation {
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func rightButtonPressed(_ sender: Any) {
        //        UserDefaultsManager.sharedInstance.memoList.append(MemoListModel(title: tfTitle.text ?? "", date: tfDate.text ?? "", content: textVContent.text ?? ""))
        //        self.navigationController?.popViewController(animated: true)
    }
}

extension TrashListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.sharedInstance.trashList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as?
                TodoListTableViewCell else {
            return UITableViewCell()
        }
        
        //        if UserDefaultsManager.sharedInstance.memoList.count == 0 {
        //            tvMain.isHidden = true
        //            vBlankList.isHidden = false
        //        } else {
        //            tvMain.isHidden = false
        //            vBlankList.isHidden = true
        //        }
        
        cell.lblTitle.text = UserDefaultsManager.sharedInstance.trashList[indexPath.row].title
        
        if UserDefaultsManager.sharedInstance.trashList[indexPath.row].done == false {
            cell.switchButton.isOn = false
        } else {
            cell.switchButton.isOn = true
        }
        
        return cell
    }
    
    
}
