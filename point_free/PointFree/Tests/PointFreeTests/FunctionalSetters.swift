import XCTest
@testable import PointFree

private func incr(_ x: Int) -> Int {
	x + 1
}

final class FunctionalSettersTests: XCTestCase {
	func testFirstSecond() {
		let pair = (43, "45")
		XCTAssert(
			(pair |> first(incr) |> first(incr)) == (45, "45")
		)

		XCTAssert(
			(pair
				|> second(Int.init)
				|> second({ $0 ?? 0 })
				|> second(incr)
				|> first(incr)
			) == (44, 46)
		)
	}

	func testBackwardsComposition() {
		let nestedPair = ((1, true), "Swift")
		let changedPair = nestedPair
			|> (first <<< second)(not)
			|> second(Int.init)
			|> second({ $0 ?? 0 })

		XCTAssertEqual(changedPair.0.1, false)
		XCTAssertEqual(changedPair.1, 0)
	}

	func testComplexSetters() {
		let complexStruct = (1, ("Hello", [1, 2, 3, 4]))
		let incrementedStruct = complexStruct
			|> (second <<< second <<< map)(incr)
			|> first(incr)
			// |> (secondInt <<< secondInt <<< secondInArray)(incr)

		XCTAssertEqual(incrementedStruct.0, 2)
		XCTAssertEqual(incrementedStruct.1.1, [2, 3, 4, 5])
	}
}
