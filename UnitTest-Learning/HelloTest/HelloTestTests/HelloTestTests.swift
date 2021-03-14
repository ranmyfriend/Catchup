//
//  HelloTestTests.swift
//  HelloTestTests
//
//  Created by Ranjit on 11/03/21.
//

import XCTest
@testable import HelloTest

// “Test code is just as important as production code.”

/*
 “when XCTAssertEqual or XCTAssertNil fail, they provide a fair bit of information. It’s usually enough. XCTAssertTrue and XCTAssertFalse only say they failed, but that too is often enough. We’re going to aim for tests that are so short, we won’t need to add any messages of our own.”
 
Unless you are using XCTFail give your own message.
 
 Refer: https://developer.apple.com/documentation/xctest/
 */

class HelloTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func test_fail() {
        let answer = 42
//        XCTFail("We have a problem at \(answer)")
    }
    
    func test_avoidConditionalCode() {
        let success = false
//        if !success {
//            XCTFail()
//        }
        
//        XCTAssertTrue(success)
    }
    
    func test_assertNil() {
        let two: Int? = nil
//        XCTAssertNil(two)
//        do {
//            try XCTUnwrap(two)
//        } catch(let e) {
//            XCTFail()
//        }
    }
    
    struct SimpleStruct: CustomStringConvertible {
        let x: Int
        let y: Int
        
        var description: String {
            "\(x), \(y)"
        }
    }
    
    func test_assetNil_withSimpleStruct() {
        let simpleStruct:SimpleStruct? = SimpleStruct(x: 5, y: 5)
//        XCTAssertNil(simpleStruct)
    }
    
    func test_assetEqual() {
        let msg = "actual"
//        XCTAssertEqual(msg, "expression") //XCTAssertEqual failed: ("actual") is not equal to ("expression")
//        XCTAssertEqual("expression", msg)
        
        //usually we check 5 == five, but filp the order to check five == 5, then it will make more sense to read
    }
    
    //An expression of type T, where T conforms to FloatingPoint. This parameter describes the maximum difference between expression1 and expression2 for these values to be considered equal.
    //accuracy helps us go with more or less fudge factor.
    func test_floatingPointDanger() {
        let res = 0.1 + 0.2
        XCTAssertEqual(res, 0.3, accuracy: 0.0001)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
