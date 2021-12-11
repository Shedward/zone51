import XCTest
@testable import PointFree

private struct User: Equatable {
	let id: Int
	let name: String
	let balance: Int
}

final class FunctionalGettersTests: XCTestCase {
	private let user = User(id: 1, name: "John Doe", balance: 8)

	private let users: [User] = [
		User(id: 1, name: "John Doe", balance: 0),
		User(id: 2, name: "Any Mold", balance: 12),
		User(id: 3, name: "Toy Meddy", balance: 100),
		User(id: 4, name: "Oleg Gazmanov", balance: -18),
		User(id: 5, name: "Amely", balance: 9),
		User(id: 6, name: "Godzilla", balance: 8),
		User(id: 7, name: "", balance: 11)
	]

	func testFuntionalGetter() {
		let userStringId = get(\User.id) >>> String.init

		XCTAssertEqual(user |> userStringId, "1")
	}

	func testTheirsCombination() {
		XCTAssertEqual(
			users.sorted(by: their(get(\.name), >)).map(get(\.id)),
			[3, 4, 1, 6, 2, 5, 7]
		)
		XCTAssertEqual(
			users.sorted(by: their(get(\.name.count), >)).map(get(\.id)),
			[4, 3, 1, 2, 6, 5, 7]
		)

		XCTAssertEqual(
			users.sorted(by: their(^\.name, >)).map(^\.id),
			[3, 4, 1, 6, 2, 5, 7]
		)
		XCTAssertEqual(
			users.sorted(by: their(^\.name.count, >)).map(^\.id),
			[4, 3, 1, 2, 6, 5, 7]
		)
	}

	func testReducing() {
		XCTAssertEqual(
			users.reduce(0, reducer(get(\.balance), +)),
			122
		)

		let appendWithSeparator = { (separator: String) in
			{ (lhs: String, rhs: String) -> String in
				guard !lhs.isEmpty else { return rhs }
				guard !rhs.isEmpty else { return lhs }
				return lhs + separator + rhs
			}
		}
		XCTAssertEqual(
			users.reduce("", reducer(get(\.name), appendWithSeparator(", "))),
			"John Doe, Any Mold, Toy Meddy, Oleg Gazmanov, Amely, Godzilla"
		)
	}
}
