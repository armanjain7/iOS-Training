//
//  Model.swift
//  ToDoApp
//
//  Created by Raramuri on 19/07/24.
//

import Foundation
struct Model{
    var heading: String
    var details: String
    var deadline: String
    var priority: Int
    var email: String
    var time: Int
    
    init(heading: String, details: String, deadline: String, priority: Int, email: String, time: Int) {
        self.heading = heading
        self.details = details
        self.deadline = deadline
        self.priority = priority
        self.email = email
        self.time = time
    }
    
}
