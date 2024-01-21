//
//  FormVCPresenter.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import Foundation

protocol FormVCPresenterProtocol: BasePresenterProtocol {
    func didSelectSubCategory(id: Int)
    func didSelectProperty(id: Int, index: Int)
}

class FormVCPresenter: FormVCPresenterProtocol {

    private weak var view: FormVCProtocol?
    private var router: FormVCRouter
    private var repository: CategoryRepositoryProtocol

    private var categories = [Category]() {
        didSet {
            view?.updateMainCategories(categories: categories)
        }
    }
    private var properties = [Option]() {
        didSet {
            view?.updateProperties(properties: properties)
        }
    }
    private var optionsChild = [Option]()

    init(view: FormVCProtocol? = nil,
         router: FormVCRouter,
         repository: CategoryRepositoryProtocol) {
        self.view = view
        self.router = router
        self.repository = repository
    }

    func viewDidLoad() {
        Task {
            await getCategories()
        }
    }

    func getCategories() async {
        let response = await repository.getCategories()
        switch response {
        case .success(let data):
            print(data)
            self.categories = data.data?.categories ?? []
        case .failure(let error):
            view?.showSelfDismissingAlert(error.localizedDescription)
        }
    }

    func didSelectSubCategory(id: Int) {
        Task {
            let response = await repository.getProperties(subCat: id)
            switch response {
            case .success(let data):
                self.properties = data.data ?? []
            case .failure(let error):
                view?.showSelfDismissingAlert(error.localizedDescription)
            }
        }
    }

    func didSelectProperty(id: Int, index: Int) {
        Task {
            let response = await repository.getOptionsChild(optionId: id)
            switch response {
            case .success(let data):
                view?.updateOptionsChild(options: data.data ?? [], index: index)
            case .failure(let error):
                break
             //   view?.showSelfDismissingAlert(error.localizedDescription)
            }
        }
    }

}
