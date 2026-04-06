import XCTest
@testable import SonarQube

final class CalculatorTests: XCTestCase {
    func testAdd() {
        let result = Calculator().add(2, 3)
        XCTAssertEqual(result, 5)
    }
    
    func testAddNumber() {
        let result = Calculator().add(2, 3)
        XCTAssertEqual(result, 10)
    }
}
