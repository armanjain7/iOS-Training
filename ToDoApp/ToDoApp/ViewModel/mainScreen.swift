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
    @IBAction func newTask(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newTask") as? NewTaskViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var TableViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewController.dataSource = self
        TableViewController.delegate = self
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
        loadData()
        
    }
    
    func loadData(){
        db.collection("data").order(by: "time").addSnapshotListener({(QuerySnapshot,error) in
                    self.model = []
                    if((error) != nil){
                        print(error!)
                        print("no")
                    }else{
                        if let docs = QuerySnapshot?.documents {
                            for doc in docs{
                                let data = doc.data()
                               
                                
                               if let heading = data["heading"] as? String, let details = data["details"] as? String, let date = data["date"] as? String, let priority = data["priority"] as? Int, let email = data["email"] as? String {
                                   let time = data["time"]  as? Int
                                   
                                   
                                   if(Auth.auth().currentUser?.email == email ){
                                       let item = Model(heading: heading, details: details, deadline: date, priority: priority, email: email, time: time ?? 0)
                                       
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
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell", for: indexPath) as! TodoItemTableViewCell
            
                switch model[indexPath.row].priority {
                    
                case 0 :
                    cell.colorLine.backgroundColor = .blue
                    
                case 1:
                    cell.colorLine.backgroundColor = .yellow

                case 2:
                    cell.colorLine.backgroundColor = .red

                default:
                    cell.colorLine.backgroundColor = .blue

                }

                cell.Description.text = model[indexPath.row].heading
                cell.details.text = model[indexPath.row].details
                cell.deadline.text = (model[indexPath.row].deadline)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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


