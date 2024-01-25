
import XCTest
@testable import MazaadyTask

class FormVCPresenterTests: XCTestCase {

    var presenter: FormVCPresenter!
    var mockView: MockFormView!
    var mockRouter: MockFormVCRouter!
    var mockRepository: MockCategoryRepository!

    override func setUpWithError() throws {
        mockView = MockFormView()
        mockRouter = MockFormVCRouter()
        mockRepository = MockCategoryRepository()
        presenter = FormVCPresenter(view: mockView, router: mockRouter, repository: mockRepository)
    }

    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
        mockRouter = nil
        mockRepository = nil
    }

    func testGetUserSelections() {
        var category1 = Category(id: 1, name: "Category1", children: nil, selected: true)
        var subCategory1 = SubCategory(id: 11, name: "SubCategory1", options: nil, selected: true)
        let property1 = Propery(id: 111, name: "Property1", options: nil, other: true, otherValue: "OtherValue1")
        subCategory1.options = [property1]
        category1.children = [subCategory1]

        presenter.categories = [category1]

        let userSelections = presenter.getUserSelections()

        XCTAssertEqual(userSelections["Main Category"] as? String, "Category1")
        XCTAssertEqual(userSelections["Sub Category"] as? String, "SubCategory1")

        let propertyInfo = userSelections["Property Property1"] as? [String: Any]
        XCTAssertEqual(propertyInfo?["Property Name"] as? String, "Property1")
        XCTAssertEqual(propertyInfo?["Other Property"] as? String, "OtherValue1")
    }

    func testSubmitBtnTapped() {
        let category = Category(id: 1, name: "Category1", children: nil, selected: true)
        presenter.categories = [category]

        presenter.submitBtnTapped()

        XCTAssertTrue(mockRouter.navToDetailsScreenCalled)

        let userSelection = presenter.getUserSelections()

        XCTAssertEqual(mockRouter.navToDetailsScreenUserSelection?["Main Category"] as? String, userSelection["Main Category"] as? String)
        XCTAssertEqual(mockRouter.navToDetailsScreenUserSelection?["Sub Category"] as? String, userSelection["Sub Category"] as? String)

    }
}
