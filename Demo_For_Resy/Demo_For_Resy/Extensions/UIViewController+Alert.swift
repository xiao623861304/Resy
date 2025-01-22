//
//  UIViewController+Alert.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/15/25.
//

import UIKit

extension UIViewController {
    func presentSimpleAlert(title: String = "", message: String = "") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
