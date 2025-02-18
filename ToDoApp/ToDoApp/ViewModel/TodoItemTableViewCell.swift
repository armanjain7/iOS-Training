//
//  TodoItemTableViewCell.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit
import FirebaseFirestore
import Firebase

protocol DeleteTodoItemFromTable{
    func editCell(_ cell: TodoItemTableViewCell)
    
    func taskCompleted(_ cell: TodoItemTableViewCell)
}
class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var colorLine: UIView!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var Description: UILabel!
    var docId: String?
    var isDone: Bool?
    var priority: Int?
    let db = Firestore.firestore()
    var delegate: DeleteTodoItemFromTable?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        delegate?.editCell(self)
    }
    @IBAction func alterButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.taskCompleted(self)
    }  
}
