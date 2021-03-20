@testable import UserDefaults
import XCTest

final class ViewControllerTests: XCTestCase {
    
    private var sut: ViewController!
    private var defaults: FakeUserDefaults!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        defaults = FakeUserDefaults()
        sut.userDefaults = defaults
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        defaults = nil
        super.tearDown()
    }

    func test_viewDidLoad_with7UserDefaults_shouldShow7InCounterLabel() {
        defaults.integers = ["count": 7]
        sut.loadViewIfNeeded()
        
        XCTAssertEqual("7", sut.counterLabel.text)
        
    }
    
    func test_tappingButton_with12InUserDefaults_shouldWrite13ToUserDefaults() {
        defaults.integers = ["count": 12]
        sut.loadViewIfNeeded()
        
        tap(sut.incrementButton)
        
        XCTAssertEqual("13", sut.counterLabel.text)
    }
    
    
}
