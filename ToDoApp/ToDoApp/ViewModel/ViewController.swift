//
//  ViewController.swift
//  ToDoApp
//
//  Created by Raramuri on 16/07/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signIn(_ sender: Any) {
        guard let username = Username.text else {
            return
        }
        guard let password = Password.text else {
            return
        }
        Auth.auth().signIn(withEmail: username, password: password) { firebaseResult, error in
            if error != nil {
                let alert = UIAlertController(title: "Wrong Email/Password", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.present(alert, animated: true)
            }
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainscreen") as? mainScreen
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }}
        
    @IBAction func signUp(_ sender: Any) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "second") as? SignUpPage
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    
}

