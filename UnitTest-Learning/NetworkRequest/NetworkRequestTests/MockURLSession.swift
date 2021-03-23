import Foundation
import XCTest
@testable import NetworkRequest

private class DummyURLSesionDataTask: URLSessionDataTask {
    override func resume() {
        
    }
}

final class MockURLSession: XCTestCase, URLSessionProtocol {
    /*
     “Don’t use a Boolean flag to record when the test spy receives a call. That’s throwing away information about the communication. Instead, increment a call count so you can tell how many times a method was called."
     */
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        return session.dataTask(with: request.url!)
        
        return DummyURLSesionDataTask()
    }
    
    func verifyDataTask(with request: URLRequest, file: StaticString = #file, line: UInt = #line) {
        //Why i have replaced below XCTAssert because when we call two times of the api call,  we will get two different assert like call count not matches with 1 and request will get failure. so avoiding more than one call and different assert error, we have used this helper function.
//        XCTAssertEqual(dataTaskCallCount, 1, "call count", file: file, line: line)
        guard dataTaskWasCalledOnce(file: file, line: line) else {
            return
        }
        XCTAssertEqual(dataTaskArgsRequest.first, request, "request", file: file, line: line)
    }
    
    private func dataTaskWasCalledOnce(file: StaticString = #file, line: UInt = #line) -> Bool {
        verfiyMethodCalledOnce(methodName: "dataTask(with:completionHandler:)", callCount: dataTaskCallCount, describeArguments: "request:\(dataTaskArgsRequest)", file: file, line: line)
    }
    
    func verfiyMethodCalledOnce(methodName: String, callCount: Int, describeArguments: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Bool {
        if callCount == 0 {
            XCTFail("Wanted but not invoked: \(methodName)")
            return false
        }
        
        if callCount > 1 {
            XCTFail("Wanted 1 time but was called \(callCount) times." + "\(methodName) with \(describeArguments())", file: file, line: line)
            return false
        }
        
        return true
        
    }

   
}
