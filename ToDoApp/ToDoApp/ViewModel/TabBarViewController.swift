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
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
        }
    @objc func logout() {
        let confirm = UIAlertController(title: "Are you sure, You want to log out?", message: nil, preferredStyle: .alert)
        confirm.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
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
        confirm.addAction(UIAlertAction(title: "No", style: .default	, handler: nil))
        self.present(confirm,animated: true)
    }
        // Do any additional setup after loading the view.
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

