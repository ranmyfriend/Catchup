@testable import TextField
import XCTest

final class ViewControllerTests: XCTestCase {
    var sut: ViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.userNameField, "usernameField")
        XCTAssertNotNil(sut.passwordField, "passwordField")
    }
    
    func test_usernameField_attributesShouldBeSet() {
        let textField = sut.userNameField!
        
        XCTAssertEqual(textField.textContentType, .username, "textContentType")
        XCTAssertEqual(textField.autocorrectionType, .no, "autoCorrectionType")
        XCTAssertEqual(textField.returnKeyType, .next, "returnKeyType")
    }
    
    /// Testing out the Delegates
    
    func test_textFieldDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.userNameField.delegate, "usernameField")
        XCTAssertNotNil(sut.passwordField.delegate, "passwordField")
    }
    
    func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange() {
//        let allowChange = sut.userNameField.delegate?.textField?(sut.userNameField, shouldChangeCharactersIn: NSRange(), replacementString: "a b")
        let allowChange = shouldChangeCharacters​(in: sut.userNameField, replacement: "a b")
        
        XCTAssertEqual(allowChange, false)
    }
    
    
    func test_shouldReturn_withPassword_shouldPerformLogin() {
        sut.userNameField.text = "USERNAME"
        sut.passwordField.text = "PASSWORD"
        
        shouldReturn(in: sut.passwordField)
        
        // Assertions should go like user performed login or not?
        // check console log
    }
    
    func test_shouldReturn_withUsername_shouldMoveInputFocusToPassword() {
        putInViewHierarchy(sut)
        shouldReturn(in: sut.userNameField)
        XCTAssertTrue(sut.passwordField.isFirstResponder)
    }
    
    func test_shouldReturn_withPassword_shouldDismissKeyboard() {
        putInViewHierarchy(sut)
        sut.passwordField.becomeFirstResponder()
        XCTAssertTrue(sut.passwordField.isFirstResponder, "precondition")
        
        shouldReturn(in: sut.passwordField)
        
        XCTAssertFalse(sut.passwordField.isFirstResponder)
    }
    
}
