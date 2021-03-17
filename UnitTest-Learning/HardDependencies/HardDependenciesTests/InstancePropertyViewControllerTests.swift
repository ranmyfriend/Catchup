@testable import HardDependencies
import XCTest

final class InstancePropertyViewControllerTests: XCTestCase {

    func test_zero() throws {
//        XCTFail("Tests not yet implemented in InstancePropertyViewControllerTests")
    }
    
    func test_viewDidAppear() {
        let sut: InstancePropertyViewController = UIStoryboard(name: "Man", bundle: nil).instantiateViewController(identifier: String(describing: InstancePropertyViewController.self))
        sut.analytics = Analytics()
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
    }
}
