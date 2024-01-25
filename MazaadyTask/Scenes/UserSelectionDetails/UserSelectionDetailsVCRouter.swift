//
//  UserSelectionDetailsVCRouter.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 23/01/2024.
//

import UIKit

class UserSelectionDetailsVCRouter {
    class func create(userSelection: [String: Any]) -> UIViewController {
        let view = UserSelectionDetailsVC()
        let router = UserSelectionDetailsVCRouter()
        let presenter = UserSelectionDetailsVCPresenter(view: view,
                                                        router: router,
                                                        userSelection: userSelection)
        view.presenter = presenter
        return view
    }
}
