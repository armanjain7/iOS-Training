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
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }
    func setupActivityIndicator() {
            activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.center = view.center
                activityIndicator.hidesWhenStopped = true
                view.addSubview(activityIndicator)
            }
    @IBAction func signIn(_ sender: Any) {
        guard let username = Username.text else {
            return
        }
        guard let password = Password.text else {
            return
        }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: username, password: password) { firebaseResult, error in
            if error != nil {
                let alert = UIAlertController(title: "Wrong Email/Password", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.activityIndicator.stopAnimating()
                self.present(alert, animated: true)
            }
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "main") as? TabBarViewController
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
        
    @IBAction func signUp(_ sender: Any) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "second") as? SignUpPage
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    @IBAction func forgotPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email address", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let reset = UIAlertAction(title: "Reset", style: .default) { [weak self] (_) in
            guard let email = alert.textFields?.first?.text, !email.isEmpty else {
                let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(errorAlert, animated: true, completion: nil)
                return
            }
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(errorAlert, animated: true, completion: nil)
                } else {
                    let successAlert = UIAlertController(title: "Success", message: "Password reset email sent!", preferredStyle: .alert)
                    successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(successAlert, animated: true, completion: nil)
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(reset)
        self.present(alert, animated: true, completion: nil)
    }
}

