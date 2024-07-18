//
//  mainScreen.swift
//  ToDoApp
//
//  Created by Raramuri on 16/07/24.
//

import UIKit

class mainScreen: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBAction func newTask(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newTask") as? NewTaskViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var TableViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewController.dataSource = self
        TableViewController.delegate = self
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")}
    
    // Do any additional setup after loading the view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell", for: indexPath) as! TodoItemTableViewCell
        if indexPath.row == 0 {
            cell.colorLine.backgroundColor = .red
            cell.images.image = UIImage(named: "Screenshot 2024-07-16 at 2.41.45 PM")
            cell.Description.text = "Screenshot 2024-07-16 at 2.41.45 PM"
            cell.details.text = "Screenshot 2024-07-16 at 2.41.45 PM"
            cell.deadline.text = "Screenshot 2024-07-16 at 2.41.45 PM"
        } else if indexPath.row == 1 {
            cell.colorLine.backgroundColor = .orange
            cell.images.image = UIImage(named: "Screenshot 2024-07-16 at 2.41.45 PM")
            
        } else {
            cell.colorLine.backgroundColor = .blue
            cell.images.image = UIImage(named: "Screenshot 2024-07-16 at 2.41.45 PM")
        }
        
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


