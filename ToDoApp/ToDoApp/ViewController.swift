//
//  ViewController.swift
//  ToDoApp
//
//  Created by Raramuri on 16/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signIn(_ sender: Any) {
    }
    
    @IBAction func signUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "second") as? SignUpPage
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

