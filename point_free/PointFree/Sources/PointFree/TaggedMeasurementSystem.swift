
enum Units {
	enum Temperature {
		enum Celsius {}
		enum Farenheit {}
	}

	enum Mass {
		enum Kilogramms {}
		enum Tons {}
	}

	enum Length {
		enum Meter {}
		enum Mile {}
	}

	enum Time {
		enum Second {}
	}

	enum Velocity {
		enum MeterPerSecond {}
	}

	enum Acceleration {
		enum MeterPerSquareSecond {}
	}
}

typealias Measure<Unit, Value: Numeric> = Tagged<Unit, Value>

extension Measure where Tag == Units.Mass.Tons {
	func toKilos() -> Measure<Units.Mass.Kilogramms, RawValue> {
		.init(rawValue: rawValue * 1000)
	}
}

extension Measure where Tag == Units.Mass.Kilogramms, RawValue: FloatingPoint {
	func toTons() -> Measure<Units.Mass.Tons, RawValue> {
		.init(rawValue: rawValue / 1000)
	}
}

extension Measure where Tag == Units.Length.Mile, RawValue: FloatingPoint {
	func toMeter() -> Measure<Units.Length.Meter, RawValue> {
		.init(rawValue: rawValue * 1609)
	}
}

extension Measure where Tag == Units.Velocity.MeterPerSecond, RawValue: FloatingPoint {
	init(
		length: Measure<Units.Length.Meter, RawValue>,
		per time: Measure<Units.Time.Second, RawValue>
	) {
		self.init(rawValue: length.rawValue / time.rawValue)
	}
}

extension Measure where Tag == Units.Acceleration.MeterPerSquareSecond, RawValue: FloatingPoint {
	init(
		velocity: Measure<Units.Velocity.MeterPerSecond, RawValue>,
		per time: Measure<Units.Time.Second, RawValue>
	) {
		self.init(rawValue: velocity.rawValue / time.rawValue)
	}
}
