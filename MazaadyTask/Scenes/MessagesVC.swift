//
//  MessagesVC.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 26/01/2024.
//

import UIKit

class MessagesVC: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(named: "message")
        tabBarItem.title = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}

