//
//  UIViewController+showAlert.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

extension UIViewController {
    func showErrorAlert(title: String? = "",
                        message: String?,
                        selfDismissing: Bool = true,
                        time: TimeInterval = 2.5) {

        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        let attributedString = NSAttributedString(string: message ?? "", attributes: [
            NSAttributedString.Key.font: UIFont.poppins(.regular, size: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")

        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.red

        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }

        present(alert, animated: true)

        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
                timer.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }

    func showAlert(title: String? = "",
                   message: String?,
                   selfDismissing: Bool = true,
                   time: TimeInterval = 3.0) {

        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        let attributedString = NSAttributedString(string: message ?? "", attributes: [
            NSAttributedString.Key.font: UIFont.poppins(.regular, size: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")

        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.appMainColor

        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }

        present(alert, animated: true)

        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
                timer.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
}
