//
//  TodoCompleteViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class TodoCompleteViewController: UIViewController {

    /** @brief complete main tableview */
    @IBOutlet weak var tvMain: UITableView!
    
    let viewModel = TodoCompleteViewModel()
    
    // Create left UIBarButtonItem.
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(leftButtonPressed(_:)))
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.title = "Complete"
        registerXib()
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
    
}
extension TodoCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.completeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as?
                TodoListTableViewCell else {
            return UITableViewCell()
        }
        
//        if completeData.count == 0 {
//            tvMain.isHidden = true
//            vBlankList.isHidden = false
//        } else {
//            tvMain.isHidden = false
//            vBlankList.isHidden = true
//        }
        cell.switchButton.isOn = true
        
        cell.lblTitle.text = viewModel.completeData[indexPath.row].title
//        cell.delegate = self
        return cell
    }
    
    
}
