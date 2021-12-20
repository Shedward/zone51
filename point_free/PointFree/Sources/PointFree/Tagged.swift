struct Tagged<Tag, RawValue>: RawRepresentable {
	var rawValue: RawValue
}

extension Tagged: Decodable where RawValue: Decodable {
	init(from decoder: Decoder) throws {
		self.init(rawValue: try .init(from: decoder))
	}
}

extension Tagged: Encodable where RawValue: Encodable {
	func encode(to encoder: Encoder) throws {
		try rawValue.encode(to: encoder)
	}
}

extension Tagged: Equatable where RawValue: Equatable {
	static func == (_ lhs: Tagged, _ rhs: Tagged) -> Bool {
		lhs.rawValue == rhs.rawValue
	}
}

extension Tagged: ExpressibleByUnicodeScalarLiteral where RawValue: ExpressibleByUnicodeScalarLiteral {
	init(unicodeScalarLiteral value: RawValue.UnicodeScalarLiteralType) {
		self.init(rawValue: .init(unicodeScalarLiteral: value))
	}
}

extension Tagged: ExpressibleByExtendedGraphemeClusterLiteral where RawValue: ExpressibleByExtendedGraphemeClusterLiteral {
	init(extendedGraphemeClusterLiteral value: RawValue.ExtendedGraphemeClusterLiteralType) {
		self.init(rawValue: .init(extendedGraphemeClusterLiteral: value))
	}
}

extension Tagged: ExpressibleByStringLiteral where RawValue: ExpressibleByStringLiteral {
	init(stringLiteral value: RawValue.StringLiteralType) {
		self.init(rawValue: .init(stringLiteral: value))
	}
}

extension Tagged: ExpressibleByIntegerLiteral where RawValue: ExpressibleByIntegerLiteral {
	typealias IntegerLiteralType = RawValue.IntegerLiteralType

	init(integerLiteral value: IntegerLiteralType) {
		self.init(rawValue: RawValue(integerLiteral: value))
	}
}

extension Tagged: ExpressibleByNilLiteral where RawValue: ExpressibleByNilLiteral {
	init(nilLiteral: ()) {
		self.init(rawValue: .init(nilLiteral: ()))
	}
}

extension Tagged: Comparable where RawValue: Comparable {
	static func < (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Bool {
		lhs.rawValue < rhs.rawValue
	}
}

extension Tagged: AdditiveArithmetic where RawValue: AdditiveArithmetic {
	static var zero: Tagged<Tag, RawValue> {
		.init(rawValue: RawValue.zero)
	}

	static func + (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Tagged<Tag, RawValue> {
		.init(rawValue: lhs.rawValue + rhs.rawValue)
	}

	static func - (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Tagged<Tag, RawValue> {
		.init(rawValue: lhs.rawValue - rhs.rawValue)
	}
}

extension Tagged: Numeric where RawValue: Numeric {
	typealias Magnitude = RawValue.Magnitude

	init?<T>(exactly source: T) where T : BinaryInteger {
		guard let rawValue = RawValue(exactly: source) else { return nil }
		self = .init(rawValue: rawValue)
	}

	var magnitude: RawValue.Magnitude {
		rawValue.magnitude
	}

	static func * (lhs: Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) -> Tagged<Tag, RawValue> {
		.init(rawValue: lhs.rawValue * rhs.rawValue)
	}

	static func *= (lhs: inout Tagged<Tag, RawValue>, rhs: Tagged<Tag, RawValue>) {
		lhs = .init(rawValue: lhs.rawValue * rhs.rawValue)
	}
}
