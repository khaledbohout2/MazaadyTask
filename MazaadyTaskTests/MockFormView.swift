
import XCTest
@testable import MazaadyTask

class MockFormView: BaseVC<FormView>, FormVCProtocol {
    var presenter: MazaadyTask.FormVCPresenterProtocol!

    var updateUICalled = false
    var capturedCategories: [MazaadyTask.Category]?

    func updateUI(with categories: [MazaadyTask.Category]) {
        updateUICalled = true
        capturedCategories = categories
    }

}

