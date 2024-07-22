//
//  mainScreen.swift
//  ToDoApp
//
//  Created by Raramuri on 16/07/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class mainScreen: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let db = Firestore.firestore()
    var model = [Model]()
    @IBAction func presentSecondViewController(_ sender: UIButton) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "newTask") as! NewTaskViewController
        let navigationController = UINavigationController(rootViewController: secondVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    @IBOutlet weak var TableViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = logoutButton
        TableViewController.dataSource = self
        TableViewController.delegate = self
        let nib = UINib(nibName: "TodoItemTableViewCell", bundle: nil)
        TableViewController.register(nib, forCellReuseIdentifier: "TodoItemTableViewCell")
        loadData()
        
    }
    @objc func logout() {
            do {
                try Auth.auth().signOut()
                let loginVC = storyboard?.instantiateViewController(withIdentifier: "login") as! ViewController
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            } catch _ as NSError {
                let alert = UIAlertController(title: "Error", message:  nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    
    func loadData(){
        db.collection("data").order(by: "time").addSnapshotListener({(QuerySnapshot,error) in
            self.model = []
            if((error) != nil){
                let alert = UIAlertController(title: "Data not saved", message:  "\(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                self.present(alert, animated: true)
            }else{
                if let docs = QuerySnapshot?.documents {
                    for doc in docs{
                        let data = doc.data()
                        
                        
                        if let heading = data["heading"] as? String, let details = data["details"] as? String, let date = data["date"] as? String, let priority = data["priority"] as? Int, let email = data["email"] as? String{
                            let time = data["time"]  as? Int
                            let id = data["id"] as? String
                            let isDone = data["isDone"] as? Bool
                                if(Auth.auth().currentUser?.email == email ){
                                    let item = Model(heading: heading, details: details, deadline: date, priority: priority, email: email, time: time ?? 0, id: id ?? "" , isDone: isDone ?? false)
                                    
                                    self.model.append(item)
                                    
                                }
                                
                                DispatchQueue.main.async {
                                    self.TableViewController.reloadData()
                                }
                            }
                        }
                    }
                }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC") as? ShowTaskViewController
        
        let task = model[indexPath.row]
        
        vc?.taskHeading = task.heading
        vc?.taskDescription = task.details
        vc?.taskDeadline = task.deadline
        vc?.taskPriority = task.priority
        vc?.docId = task.id
        
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell", for: indexPath) as! TodoItemTableViewCell
        
        switch model[indexPath.row].priority {
            
        case 0 :
            cell.colorLine.backgroundColor = .systemBlue
            
        case 1:
            cell.colorLine.backgroundColor = .systemYellow
            
        case 2:
            cell.colorLine.backgroundColor = .systemRed
            
        default:
            cell.colorLine.backgroundColor = .systemBlue
            
        }
        
        cell.Description.text = model[indexPath.row].heading
        cell.details.text = model[indexPath.row].details
        cell.deadline.text = model[indexPath.row].deadline
        cell.button.setImage(UIImage(named: "UnChecked"), for: .normal)
        cell.button.setImage(UIImage(named: "Checked"), for: .selected)
        if(model[indexPath.row].isDone == true) {
            cell.button.isSelected = true
        } else {
            cell.button.isSelected = false
            
        }
        
        cell.docId = model[indexPath.row].id
        cell.isDone = model[indexPath.row].isDone
        cell.priority = model[indexPath.row].priority
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = model[indexPath.row]
            let docId = task.id
            db.collection("data").document(docId).delete { error in
                if let error = error {
                    let alert = UIAlertController(title: "Error removing task", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                    self.present(alert, animated: true)
                } else {
                    DispatchQueue.main.async {
                        self.TableViewController.reloadData()
                    }
                    
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
    extension mainScreen: DeleteTodoItemFromTable{
        func editCell(_ cell: TodoItemTableViewCell) {
            var stringPriority: String
            
            switch cell.priority{
            case 2:
                stringPriority = "High"
            case 1:
                stringPriority = "Medium"
            case 0:
                stringPriority = "Low"
            default:
                stringPriority = "Unspecified"
            }
            let vc = storyboard?.instantiateViewController(withIdentifier: "newTask") as? NewTaskViewController
            vc?.descriptionText = cell.details.text
            vc?.deadlineText = cell.deadline.text
            vc?.headingText = cell.Description.text
            vc?.priorityText = stringPriority
            vc?.cameFromShow = 1
            vc?.docId = cell.docId
            
            let navigationController = UINavigationController(rootViewController: vc!)
            self.present(navigationController, animated: true, completion: nil)
        }
        
        func taskCompleted(_ cell: TodoItemTableViewCell) {
            guard let docId = cell.docId , let isDone = cell.isDone else { return }
            db.collection("data").document(docId).updateData([
                "isDone": !isDone ]
            ) { error in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                    self.present(alert, animated: true)
                } else {
                    DispatchQueue.main.async {
                        self.loadData()
                        self.TableViewController.reloadData()
                    }
                }
            }
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
