@testable import TDD
import XCTest

//RED - GREEN - REFACTOR

final class GreeterWithoutNameTests: XCTestCase {

    private var sut: Greeter!
  
    override func setUp() {
        super.setUp()
        sut = Greeter(name: "")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_greet_with1159am_shouldSayGoodMorning() {
                
        let result = sut.greet(time: date(hour: 11, minute: 59))
        
        XCTAssertEqual(result, "Good morning.")
    }
    
    func test_greet_with1200pm_shouldSayGoodAfternoon() {
        let result = sut.greet(time: date(hour: 12, minute: 00))
        XCTAssertEqual(result, "Good afternoon.")
    }
    
    func test_greet_with459pm_shouldSayGoodAfternoon() {
        let result = sut.greet(time: date(hour: 16, minute: 59))
        XCTAssertEqual(result, "Good afternoon.")
    }
    
    func test_greet_with2pm_shouldSayGoodAfternoon() {
        let result = sut.greet(time: date(hour: 14, minute: 00))
        XCTAssertEqual(result, "Good afternoon.")
    }
    
    func test_greet_with333pm_shouldSayGoodAfternoon() {
        let result = sut.greet(time: date(hour: 15, minute: 33))
        XCTAssertEqual(result, "Good afternoon.")
    }
  
}



 func date(hour: Int, minute: Int) -> Date {
    let components = DateComponents(calendar: Calendar.current, hour: hour, minute: minute)
    return components.date!
}
