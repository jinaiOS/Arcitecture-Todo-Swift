//
//  SideMenuViewController.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    /** @breif 스파르타 이미지 */
    @IBOutlet weak var imgSparta: UIImageView!
    
    let imgURL = "https://spartacodingclub.kr/css/images/scc-og.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: imgURL) {
            imgSparta.load(url: url)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgToLink(_:)))
            imgSparta.addGestureRecognizer(tapGesture)
            imgSparta.isUserInteractionEnabled = true
        }
    }
    
    @objc func imgToLink(_ gesture: UITapGestureRecognizer) {
        if let url = URL(string: imgURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func homeMenuTouched(_ sender: Any) {
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
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
    
    @IBAction func myMenuTouched(_ sender: Any) {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(ProfileViewController(), animated: false)
    }
    
}
