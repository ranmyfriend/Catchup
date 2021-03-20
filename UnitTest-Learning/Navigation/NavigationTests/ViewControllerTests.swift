@testable import Navigation
import XCTest
import ViewControllerPresentationSpy

//We can't use this for a view controller that comes from a storyboard
/*
 Note:<PRESENT Model>
  Here we can create spyViewController of ViewController and override the present function to capture the presentCallCount, presentArgs as well
 */
//SUBCLASS AND OVVERIDE: A Legacy Code Technique
//We cannot use this technique for Storyboards but we can use it for Code and XIB.
private class TestableViewController: ViewController {
    
    var presentCallCount = 0
    var presentArgsViewController: [UIViewController] = []
    var presentArgsAnimated: [Bool] = []
    var presentArgsClosure: [(() -> Void)?] = []
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
        presentArgsViewController.append(viewControllerToPresent)
        presentArgsAnimated.append(flag)
        presentArgsClosure.append(completion)
    }
}



final class ViewControllerTests: XCTestCase {

    let presentationVerifier = PresentationVerifier()
    
    /*
     Note:<PUSH> How to Spy on the Animated Flag
     if you want to test the Animated flag is true or flase. You have create subclass of UINavigationController and override the pushViewController function to capture the animated flag value.
     */
    func test_tappingCodePushButton_shouldPushCodeNextViewController() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
        let navigation = UINavigationController(rootViewController: sut)
        tap(sut.codePushButton)
        executeRunLoop()
//        XCTAssertNotNil(sut.navigationController)
        XCTAssertEqual(navigation.viewControllers.count, 2, "navigation stack")
        
        let pushedVC = navigation.viewControllers.last
        XCTAssertTrue(pushedVC is CodeNextViewController, "Expected CodeNextViewController, " + "but was \(String(describing: pushedVC))")
    }
    
    
    
    func test_INCORRECT_tappingCodeModalButton_shouldPresentCodeNextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        //This is bad approach to setting up the rootcontroller. instead we have to call loadViewIfNeeded()
        //because it does not clean the room i mean the viewcontroller instance wont get called DEINIT. So, it wont get deallocated.
        UIApplication.shared.windows.first?.rootViewController = sut
        tap(sut.codeModalButton)
        
        let presentedVC = sut.presentedViewController
        guard let codeNextVC = presentedVC as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController," + "but was \(String(describing: presentedVC))")
            return
        }
        
        XCTAssertEqual(codeNextVC.label.text, "Modal from code")
    }
    
    func test_tappingCodeModalButton_shouldPresentCodeNextViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))

        sut.loadViewIfNeeded()
        tap(sut.codeModalButton)
        
//        executeRunLoop()
        
        /*
         presentationVerifier.verify checks
         - The one view controller was presented
         - That it was presented with animation
         - That the presenting view controller was the syster under test
         - That the type of the presented view controller is correct. And if so, it returns an instance of the correct type. (Otherwise, it returns nil.)
         */
        
        let codeNextVC: CodeNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)
        
        XCTAssertEqual(codeNextVC?.label.text, "Modal from code")
    }
    
    func test_tappingSeguePushButton_shouldShowSegueNextViewController() {
        
        let presentationVerifier = PresentationVerifier()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))

        putInWindow(vc: sut)
        
//        sut.loadViewIfNeeded()
        tap(sut.codeModalButton)
        
        tap(sut.seguePushButton)
        
        let segueNextVC: SegueNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)
        XCTAssertEqual(segueNextVC?.label.text, "Pushed from segue")
    }
    
}
