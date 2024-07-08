//
//  ViewController.swift
//  Update Details
//
//  Created by Raramuri on 05/07/24.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var updateContactTapped: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func did(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "second") as? UpdateController
        vc?.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewer.backgroundColor = .gray
        let radius: CGFloat = 200 / 2
        imageViewer.layer.cornerRadius = radius
        imageViewer.clipsToBounds = true
    }
    
    /*@IBAction func updateContactTapped(_ sender: UIButton) {
        let updateVC = UpdateController(nibName: "UpdateController", bundle: nil)
        updateVC.delegate = self
        present(updateVC, animated: true, completion: nil)
    }*/
}
extension ViewController: ContactDetailsProtocol {
    func didUpdateContactDetails(phoneNumber: String, email: String) {
        phoneNumberLabel.text = phoneNumber
        emailLabel.text = email
    }}


