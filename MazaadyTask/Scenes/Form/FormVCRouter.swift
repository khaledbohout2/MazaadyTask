//
//  FormVCRouter.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

class FormVCRouter {
    class func create() -> UIViewController {
        let view = FormVC()
        let router = FormVCRouter()
        let repository = CategoryRepository(APIClient: ApiClient())
        let presenter = FormVCPresenter(view: view, router: router, repository: repository)
        view.presenter = presenter
        return view
    }
}
