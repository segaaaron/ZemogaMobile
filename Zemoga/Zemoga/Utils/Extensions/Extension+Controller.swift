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

    func showAlertSetting(title: String, message: String,
                          actionCancel: @escaping ((_ cancel: UIAlertAction) -> Void),
                          actionAccept: @escaping ((_ accept: UIAlertAction) -> Void)) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)

        alertView.addAction(UIAlertAction(title: "Cancel",
                                          style: .cancel,
                                          handler: { action in
            actionCancel(action)
        }))


        alertView.addAction(UIAlertAction(title: "Setting",
                                          style: .default,
                                          handler: { action in
            actionAccept(action)
        }))

        self.present(alertView, animated: false)
    }
}

