@testable import TDD
import XCTest

final class GreeterWithNameTests: XCTestCase {

    func test_greetMorning_withAlberto_shouldSayGoodMorningAlberto() {
        let sut = Greeter(name: "Alberto")
        
        let result = sut.greet(time: date(hour: 5, minute: 0))
        XCTAssertEqual(result, "Good morning, Alberto.")
    }
    
    func test_greetMorning_withBeryl_shouldSayGoodAfternoonBeryl() {
        let sut = Greeter(name: "Beryl")
        
        let result = sut.greet(time: date(hour: 15, minute: 0))
        XCTAssertEqual(result, "Good afternoon, Beryl.")
    }
}
