//
//  TabBarViewController.swift
//  ToDoApp
//
//  Created by Raramuri on 17/07/24.
//
import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewControllers = viewControllers else{
            return
        }
        for viewController in viewControllers {
            if let profileController =  viewController as? ProfileController{
                
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
