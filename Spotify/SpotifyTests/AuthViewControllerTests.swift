@testable import Spotify
import XCTest
import WebKit

/* WorkAround of Loan */
//home loan 6.8
//7.10 - year - docs
//60L

//1 Crore 5 Laksh for 29years
//70L for 5-10year 56L(fund) 9years - 69k - 20k - 6.8 rate of interest - 15days - 20days

final class AuthViewControllerTests: XCTestCase {
    
    private var authViewController: AuthViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        authViewController = AuthViewController()
    }
    
    override func tearDownWithError() throws {
        authViewController = nil
        try super.tearDownWithError()
    }
    
    func test_viewSetup() {
        authViewController.loadViewIfNeeded()
        XCTAssertEqual(authViewController.title, "Sign In", "title")
        XCTAssertEqual(authViewController.view.backgroundColor, .systemBackground)
        XCTAssertNotNil(authViewController.webView.navigationDelegate, "webview navigation delegate")
        XCTAssertTrue(authViewController.view.subviews.contains(authViewController.webView), "webview not added as subview")
        XCTAssertNotNil(AuthManager.shared.signInURL, "signIn url")
        
        authViewController.webView.load(URLRequest(url: URL(string: "https://github.com/ranmyfriend?code=AQDf5kaQciJlqTRGl2avZT3CCNTssODxE7Vg1IJuD1dBpBF5DfH2ii0ulgiVc-YmabuHVMcRZXuX4nxiWy4ehmtbuqatUsXoGofK3Of7ZMw1KVRwgoqWVDYDwbzmN2T_6aFzih7YD1TFwt8HaKkuIHf4eEUrTdjiZj-8P2aMrLuXu0CzZuL_HA4063X7D2gmhoLJATU")!))
        
        didStartProvisionalNavigation(in: authViewController.webView, navigaiton: authViewController.webView.navigationDelegate as? WKNavigation)
    }
    
    func test_webViewSetup() {
        XCTAssertNotNil(authViewController.webView, "webview")
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        XCTAssertEqual(authViewController.webView.configuration, config, "webview config")
    }
    
}


func didStartProvisionalNavigation(in webView: WKWebView, navigaiton: WKNavigation!) {
    webView.navigationDelegate?.webView?(webView, didStartProvisionalNavigation: navigaiton)
}
