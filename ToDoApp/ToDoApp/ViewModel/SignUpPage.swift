//
//  SignUpPage.swift
//  ToDoApp
//
//  Created by Raramuri on 16/07/24.
//

import UIKit
import FirebaseAuth

class SignUpPage: UIViewController {

    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func confirmDetails(_ sender: UIButton) {
        guard let username = usernameTextField.text
        else {
            return
        }
        guard let password = passwordTextField.text
        else {
            return
        }
        Auth.auth().createUser(withEmail: username, password: password) { firebaseResult, error in
            if error != nil{
                let alert = UIAlertController(title: "Wrong Email/Password", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.present(alert, animated: true)
            }
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "main") as? TabBarViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
}
