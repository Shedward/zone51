import XCTest
@testable import PointFree

private func incr(_ x: Int) -> Int {
	x + 1
}

private func setValue<V>(_ value: V?) -> (V?) -> V? {
	{ _ in value }
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

		XCTAssertEqual(incrementedStruct.0, 2)
		XCTAssertEqual(incrementedStruct.1.1, [2, 3, 4, 5])
	}

	func testCollectionSetters() {
		let array = [1, 2, 3, 4]
		XCTAssertEqual(
			array
				|> atIndex(2)(incr)
				|> atIndex(3)(incr),
			[1, 2, 4, 5]
		)

		let dict: [String: Int] = ["Swift": 1, "PHP": -2, "C++": 3]
		XCTAssertEqual(
			dict
				|> atKeyIfExist("Swift")(incr)
				|> atKeyIfExist("Gooper")(incr),
			["Swift": 2, "PHP": -2, "C++": 3]
		)

		XCTAssertEqual(
			dict |> atKey("Go")(PointFreeTests.setValue(4)),
			["Swift": 1, "PHP": -2, "C++": 3, "Go": 4]
		)
	}
}
