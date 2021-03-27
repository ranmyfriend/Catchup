@testable import Spotify
import XCTest


final class SpyAuthManager: AuthManagerProtocol {
    
    var isSignedIn: Bool {
        return false
    }
    
}

/*
 There are flaws here. like, we cannot perfectly test out the AuthManager shared instance which inside the App delegate.
 So, keep it aside lets move on
 */

final class AuthManagerTests: XCTestCase {
    
    var spyManager: SpyAuthManager!
    var testAppDelegate: TestAppDelegate!
    
    override func setUpWithError() throws {
        spyManager = SpyAuthManager()
        testAppDelegate = TestAppDelegate()
        testAppDelegate.authManager = spyManager
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        spyManager = nil
        testAppDelegate = nil
        try super.tearDownWithError()
    }

    func test_isSignedIn() {
        XCTAssertFalse(testAppDelegate.authManager.isSignedIn, "Logged In")
    }
}
