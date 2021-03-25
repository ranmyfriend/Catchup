@testable import NetworkResponse
import XCTest
import ViewControllerPresentationSpy

final class ViewControllerTests: XCTestCase {
    
    private var alertVerifier: AlertVerifier!
    private var sut: ViewController!
    private var spyURLSession: SpyURLSesion!
    
    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        spyURLSession = SpyURLSesion()
        sut.session = spyURLSession
        
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        alertVerifier = nil
        sut = nil
        spyURLSession = nil
        super.tearDown()
    }
    
    func test_searchForBookNetworkCall_withSuccessResponse_shouldSaveDataInResults() {
        
        sut.button.sendActions(for: .touchUpInside)
        
        let handleResultsCalled = expectation(description:
            "handleResults called")
        sut.handleResults = { _ in
            handleResultsCalled.fulfill()
        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(
            jsonData(), respone(statusCode: 200), nil
        )
        
        //Many examples of waiting for an XCTestCaseExpectation specify a timeout of 1 second. I have even seen 10 seonds. But for unit testing where there is no actual networking,
        //If you are putting breakpoint, then the testcase will fail
        waitForExpectations(timeout: 0.01)
        
    }
    
    /*
     “Whenever you write a test of asynchronous code, write a second test without the test expectations. It shows what happens without the asynchronous code. This helps keep the asynchronous part from creeping outside its closure.”
     */
    
    func test_searchForBookNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInResults() {
        
        //duplicate code, coz lately we have moved into setup and teardown
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        let spyURLSession = SpyURLSesion()
        sut.session = spyURLSession
        
        sut.loadViewIfNeeded()
        sut.button.sendActions(for: .touchUpInside)
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(
            jsonData(), respone(statusCode: 200), nil
        )
        
        XCTAssertEqual(sut.results, [])
    }
    
    func test_searchForBookNetworkCall_withError_shouldShowAlert() {
        sut.button.sendActions(for: .touchUpInside)
        //To Test Asynchronous code you have enable the expectation and full fill once you get your response, then you will write your XCTAssertions
//        let alertShown = expectation(description: "alert shown")
//        alertVerifier.testCompletion = {
//            alertShown.fulfill()
//        }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?( nil, nil, TestError(message: "DUMMY")
        )
        
//        waitForExpectations(timeout: 0.01)
        
//        verifyErrorAlert(message: "oh no")
        XCTAssertEqual(alertVerifier.presentedCount, 0)
    }
    
    private func verifyErrorAlert(message: String, file: StaticString = #file, line: UInt = #line) {
        alertVerifier.verify(
            title: "Network problem",
            message: message,
            animated: true,
            actions: [.default("OK")],presentingViewController: sut, file: file, line: line
        )
        
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action", file: file, line: line)
    }
    
    private func respone(statusCode: Int) -> HTTPURLResponse? {
        return HTTPURLResponse(url: URL(string: "http://DUMMY")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
    
    
    //When JSON is large, store it in a file to make it easier to copy and paste from an acutal response.
    private func jsonData() -> Data {
        return """
        
        {
         "resultCount":1,
         "results": [
        {"artworkUrl60":"https://is3-ssl.mzstatic.com/image/thumb/Publication/v4/ed/aa/bb/edaabb40-5a51-384f-e70a-baf8fb64a87b/source/60x60bb.jpg", "artworkUrl100":"https://is3-ssl.mzstatic.com/image/thumb/Publication/v4/ed/aa/bb/edaabb40-5a51-384f-e70a-baf8fb64a87b/source/100x100bb.jpg", "artistViewUrl":"https://books.apple.com/us/artist/bookrags-com/464322651?uo=4", "trackCensoredName":"Bone", "fileSizeBytes":187048, "formattedPrice":"$4.99", "trackViewUrl":"https://books.apple.com/us/book/bone/id494439487?uo=4", "trackId":494439487, "trackName":"Bone", "releaseDate":"2012-01-11T02:06:49Z", "genreIds":["10037", "38", "9029"], "currency":"USD", "description":"Bone: Out from Boneville Study Guide consists of approx. 33 pages of summaries and analysis on Bone: Out from Boneville by Jeff Smith.", "artistId":464322651, "artistName":"BookRags.com", "genres":["Education", "Books", "Professional & Technical"], "price":4.99, "artistIds":[464322651], "kind":"ebook", "averageUserRating":4.5, "userRatingCount":6}]
        }
""".data(using: .utf8)!
    }
}
