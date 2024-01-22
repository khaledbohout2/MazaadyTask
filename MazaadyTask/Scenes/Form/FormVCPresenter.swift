//
//  FormVCPresenter.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import Foundation

protocol FormVCPresenterProtocol: BasePresenterProtocol {
    func didSelectMainCategory(mainCatId: Int)
    func didSelectSubCategory(mainCatId: Int, subCatId: Int)
    func didSelectProperty(mainCatId: Int, subCatId: Int, propertyId: Int?, other: Bool?)
    func didSelectChildProperty(mainCatId: Int, subCatId: Int, propertyId: Int, childPropertyId: Int)
}

class FormVCPresenter: FormVCPresenterProtocol {

    private weak var view: FormVCProtocol?
    private var router: FormVCRouter
    private var repository: CategoryRepositoryProtocol

    private var categories = [Category]()

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
        view?.startLoading(message: "Loading")
        let response = await repository.getCategories()
        switch response {
        case .success(let data):
            view?.stopLoading()
            self.categories = data.data?.categories ?? []
            view?.updateUI(with: categories)
        case .failure(let error):
            view?.stopLoading()
            view?.showSelfDismissingAlert(error.localizedDescription)
        }
    }

    func didSelectMainCategory(mainCatId: Int) {
        categories = categories.map { category in
            var mutableCategory = category
            mutableCategory.selected = category.id == mainCatId
            mutableCategory.children = category.children?.map { subCategory in
                var mutableSubCategory = subCategory
                mutableSubCategory.selected = false
                mutableSubCategory.children = subCategory.children?.map { property in
                    var mutableProperty = property
                    mutableProperty.selected = false
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }
        view?.updateUI(with: categories)
    }

    func didSelectSubCategory(mainCatId: Int, subCatId: Int) {
        categories = categories.map { category in
            var mutableCategory = category
            mutableCategory.children = category.children?.map { subCategory in
                var mutableSubCategory = subCategory
                mutableSubCategory.selected = subCategory.id == subCatId
                mutableSubCategory.children = subCategory.children?.map { property in
                    var mutableProperty = property
                    mutableProperty.selected = false
                    mutableProperty.children = [] // Clear child properties for now
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }
        view?.updateUI(with: categories)

        Task {
            view?.startLoading(message: "Loading")
            let response = await repository.getProperties(subCat: subCatId)
            switch response {
            case .success(let data):
                categories = categories.map { category in
                    var mutableCategory = category
                    if mutableCategory.id == mainCatId {
                        mutableCategory.children = mutableCategory.children?.map { subCategory in
                            var mutableSubCategory = subCategory
                            if mutableSubCategory.id == subCatId {
                                mutableSubCategory.children = data.data ?? []
                            }
                            return mutableSubCategory
                        }
                    }
                    return mutableCategory
                }
                view?.updateUI(with: categories)
                view?.stopLoading()
            case .failure(let error):
                view?.stopLoading()
                view?.showSelfDismissingAlert(error.localizedDescription)
            }
        }
    }

    func didSelectProperty(mainCatId: Int, subCatId subCatId: Int, propertyId: Int?, other: Bool?) {
        categories = categories.map { category in
            var mutableCategory = category
            mutableCategory.children = category.children?.map { subCategory in
                var mutableSubCategory = subCategory
                mutableSubCategory.children = subCategory.children?.map { property in
                    var mutableProperty = property
                    mutableProperty.selected = property.id == propertyId
                    mutableProperty.children = []
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }

        if let propertyId = propertyId, let hasChildren = categories
            .flatMap { $0.children ?? [] }
            .flatMap { $0.children ?? [] }
            .first(where: { $0.id == propertyId })?.children?.isEmpty, !hasChildren {
            Task {
                view?.startLoading(message: "Loading")
                let response = await repository.getOptionsChild(optionId: propertyId)
                switch response {
                case .success(let data):
                    categories = categories.map { category in
                        var mutableCategory = category
                        mutableCategory.children = mutableCategory.children?.map { subCategory in
                            var mutableSubCategory = subCategory
                            mutableSubCategory.children = mutableSubCategory.children?.map { property in
                                var mutableProperty = property
                                if mutableProperty.id == propertyId {
                                    mutableProperty.children = data.data ?? []
                                }
                                return mutableProperty
                            }
                            return mutableSubCategory
                        }
                        return mutableCategory
                    }
                    view?.updateUI(with: categories)
                    view?.stopLoading()
                case .failure(let error):
                    view?.stopLoading()
                    view?.showSelfDismissingAlert(error.localizedDescription)
                }
            }
        }
    }

    func didSelectChildProperty(mainCatId: Int, subCatId: Int, propertyId: Int, childPropertyId: Int) {
        categories = categories.map { category in
            var mutableCategory = category
            mutableCategory.children = category.children?.map { subCategory in
                var mutableSubCategory = subCategory
                mutableSubCategory.children = subCategory.children?.map { property in
                    var mutableProperty = property
                    mutableProperty.children = mutableProperty.children?.map { childProperty in
                        var mutableChildProperty = childProperty
                        mutableChildProperty.selected = childProperty.id == childPropertyId
                        return mutableChildProperty
                    }
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }
        view?.updateUI(with: categories)
    }

}
