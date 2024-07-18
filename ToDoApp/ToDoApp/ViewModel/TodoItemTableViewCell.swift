//
//  TodoItemTableViewCell.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var colorLine: UIView!
    
    @IBOutlet var images: UIImageView!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var Description: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.images.layer.cornerRadius = images.frame.size.width / 2
        images.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func commonInit(_ Deadline: String, _ Details: String, _ description: String,_ image: String){
        deadline.text = Deadline
        details.text = Details
        Description.text = description
        images.image = UIImage(named: image)
        
    }
    
}
