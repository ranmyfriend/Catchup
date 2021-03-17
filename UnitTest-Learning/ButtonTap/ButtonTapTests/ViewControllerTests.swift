@testable import ButtonTap
import XCTest

final class ViewControllerTests: XCTestCase {

   
    func test_tappingButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        sut.loadViewIfNeeded()
        //we can send any event(touchUpInside kind of) to any control(button or some UIElements)
//        sut.button.sendActions(for: .touchUpInside)
        //NOTE: UIBarButtonItems are not UIControls, so we cannot call sendActions(for:)
        tap(sut.button)
    }
    
}
