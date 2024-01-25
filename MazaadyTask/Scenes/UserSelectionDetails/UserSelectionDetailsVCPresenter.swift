//
//  UserSelectionDetailsVCPresenter.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 23/01/2024.
//

import Foundation

protocol UserSelectionDetailsVCPresenterProtocol: BasePresenterProtocol {
    func getNumberOfRows() -> Int
    func getText(for row: Int) -> String
}

class UserSelectionDetailsVCPresenter: UserSelectionDetailsVCPresenterProtocol {
    private weak var view: UserSelectionDetailsVCProtocol?
    private let router: UserSelectionDetailsVCRouter
    private var userSelection: [String: Any]

    var keysArr = Array<Any>()

    init(view: UserSelectionDetailsVCProtocol,
         router: UserSelectionDetailsVCRouter,
         userSelection: [String: Any]) {
        self.view = view
        self.router = router
        self.userSelection = userSelection
    }

    func viewDidLoad() {
        self.keysArr = Array(userSelection.keys)
        view?.updateUI()
    }

    func getNumberOfRows() -> Int {
        return keysArr.count
    }

    func getText(for row: Int) -> String {
        guard let key = keysArr[row] as? String else {
            return ""
        }

        if let value = userSelection[key] {
            return "\(key) : \(value)"
        } else {
            return "\(key) : N/A"
        }
    }
}
