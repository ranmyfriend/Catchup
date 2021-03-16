@testable import LoadViewControllers
import XCTest

final class StoryboardBasedViewControllerTests: XCTestCase {

    func test_zero() throws {
//        XCTFail("Tests not yet implemented in StoryboardBasedViewControllerTests")
    }
    
    func test_loading() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut: StoryboardBasedViewController = sb.instantiateViewController(identifier: String(describing: StoryboardBasedViewController.self))
        sut.loadViewIfNeeded() //this will load the view from storyboard. otherwise the label will be nil only.
        XCTAssertNotNil(sut.lablel)
    }
}
