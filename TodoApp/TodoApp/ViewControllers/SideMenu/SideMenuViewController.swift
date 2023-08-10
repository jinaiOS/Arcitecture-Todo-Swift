//
//  SideMenuViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func homeMenuTouched(_ sender: Any) {
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewCovntroller") as? ViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func completeMenuTouched(_ sender: Any) {
        guard let rootVC = UIStoryboard.init(name: "TodoComplete", bundle: nil).instantiateViewController(withIdentifier: "TodoCompleteViewController") as? TodoCompleteViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func trashMenuTouched(_ sender: Any) {
        guard let rootVC = UIStoryboard.init(name: "TrashList", bundle: nil).instantiateViewController(withIdentifier: "TrashListViewController") as? TrashListViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
