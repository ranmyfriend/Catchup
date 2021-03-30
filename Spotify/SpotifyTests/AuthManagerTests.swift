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

//Success:{
//    "access_token" = "BQClUv4W18vNdAjb3nz8jFCoT7J9aHusbdMvbLdEDgYi9xkGZ7zGAlF0V1tAtt8jYjMBLjTdZCSnCMZziafuEMEhg3iCfsI0JwVtvNH_wxJwN8z5SMRUw57cEWfX2E8wVI4q-HJycrwzbiS1Y98j1DYsfZzp";
//    "expires_in" = 3600;
//    "refresh_token" = "AQC-UauvUGT4sepp3d_viehVOL_TDaVL1V4lPav_FFKBaa4yFpcwridcziAK2TinbrDF8Ckp0n004DpH0mHD0Mr_LDAmiN4zfaiyiv49cGRiPQsTS-t2R8u6jpB0P8hWkRI";
//    scope = "user-read-private";
//    "token_type" = Bearer;
//}
