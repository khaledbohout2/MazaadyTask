//
//  UserSelectionDetailsView.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 23/01/2024.
//

import UIKit

class UserSelectionDetailsView: BaseView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = .white
        addSubview(tableView)
        tableView.fillSuperview()
    }

    func setDetegates(_ delegate: Any) {
        tableView.delegate = delegate as? UITableViewDelegate
        tableView.dataSource = delegate as? UITableViewDataSource
    }
}
