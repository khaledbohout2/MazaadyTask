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
    func updateMainCategories(categories: [Category])
    func updateProperties(properties: [Option])
    func updateOptionsChild(options: [Option], index: Int)
}

class FormVC: BaseVC<FormView>, FormVCProtocol {

    var presenter: FormVCPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        mainView.delegate = self
    }

    func updateMainCategories(categories: [Category]) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.setupDropdowns(categories: categories)
        }
    }

    func updateProperties(properties: [Option]) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.setupPropertyButtons(properties: properties)
        }
    }

    func updateOptionsChild(options: [Option], index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView.updateChildPropertyDropdown(at: index, with: options)
        }
    }

}

extension FormVC: FormViewActionsProtocol {

        func didSelectSubCategory(id: Int) {
            presenter.didSelectSubCategory(id: id)
        }
        
        func didSelectProperty(index: Int, id: Int) {
            presenter.didSelectProperty(id: id, index: index)
        }
        
        func didSelectOptionChild(id: Int) {
       //     presenter.didSelectOptionChild(id: id)
        }
}
