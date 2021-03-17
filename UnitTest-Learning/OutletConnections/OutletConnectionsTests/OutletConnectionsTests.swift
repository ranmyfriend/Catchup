@testable import OutletConnections
import XCTest

final class OutletConnectionsTests: XCTestCase {

    func test_outlets_shouldBeConnected() {
        let sut = OutletConnectionsViewController()
        /*“When a test case has more than one assertion, it’s helpful add a descriptive message to each assertion. This way, you don’t even have to click on the failure message to know which assertion failed”
 */
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label, "label")
        XCTAssertNotNil(sut.button, "button")
    }
}
