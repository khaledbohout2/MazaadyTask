//
//  ShadowTabBarVC.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import UIKit

class ShadowTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = .appRed

        // Add Shadow
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewConts = viewControllers else { return }
        for viewCont in viewConts {
            viewCont.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            viewCont
                .tabBarItem
                .setTitleTextAttributes([NSAttributedString.Key.font: UIFont.poppins(size: 14)], for: .normal)
        }
    }
}
