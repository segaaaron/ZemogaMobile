//
//  PostViewController.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor
        navigationItem.title = "Posts"

        navigationController?.navigationBar.backgroundColor = UIColor.greenColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.whiteColor]
    }
}
