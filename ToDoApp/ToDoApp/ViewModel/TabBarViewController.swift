//
//  TabBarViewController.swift
//  ToDoApp
//
//  Created by Raramuri on 17/07/24.
//
import Foundation
import UIKit
import FirebaseAuth
class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let gearImage = UIImage(systemName: "gearshape")
        let gear = UIBarButtonItem(image: gearImage, style: .plain, target: self, action: nil)
        let filterImage = UIImage(systemName: "line.3.horizontal.decrease")
        let filter = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: nil)
        gear.tintColor = UIColor.black
        filter.tintColor = UIColor.black
        navigationItem.rightBarButtonItems = [gear,filter]
        let filtering = UIAction(title: "Filter(Coming Soon)") { _ in
        }
        let menu1 = UIMenu(title: "", children: [filtering])
        filter.menu = menu1
        let logout = UIAction(title: "Logout") { _ in
                let confirm = UIAlertController(title: "Are you sure, You want to log out?", message: nil, preferredStyle: .alert)
                confirm.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
                    _ in
                    do {
                        try Auth.auth().signOut()
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as! ViewController
                        let navigationController = UINavigationController(rootViewController: loginVC)
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)}
                    catch _ as NSError {
                        let alert = UIAlertController(title: "Error", message:  nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                        self.present(alert, animated: true)
                    }
                }))
                confirm.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(confirm,animated: true)
            }
            let themes = UIAction(title: "Themes (Coming Soon)") { _ in
                
            }
            let menu = UIMenu(title: "", children: [logout,themes])
            gear.menu = menu
        navigationItem.rightBarButtonItems = [gear,filter]
        }
    }

