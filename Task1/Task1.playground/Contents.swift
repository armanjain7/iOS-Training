import UIKit
import Foundation
//This section regards for task1(creating enumeration and structure)
enum UserType {
    case Regular
    case Premium
}
struct User {
    var name:String
    var id:Int
    var type:UserType
}
// This section regards for task2(creating user object)
var users = [User]()
users.append(User(name: "Arman",id: 1, type: .Premium))
users.append(User(name: "Ayush",id: 2, type: .Regular))
users.append(User(name: "Vaishali",id: 5, type: .Premium))
users.append(User(name: "Ahasas",id: 3, type: .Regular))
users.append(User(name: "Anushka",id: 7, type: .Premium))
//This section regards for task3(filtering out users with regular membership)
let regularUsers = users.filter{$0.type == .Regular}
//This section regards for task4(counting the number of Regular users)
let countRegular = regularUsers.count
//This section regards for task5(use of for loop and switch for printing user type)
users.forEach{ user in
    switch user.type{
    case .Regular:
        print("\(user.name) is a Regular user")
    case .Premium:
        print("\(user.name) is a Premium user")
    }
}
//This section regards for task6(printing names of users)
let name:[String] = users.compactMap{$0.name}
print(name)
//This section regards for task7(printing users sorted by their name)
let sort = users.sorted{ $0.name<$1.name }
for i in sort{
    print("Name of User: \(i.name) \nId: \(i.id) \nType: \(i.type)")
}

