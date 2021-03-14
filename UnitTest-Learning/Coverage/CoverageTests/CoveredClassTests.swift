@testable import Coverage
import XCTest

/*
 To Enable Code Coverage go to Product -> Schemes -> Edit Sceme -> Test -> Options -> Gather Code Coverage
 
    - Always build the project to exposing the new methods visiblity to the test target
    - Command + 9 to see the Coverage and build, log things for respective test targets.
 
 “ Lack of code coverage proves lack of testing. But positive code coverage doesn’t prove anything.”

 */

final class CoveredClassTests: XCTestCase {

//    func test_zero() throws {
//        XCTFail("Tests not yet implemented in CoveredClassTests")
//    }
    
    func test_maxWith1And2_ShowReturnSomething() {
        let result = ​CoveredClass​.max(1, 2)
        XCTAssertEqual(result, 2)
        let result2 = ​CoveredClass​.max(2, 1)
        XCTAssertEqual(result2, 2)
    }
    
    
    func test_commaSepartedWith2And4_ShowReturnSomething() {
        let result = ​CoveredClass​.commaSeprated(from: 2, to: 4)
        XCTAssertEqual(result, "2,3,4")
    }
    
    //when your test result changes, then change the test name as well. both are should aligned with test case. 
    func test_commaSepartedWith2And2_ShowReturnWithNoComma() {
        let result = ​CoveredClass​.commaSeprated(from: 2, to: 2) //To have orbitary loop, use zero(0) on to value
        XCTAssertEqual(result, "2")
    }
    
    func test_area_withWidth7_shouldBe49() {
        let sut = ​CoveredClass​()
        sut.width = 7
        
        XCTAssertEqual(sut.area, 49)
    }
    
}
