import XCTest
@testable import PointFree

private func incAndLog(x: Int) -> SideAffected<Int, String> {
	.init(x + 1, sideEffects: ["Incremented \(x)"])
}

private func inc(x: Int) -> Int {
	x + 1
}

private func squareAndLog(x: Int) -> SideAffected<Int, String> {
	.init(x * x, sideEffects: ["Squared \(x)"])
}

private func square(x: Int) -> Int {
	x * x
}

final class SideEffectOperatorsTests: XCTestCase {
	func testSideEffectApplication() {
		let result = 2 |> incAndLog >=> squareAndLog
		let expected = SideAffected(9, sideEffects: ["Incremented 2", "Squared 3"])
		XCTAssertEqual(result, expected)
	}

	func testCompositionOfOperators() {
		let f = (inc >>> incAndLog) >=> (square >>> squareAndLog)
		let result = [1, 2, 3].map(f)
		let expected: [SideAffected<Int, String>] = [
			.init(81, sideEffects: ["Incremented 2", "Squared 9"]),
			.init(256, sideEffects: ["Incremented 3", "Squared 16"]),
			.init(625, sideEffects: ["Incremented 4", "Squared 25"])
		]
		XCTAssertEqual(result, expected)
	}
}
