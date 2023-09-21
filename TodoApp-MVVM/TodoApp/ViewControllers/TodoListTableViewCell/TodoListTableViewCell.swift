//
//  TodoListTableViewCell.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    /** @brief title label */
    @IBOutlet weak var lblTitle: UILabel!
    /** @brief switch button */
    @IBOutlet weak var switchButton: UISwitch!
    
    var delegate: ViewControllerDelegate!
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { 
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func completeButtonTouched(_ sender: UISwitch) {
//        CoreDataManager.sharedInstance.getTodos()[index].isCompleted = sender.isOn
        delegate?.reloadData()
    }
}
