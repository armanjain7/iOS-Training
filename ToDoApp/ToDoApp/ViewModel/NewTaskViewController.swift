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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var priorityButton: UIButton!
    
    var descriptionText: String?
    var headingText: String?
    var priorityText: String?
    var deadlineText: String?
    var cameFromShow: Int?
    var docId: String?
    var taskPriority = 0
    @IBAction func save(_ sender: Any) {
        if let id = docId {
            updateData(id)
            if let navigationController = self.navigationController {
                        let viewControllers = navigationController.viewControllers
                        let numberOfViewControllers = viewControllers.count
                        
                        if numberOfViewControllers >= 3 {
                            let targetViewController = viewControllers[numberOfViewControllers - 3]
                            let viewControllerName = String(describing: type(of: targetViewController))
                            
                            if viewControllerName != "mainScreen"{
                                navigationController.popViewController(animated: true)

                            } else {
                                navigationController.popToViewController(targetViewController, animated: true)
                            }
                        } else {
                            navigationController.dismiss(animated: true)
                        }
                    }
            
        } else {
            
            if let heading = heading?.text, !heading.isEmpty, let details = details.text, !details.isEmpty, let date = date?.date, let sender = Auth.auth().currentUser?.email{
                
                let msgDate = Date().timeIntervalSince1970
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = dateFormatter.string(from: date)
                let priority = taskPriority
                let newDoc = db.collection("data").document()
                newDoc.setData(["heading": heading,
                                                         "details": details,
                                                         "priority":
                                                            priority,
                                                         "isDone": false,
                                                         "id": newDoc.documentID,
                                                         "date": dateString,
                                                         "email": sender,
                                                         "time": msgDate], completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Data not saved", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.present(alert, animated: true)
            }
            self.dismiss(animated: true)
        }}
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        if let descriptionText  {
            details.text = descriptionText
        }
        if let headingText  {
            heading.text = headingText
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        if let deadlineText, let dateInDate = dateFormatter.date(from: deadlineText) {
            date.date = dateInDate
        }
        if let priorityText {
            switch priorityText {
            case "Low":
                taskPriority = 0
                imageView.backgroundColor = .systemBlue
                priorityButton.backgroundColor = .systemBlue
                print(0)
            case "Medium":
                taskPriority = 1
                imageView.backgroundColor = .systemYellow
                priorityButton.backgroundColor = .systemYellow
                print(0)
                
                
            case "High":
                taskPriority = 2
                imageView.backgroundColor = .systemRed
                priorityButton.backgroundColor = .systemRed
                print(0)
                
                
            default:
                taskPriority = 0
                imageView.backgroundColor = .blue
                priorityButton.backgroundColor = .blue
                print(0)
            }
        }
        
        imageView.layer.cornerRadius = imageView.frame.size.width/4
        imageView.clipsToBounds = true
        
        
        
        let highPriority = UIAction(title: "High") { _ in
            self.taskPriority = 2
            self.priorityButton.backgroundColor = .red
            self.imageView.backgroundColor = .red
        }
        
        let mediumPriority = UIAction(title: "Medium") { _ in
            self.taskPriority = 1
            self.priorityButton.backgroundColor = .yellow
            
            self.imageView.backgroundColor = .yellow
            
        }
        
        let lowPriority = UIAction(title: "Low") { _ in
            self.taskPriority = 0
            self.priorityButton.backgroundColor = .blue
            self.imageView.backgroundColor = .blue
            
        }
        
        let menu = UIMenu(title: "", children: [lowPriority,mediumPriority,highPriority])
        
        priorityButton.menu = menu
        priorityButton.showsMenuAsPrimaryAction = true
        
    }
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    func updateData(_ id: String) {
        guard  let _ = heading.text else {
            let alert = UIAlertController(title: "No heading", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        let documentRef = db.collection("data").document(id)
        
        let date = date.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        documentRef.updateData(["id": id,
                                "decription": self.details.text!,
                                "heading": self.heading.text!,
                                "deadline": dateString,
                                "priority": self.taskPriority,
                                "email": Auth.auth().currentUser?.email ?? "",
                                "isDone": false,
                                "time": Date().timeIntervalSince1970]) { error in
            if let error = error {
                let alert = UIAlertController(title: "Data not saved", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.present(alert, animated: true)
            } else {
                return
            }
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
}

