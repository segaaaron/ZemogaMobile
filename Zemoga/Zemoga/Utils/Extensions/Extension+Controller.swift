//
//  Extension+Controller.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/6/22.
//

import UIKit

extension UIViewController {

    func showAlertView(title: String = "", message: String) {
        let alertView = UIAlertController(title: title,
                                         message: message,
                                         preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))

        self.present(alertView, animated: true)
    }
}

