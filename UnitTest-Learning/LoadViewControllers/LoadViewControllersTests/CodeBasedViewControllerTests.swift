@testable import LoadViewControllers
import XCTest

final class CodeBasedViewControllerTests: XCTestCase {

    func test_zero() throws {
//        XCTFail("Tests not yet implemented in CodeBasedViewControllerTests")
    }
    
    func test_loading() {
        let sut = CodeBasedViewController(data: "Dummy")
        sut.viewDidLoad() //Wrong practise to call viewDidLoad ourself. but instead you can go with loadViewIfNeeded()
        XCTAssertNotNil(sut)
//        XCTAssertEqual("Dummy", sut.data)
    }
}
