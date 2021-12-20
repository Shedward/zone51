import XCTest
@testable import PointFree

final class TaggedMeasurementSystemTestsTests: XCTestCase {
	func testArithmetics() {
		let liquidMass: Measure<Units.Mass.Kilogramms, Float> = 1000
		let bowlMass: Measure<Units.Mass.Kilogramms, Float> = 200

		let totalMass = liquidMass + bowlMass
		XCTAssertEqual(totalMass, 1200)

		let twoBowlMass = bowlMass * 2
		XCTAssertEqual(twoBowlMass, 400)
	}

	func testConversions() {
		let smallMass: Measure<Units.Mass.Kilogramms, Float> = 1
		let bigMass: Measure<Units.Mass.Tons, Float> = 1

		// let mixedTotalMass = smallMass + bigMass // Compile error
		let totalMass = smallMass + bigMass.toKilos()
		XCTAssertEqual(totalMass, 1001)
	}

	func testComposition() {
		let length: Measure<Units.Length.Meter, Float> = 25
		let moveTime: Measure<Units.Time.Second, Float> = 5
		let observationTime: Measure<Units.Time.Second, Float> = 5

		let moveVelocity = Measure<Units.Velocity.MeterPerSecond, Float>(
			length: length,
			per: moveTime
		)
		let moveAcceleration = Measure<Units.Acceleration.MeterPerSquareSecond, Float>(
			velocity: moveVelocity,
			per: observationTime
		)

		XCTAssertEqual(moveAcceleration, 1)
	}
}
