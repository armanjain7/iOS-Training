//
//  ViewController.swift
//  Update Details
//
//  Created by Raramuri on 05/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewer: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewer.backgroundColor = .gray
        let radius: CGFloat = 200 / 2
        imageViewer.layer.cornerRadius = radius
        imageViewer.clipsToBounds = true
    }


}

