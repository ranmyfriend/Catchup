//
//  SwiftUI_MVVMTests.swift
//  SwiftUI-MVVMTests
//
//  Created by BKS-GGS on 28/09/21.
//

import XCTest
@testable import SwiftUI_MVVM

class MockDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        completion([User(id: 1, name: "Mock")])
    }
}

class SwiftUI_MVVMTests: XCTestCase {
    
    var sot: UsersView.ViewModel!

    override func setUpWithError() throws {
        sot = UsersView.ViewModel(dataService: MockDataService())
    }

    override func tearDownWithError() throws {
        sot = nil
    }
    
    func test_getUsers() throws {
        XCTAssertTrue(sot.users.isEmpty)
        
        sot.getUsers()
        
        XCTAssertEqual(sot.users.count, 1)
    }

}
