//
//  ShowTaskViewController.swift
//  ToDoApp
//
//  Created by Raramuri on 20/07/24.
//

import UIKit

class ShowTaskViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var priority = 0
    var isDone: Bool?
    var taskHeading: String?
    var taskDescription: String?
    var taskDeadline: String?
    var taskPriority: Int?
    var docId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = taskHeading
        descriptionLabel.text = taskDescription
        dateLabel.text = taskDeadline
        if let priority = taskPriority {
            switch priority {
            case 2:
                priorityLabel.text = "High"
            case 1:
                priorityLabel.text = "Medium"
            case 0:
                priorityLabel.text = "Low"
            default:
                priorityLabel.text = "Unspecified"
            }
            
           
        }
    }
    @IBAction func editTask(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newTask") as? NewTaskViewController

        
        vc?.descriptionText = descriptionLabel.text
        vc?.deadlineText = dateLabel.text
        vc?.headingText = titleLabel.text
        vc?.priorityText = priorityLabel.text
        vc?.cameFromShow = 1
        vc?.docId = docId
        vc?.isDone = isDone
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
