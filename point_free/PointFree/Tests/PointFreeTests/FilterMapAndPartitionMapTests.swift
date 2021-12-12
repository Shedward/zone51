import XCTest
@testable import PointFree

final class FilterMapAndPartitonMapTests: XCTestCase {
	func testFilterAndPartition() {
		let evenOdd = { (x: Int) -> Either<Int, Int> in
			x % 2 == 0 ? .left(x) : .right(x)
		}
		let square = { (x: Int) -> Int in x * x }

		let parted = Array(1...10)
			|> partitionMap(evenOdd)
			|> (first <<< map)(square)

		XCTAssert(parted == ([4, 16, 36, 64, 100], [1, 3, 5, 7, 9]))
	}
}
