//
//  UserSelectionDetailsVC.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 23/01/2024.
//

import UIKit

protocol UserSelectionDetailsVCProtocol: BaseViewProtocol {
    var presenter: UserSelectionDetailsVCPresenterProtocol! { get set }
    func updateUI()
}

class UserSelectionDetailsVC: BaseVC<UserSelectionDetailsView>,  UserSelectionDetailsVCProtocol{
    var presenter: UserSelectionDetailsVCPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        mainView.setDetegates(self)
    }

    func updateUI() {
        mainView.tableView.reloadData()
    }
}

extension UserSelectionDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = presenter.getText(for: indexPath.row)
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }

}
