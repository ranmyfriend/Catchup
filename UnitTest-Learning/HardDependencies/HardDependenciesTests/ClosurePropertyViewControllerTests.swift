@testable import HardDependencies
import XCTest

final class ClosurePropertyViewControllerTests: XCTestCase {

    func test_zero() throws {
//        XCTFail("Tests not yet implemented in ClosurePropertyViewControllerTests")
    }
    
    func test_viewDidAppear() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ClosurePropertyViewController = storyboard.instantiateViewController(identifier: String(describing: ClosurePropertyViewController.self))
        sut.loadViewIfNeeded()
        sut.makeAnalytics = {Analytics()}
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
