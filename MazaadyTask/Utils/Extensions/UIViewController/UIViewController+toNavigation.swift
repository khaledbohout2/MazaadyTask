//
//  UIViewController+toNavigation.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

extension UIViewController {
    func toNavigation() -> UINavigationController {
        let nav =  UINavigationController(rootViewController: self)
        return nav
    }
}
