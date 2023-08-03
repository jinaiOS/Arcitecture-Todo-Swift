//
//  DetailViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    var dataList: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = dataList[0]
        lblDate.text = dataList[1]
        lblContent.text = dataList[2]
    }

}
