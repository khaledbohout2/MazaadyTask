//
//  CategoryRepositories.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 20/01/2024.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func getCategories() async -> Result<BaseModelWithData<categoriesData>, Error>
    func getProperties(subCat: Int) async -> Result<BaseModelWithData<[Category]>, Error>
    func getOptionsChild(optionId: Int) async -> Result<BaseModelWithData<[Category]>, Error>
}

class CategoryRepository: CategoryRepositoryProtocol {

    private var APIClient: ApiProtocol

    init(APIClient: ApiProtocol) {
        self.APIClient = APIClient
    }

    func getCategories() async -> Result<BaseModelWithData<categoriesData>, Error> {
        do {
            let response = try await APIClient.performRequest(endpoint: CategoryEndPoints.getCategories, responseModel: BaseModelWithData<categoriesData>.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func getProperties(subCat: Int) async -> Result<BaseModelWithData<[Category]>, Error> {
        do {
            let response = try await APIClient.performRequest(endpoint: CategoryEndPoints.getProperties(subCat: subCat), responseModel: BaseModelWithData<[Category]>.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func getOptionsChild(optionId: Int) async -> Result<BaseModelWithData<[Category]>, Error> {
        do {
            let response = try await APIClient.performRequest(endpoint: CategoryEndPoints.getOptionsChild(optionId: optionId), responseModel: BaseModelWithData<[Category]>.self)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

}
