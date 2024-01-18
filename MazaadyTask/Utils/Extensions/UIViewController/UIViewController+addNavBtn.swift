//
//  UIViewController+addNavBtn.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

extension UIViewController {
    func addNavButtons() -> [UIButton] {
        let firstBtn = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold, scale: .large)
        firstBtn.setImage(UIImage(systemName: "arrow.forward", withConfiguration: largeConfig), for: .normal)
        firstBtn.tintColor = .appMainColor
        firstBtn.frame = CGRectMake(0, 0, 40, 40)
        let prev = UIBarButtonItem(customView: firstBtn)

        let secBtn = UIButton(type: .system)
        secBtn.setImage(UIImage(systemName: "arrow.backward", withConfiguration: largeConfig), for: .normal)
        secBtn.tintColor = .appMainColor
        secBtn.frame = CGRectMake(0, 0, 40, 40)
        let nextBtn = UIBarButtonItem(customView: secBtn)

        var topParent: UIViewController = self
        while topParent.parent != nil,
              String(describing: type(of: topParent.parent!.self))
                != String(describing: UINavigationController.self) {
            topParent = topParent.parent!
        }
        let rightBarButtonItems = [prev, nextBtn]
        topParent.navigationItem.rightBarButtonItems = rightBarButtonItems
        return [firstBtn, secBtn]
    }
}
