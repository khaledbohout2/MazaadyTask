//
//  Category.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import Foundation

// MARK: - DataClass
struct categoriesData: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
    let children: [SubCategory]?

    enum CodingKeys: String, CodingKey {
        case id, name, children
    }
}

// MARK: - Datum
struct SubCategory: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

// MARK: - Option
struct Option: Codable {
    let id: Int
    let name: String
}

