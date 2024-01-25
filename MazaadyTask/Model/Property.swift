//
//  Property.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 23/01/2024.
//

import Foundation

struct Propery: Codable {
    let id: Int
    let name: String
    var options: [Option]?
    var other: Bool?
    var otherValue: String?
    var selected: Bool?
}
