//
//  TodoListTableViewCell.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    var indexPath: Int = 0
    var delegate: ViewControllerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { 
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func completeButton(data: MemoListModel, isOn: Bool) {
//        UserDefaultsManager.sharedInstance.memoList[indexPath].done = switchButton.isOn
//    }
    
    
    @IBAction func completeButtonTouched(_ sender: UISwitch) {
        UserDefaultsManager.sharedInstance.memoList[indexPath].done = sender.isOn
        delegate?.reloadData()
    }
}
