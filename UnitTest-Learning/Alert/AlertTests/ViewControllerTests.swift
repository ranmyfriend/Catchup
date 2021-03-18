@testable import Alert
import XCTest
import ViewControllerPresentationSpy

final class ViewControllerTests: XCTestCase {

    private var alertVerifier: AlertVerifier!
    private var sut: ViewController!
    
    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
        let storboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        alertVerifier = nil
        sut = nil
        super.tearDown()
    }
    
    func test_zero() throws {
//        XCTFail("Tests not yet implemented in ViewControllerTests")
    }
    
    func test_tappingButton_showShowAlert() {
       
        tap(sut.button)
        
        alertVerifier.verify(
            title: "Do the Thing?",
            message: "Let us know if you want to do the thing.",
            animated: true,
            actions: [
                .cancel("Cancel"),
                .default("OK"),
            ],
            preferredStyle: .alert,
            presentingViewController: sut
        )
        
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action")
    }
    
    func test_executeAlertAction_withOKButton() throws {
        tap(sut.button)
        //Here we can verify the OK button is there on the alertcontroller or not
        try alertVerifier.executeAction(forButton: "OK")
    }
    
    
}
