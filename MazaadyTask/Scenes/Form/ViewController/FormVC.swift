//
//  FormVC.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit
import DropDown

protocol FormVCProtocol: BaseViewProtocol {
    var presenter: FormVCPresenterProtocol! { get set }
    func updateUI(with categories: [Category])
}

class FormVC: BaseVC<FormView>, FormVCProtocol {

    var presenter: FormVCPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        mainView.delegate = self
    }

    func updateUI(with categories: [Category]) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.setupMainCategoriesDropdown(categories: categories)
        }
    }

}

extension FormVC: FormViewActionsProtocol {

    func didSelectMainCategory(mainCatId: Int) {
        presenter.didSelectMainCategory(mainCatId: mainCatId)
    }

    func didSelectSubCategory(mainCatId: Int, subCatId: Int) {
        presenter.didSelectSubCategory(mainCatId: mainCatId, subCatId: subCatId)
    }

    func didSelectProperty(mainCatId: Int, subCatId: Int, propertyId: Int?, other: Bool?) {
        presenter.didSelectProperty(mainCatId: mainCatId, subCatId: subCatId, propertyId: propertyId, other: other)
    }

    func didSelectOptionChild(mainCatId: Int, subCatId: Int, propertyId: Int, childPropertyId: Int) {
        presenter.didSelectChildProperty(mainCatId: mainCatId, subCatId: subCatId, propertyId: propertyId, childPropertyId: childPropertyId)
    }

}
