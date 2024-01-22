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
    var children: [Category]?
    var options: [Category]?
    var selected: Bool?
    var parentID: Int?
    var other: Bool?
    var otherValue: String?
}

