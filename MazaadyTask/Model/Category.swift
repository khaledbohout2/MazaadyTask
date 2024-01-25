//
//  Category.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import Foundation

// MARK: - DataClass
struct CategoriesData: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
    var children: [SubCategory]?
    var selected: Bool?
}

struct SubCategory: Codable {
    let id: Int
    let name: String
    var options: [Propery]?
    var selected: Bool?
}

