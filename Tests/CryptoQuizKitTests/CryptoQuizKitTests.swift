import XCTest
@testable import CryptoQuizKit

final class CryptoQuizKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CryptoQuizKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
