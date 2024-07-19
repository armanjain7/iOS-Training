//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Raramuri on 18/07/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class NewTaskViewController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var heading: UITextField!
    @IBOutlet weak var details: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func save(_ sender: Any) {
        if let heading = heading?.text, !heading.isEmpty, let details = details.text, !details.isEmpty, let date = date?.date, let slider = slider?.value, let sender = Auth.auth().currentUser?.email{
            
            let msgDate = Date().timeIntervalSince1970
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            let priority = 1
            db.collection("data").addDocument(data: ["heading": heading,
                                                     "details": details,
                                                     "priority": slider,
                                                     "date": dateString,
                                                     "email": sender,
                                                     "time": msgDate], completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Data not saved", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
            self.present(alert, animated: true)
        }
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
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
