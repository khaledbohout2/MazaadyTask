//
//  MockFormVCRouter.swift
//  MazaadyTaskTests
//
//  Created by Khaled Bohout on 24/01/2024.
//

import XCTest
@testable import MazaadyTask

class MockFormVCRouter: FormVCRouter {
    var navToDetailsScreenCalled = false
    var navToDetailsScreenUserSelection: [String: Any]?

    override func navToDetailsScreen(from view: FormVCProtocol?, userSelection: [String: Any]) {
        navToDetailsScreenCalled = true
        navToDetailsScreenUserSelection = userSelection
    }
}
