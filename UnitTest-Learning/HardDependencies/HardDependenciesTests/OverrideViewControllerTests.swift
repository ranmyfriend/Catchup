@testable import HardDependencies
import XCTest

//This is how you can subclass and override the functionality to enhance the testing
/*
 “Swift doesn’t allow subclassing of structs.

 The final modifier prevents classes from having subclasses. Remove it to apply this technique.

 Storyboard-based view controllers can’t be subclassed because the storyboard stores an instance of a predetermined type.”
 */
private class TestableOverrideViewController: OverrideViewController {
    
    override func analytics() -> Analytics {
        return Analytics()
    }
    
}

final class OverrideViewControllerTests: XCTestCase {
    
    func test_zero() throws {
//        XCTFail("Tests not yet implemented in OverrideViewControllerTests")
    }
    
    func test_viewDidAppear() {
        let sut = TestableOverrideViewController()
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
    }
}
