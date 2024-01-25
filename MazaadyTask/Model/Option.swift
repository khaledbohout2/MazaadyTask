//
//  Option.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 23/01/2024.
//

import Foundation

struct Option: Codable {
    let id: Int
    let name: String
    var options: [ChildOption]?
    var selected: Bool?
}

struct ChildOption: Codable {
    let id: Int
    let name: String
    var selected: Bool?
}
