//
//  MyClassTest.swift
//  HelloTestTests
//
//  Created by Ranjit on 13/03/21.
//

import XCTest
@testable import HelloTest

/*
 Four Phase of Test:
 
 1.The test creates an instance of MyClass.
 2.It invokes a method on the instance.
 3.It asserts an outcome.
 4.It destroys the instance.
 
 So the four phases are usually shortened to three phases and abbreviated as AAA:

 Arrange
 Act
 Assert
 
 */

class MyClassTest: XCTestCase {
    ///“The Wrong Way to Reduce Duplicate Test Code” when we create an instance of MyClass out of the test method you will different results as well. this is completely wrong. We should not follow this TestPattern. and never be deallocated of in the instance.
    //“Two instances of MyClass are created before tests are even run. And they’re never destroyed.”
    
    //let sut = MyClass() //To Solve this kind of instance creation on global, try to do this on Setup and teardown methods.
    //Because every test methods will run in different instance of MyClassTest.
    var sut: MyClass! //! Crash operator
    
    func test_zero() {
//        XCTFail()
    }
    
    func test_methodOne() {
//        let sut = MyClass()
        sut.methodOne()
    }
    
    func test_methodTwo() {
//        let sut = MyClass()
        sut.methodTwo()
    }
    
    override func setUp() {
        sut = MyClass()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

/* GLOBAL DECLARATION RESULT
 >> MyClass.init() #1
 >> MyClass.init() #2
 >> MyClass.init() #3
 >> MyClass.init() #4
 >> MyClass.init() #5
 Test Suite 'Selected tests' started at 2021-03-13 20:24:58.786
 Test Suite 'HelloTestTests.xctest' started at 2021-03-13 20:24:58.787
 Test Suite 'MyClassTest' started at 2021-03-13 20:24:58.787
 Test Case '-[HelloTestTests.MyClassTest test_methodOne]' started.
 >> methodOne
 Test Case '-[HelloTestTests.MyClassTest test_methodOne]' passed (0.003 seconds).
 Test Case '-[HelloTestTests.MyClassTest test_methodTwo]' started.
 >> methodTwo
 Test Case '-[HelloTestTests.MyClassTest test_methodTwo]' passed (0.001 seconds).
 Test Case '-[HelloTestTests.MyClassTest test_zero]' started.
 Test Case '-[HelloTestTests.MyClassTest test_zero]' passed (0.001 seconds).
 Test Case '-[HelloTestTests.MyClassTest testExample]' started.
 Test Case '-[HelloTestTests.MyClassTest testExample]' passed (0.001 seconds).
 Test Case '-[HelloTestTests.MyClassTest testPerformanceExample]' started.
 /Users/ranjit/Documents/HelloTest/HelloTestTests/MyClassTest.swift:60: Test Case '-[HelloTestTests.MyClassTest testPerformanceExample]' measured [Time, seconds] average: 0.000, relative standard deviation: 99.716%, values: [0.000222, 0.000134, 0.000184, 0.000125, 0.000021, 0.000016, 0.000013, 0.000014, 0.000012, 0.000032], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
 Test Case '-[HelloTestTests.MyClassTest testPerformanceExample]' passed (0.353 seconds).
 Test Suite 'MyClassTest' passed at 2021-03-13 20:24:59.149.
      Executed 5 tests, with 0 failures (0 unexpected) in 0.358 (0.361) seconds
 Test Suite 'HelloTestTests.xctest' passed at 2021-03-13 20:24:59.149.
      Executed 5 tests, with 0 failures (0 unexpected) in 0.358 (0.362) seconds
 Test Suite 'Selected tests' passed at 2021-03-13 20:24:59.150.
      Executed 5 tests, with 0 failures (0 unexpected) in 0.358 (0.364) seconds
 */
