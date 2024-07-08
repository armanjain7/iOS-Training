//
//  UpdateController.swift
//  Update Details
//
//  Created by Raramuri on 05/07/24.
//

import UIKit
protocol ContactDetailsProtocol: AnyObject {
    func didUpdateContactDetails(phoneNumber: String, email: String)
}
class UpdateController: UIViewController {
    
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var saveButton: UIButton!
        weak var delegate: ContactDetailsProtocol?
    @IBAction func saveButton(_ sender: UIButton) {
        let phoneNumber = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        delegate?.didUpdateContactDetails(phoneNumber: phoneNumber, email: email)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
