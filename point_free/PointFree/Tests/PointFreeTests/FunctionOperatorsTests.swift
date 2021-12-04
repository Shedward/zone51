import XCTest
@testable import PointFree

private func incr(_ x: Int) -> Int {
	x + 1
}

private func square(_ x: Int) -> Int {
	x * x
}

final class FunctionOperatorsTests: XCTestCase {
	func testApplication() {
		XCTAssertEqual(2 |> incr, 3)
		XCTAssertEqual(2 |> incr |> square, 9)
	}

	func testComposition() {
		XCTAssertEqual(2 |> incr >>> square, 9)
		XCTAssertEqual(
			[1, 2, 3].map(incr >>> square),
			[4, 9, 16]
		)
	}
}
