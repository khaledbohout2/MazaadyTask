
import Foundation
@testable import MazaadyTask

class MockCategoryRepository: CategoryRepositoryProtocol {

    func getCategories() async -> Result<BaseModelWithData<CategoriesData>, Error> {

        let mockCategoriesData = CategoriesData(categories: [
            Category(id: 1, name: "MockCategory1", children: nil, selected: false),
            Category(id: 2, name: "MockCategory2", children: nil, selected: false),
        ])

        let jsonData = try! JSONEncoder().encode(mockCategoriesData)

        let decodedData = try! JSONDecoder().decode(BaseModelWithData<CategoriesData>.self, from: jsonData)

        return .success(decodedData)
    }

    func getProperties(subCat: Int) async -> Result<BaseModelWithData<[Propery]>, Error> {
        let mockProperties = [
            Propery(id: 101, name: "Property1", options: nil, other: false, otherValue: nil, selected: false),
            Propery(id: 102, name: "Property2", options: nil, other: false, otherValue: nil, selected: false),
        ]

        let jsonData = try! JSONEncoder().encode(mockProperties)

        let decodedData = try! JSONDecoder().decode(BaseModelWithData<[Propery]>.self, from: jsonData)

        return .success(decodedData)
    }

    func getOptionsChild(optionId: Int) async -> Result<BaseModelWithData<[ChildOption]>, Error> {
        let mockChildOptions = [
            ChildOption(id: 201, name: "ChildOption1", selected: false),
            ChildOption(id: 202, name: "ChildOption2", selected: false),
        ]

        let jsonData = try! JSONEncoder().encode(mockChildOptions)

        let decodedData = try! JSONDecoder().decode(BaseModelWithData<[ChildOption]>.self, from: jsonData)

        return .success(decodedData)
    }

}
