@testable import NetworkRequest
import XCTest

final class ViewControllerTests: XCTestCase {

    func     test_tappingButton_shouldMakeDataTaskToSearchForEBookOutFromBoneville() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        sut.loadViewIfNeeded()
        sut.button.sendActions(for: .touchUpInside)
        
        mockURLSession.verifyDataTask(with: URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=out%20from%20boneville")!))
    }
}
