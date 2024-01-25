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
        mainView.submitButton.addTarget { [weak self] in
            guard let self = self else {return}
            self.presenter.submitBtnTapped()
        }
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

    func didSelectOption(mainCatId: Int, subCatId: Int, propertyId: Int, optionId: Int?, other: Bool?, otherValue: String?) {
        presenter.didSelectOption(mainCatId: mainCatId, subCatId: subCatId, propertyId: propertyId, optionId: optionId, other: other, otherValue: otherValue)
    }

    func didSelectOptionChild(mainCatId: Int, subCatId: Int, propertyId: Int, optionId: Int, childPropertyId: Int) {
        presenter.didSelectChildOption(mainCatId: mainCatId, subCatId: subCatId, propertyId: propertyId, optionId: optionId, childPropertyId: childPropertyId)
    }

}
