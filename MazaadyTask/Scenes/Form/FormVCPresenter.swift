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

    func didSelectOption(mainCatId: Int,
                         subCatId: Int,
                         propertyId: Int,
                         optionId: Int?,
                         other: Bool?,
                         otherValue: String?)

    func didSelectChildOption(mainCatId: Int,
                              subCatId: Int,
                              propertyId: Int,
                              optionId: Int,
                              childPropertyId: Int)

    func submitBtnTapped()
}

class FormVCPresenter: FormVCPresenterProtocol {

    private weak var view: FormVCProtocol?
    private var router: FormVCRouter
    private var repository: CategoryRepositoryProtocol

    var categories = [Category]()

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
                mutableSubCategory.options = subCategory.options?.map { property in
                    var mutableProperty = property
                    mutableProperty.options = []
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
                mutableSubCategory.options = subCategory.options?.map { property in
                    var mutableProperty = property
                    mutableProperty.options = []
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }
        view?.updateUI(with: categories)
        view?.startLoading(message: "Loading")
        Task {
            let response = await repository.getProperties(subCat: subCatId)
            switch response {
            case .success(let data):
                categories = categories.map { category in
                    var mutableCategory = category
                    if mutableCategory.id == mainCatId {
                        mutableCategory.children = mutableCategory.children?.map { subCategory in
                            var mutableSubCategory = subCategory
                            if mutableSubCategory.id == subCatId {
                                mutableSubCategory.options = data.data
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

    func didSelectOption(mainCatId: Int,
                         subCatId: Int,
                         propertyId: Int,
                         optionId: Int?,
                         other: Bool?,
                         otherValue: String?) {
        categories = categories.map { category in
            var mutableCategory = category
            mutableCategory.children = category.children?.map { subCategory in
                var mutableSubCategory = subCategory
                mutableSubCategory.options = subCategory.options?.map { property in
                    var mutableProperty = property
                    if mutableProperty.id == propertyId {
                        mutableProperty.selected = true
                        mutableProperty.other = other
                        mutableProperty.otherValue = otherValue
                    }
                    mutableProperty.options = property.options?.map { option in
                        var mutableOption = option
                        mutableOption.options = option.options
                        mutableOption.selected = mutableOption.id == optionId
                        return mutableOption
                    }
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }

        if other ?? false {
            view?.updateUI(with: categories)
            return
        }
        guard let optionId = optionId else {
            view?.updateUI(with: categories)
            return
        }
        guard let category = categories.first(where: {$0.id == mainCatId}),
              let subCategory = category.children?.first(where: {$0.id == subCatId}),
              let property = subCategory.options?.first(where: {$0.id == propertyId}),
              let option = property.options?.first(where: {$0.id == optionId}),
              option.options?.isEmpty ?? true else {return}
        view?.startLoading(message: "Loading")
        Task {
            let response = await repository.getOptionsChild(optionId: optionId)
            switch response {
            case .success(let data):
                categories = categories.map { category in
                    var mutableCategory = category
                    mutableCategory.children = mutableCategory.children?.map { subCategory in
                        var mutableSubCategory = subCategory
                        mutableSubCategory.options = subCategory.options?.map { property in
                            var mutableProperty = property
                            mutableProperty.options = property.options?.map { option in
                                var mutableOption = option
                                mutableOption.options = option.options
                                mutableOption.selected = false
                                if mutableOption.id == optionId {
                                    mutableOption.selected = true
                                    mutableOption.options = data.data
                                }
                                return mutableOption
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

    func didSelectChildOption(mainCatId: Int,
                              subCatId: Int,
                              propertyId: Int,
                              optionId: Int,
                              childPropertyId: Int) {
        categories = categories.map { category in
            var mutableCategory = category
            mutableCategory.children = category.children?.map { subCategory in
                var mutableSubCategory = subCategory
                mutableSubCategory.options = subCategory.options?.map { property in
                    var mutableProperty = property
                    mutableProperty.options = property.options?.map { option in
                        var mutableOption = option
                        mutableOption.selected = (option.id == optionId)
                        mutableOption.options = option.options?.map { childOption in
                            var mutableChildOption = childOption
                            mutableChildOption.selected = (childOption.id == childPropertyId)
                            return mutableChildOption
                        }
                        return mutableOption
                    }
                    return mutableProperty
                }
                return mutableSubCategory
            }
            return mutableCategory
        }
        view?.updateUI(with: categories)
    }

    func getUserSelections() -> [String: Any] {
        var userSelections: [String: Any] = [:]

        if let selectedCategory = categories.first(where: { $0.selected == true }) {
            userSelections["Main Category"] = selectedCategory.name

            if let selectedSubCategory = selectedCategory.children?.first(where: { $0.selected == true }) {
                userSelections["Sub Category"] = selectedSubCategory.name

                if let allProperties = selectedSubCategory.options {
                    for property in allProperties {
                        var propertyInfo: [String: Any] = ["Property Name": property.name]

                        if let selectedOptions = property.options?.filter({ $0.selected == true }) {
                            propertyInfo["Selected Options"] = selectedOptions.map { option in
                                var optionInfo: [String: Any] = ["Option Name": option.name]

                                if let selectedChildOptions = option.options?.filter({ $0.selected == true }) {
                                    optionInfo["Selected Child Options"] = selectedChildOptions.map { childOption in
                                        return ["Child Option Name": childOption.name]
                                    }
                                }

                                return optionInfo
                            }
                        }

                        if let otherValue = property.otherValue, !otherValue.isEmpty {
                            propertyInfo["Other Property"] = otherValue
                        }

                        userSelections["Property \(property.name)"] = propertyInfo
                    }
                }
            }
        }

        return userSelections
    }

    func submitBtnTapped() {
        let userSelection = getUserSelections()
        router.navToDetailsScreen(from: view, userSelection: userSelection)
    }

}
