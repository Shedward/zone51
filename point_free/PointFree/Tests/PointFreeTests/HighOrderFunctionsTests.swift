import XCTest
@testable import PointFree

final class HighOrderFunctionsTests: XCTestCase {
	func testCurringAndFliping() {
		let stringWithEncoding = flip(curry(String.init(data:encoding:)))
		let utf8String = stringWithEncoding(.utf8)

		let string = "Hello"
		let data = string.data(using: .utf8)!

		let revertedString = utf8String(data)
		XCTAssertEqual(string, revertedString)
	}
}
