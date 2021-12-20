import XCTest
@testable import PointFree

final class TaggedTests: XCTestCase {
	private enum TestError: Error {
		case failedToDecodeDataFromString
	}
	let usersJson = """
	[
	  {
		"id": 1,
		"name": "Brandon",
		"email": "brandon@pointfree.co",
		"subscriptionId": 1
	  },
	  {
		"id": 2,
		"name": "Stephen",
		"email": "stephen@pointfree.co",
		"subscriptionId": null
	  },
	  {
		"id": 3,
		"name": "Blob",
		"email": "blob@pointfree.co",
		"subscriptionId": 1
	  }
	]
	"""

	let subscriptionsJson = """
	[
	  {
		"id": 1,
		"ownerId": 1
	  }
	]
	"""

	struct UserPlain: Decodable, Equatable {
		let id: Int
		let name: String
		let email: String
		let subscriptionId: Int?
	}

	struct SubscriptionPlain: Decodable, Equatable {
		let id: Int
		let ownerId: Int
	}

	func testPlainCoding() throws {
		let brandonUser = UserPlain(id: 1, name: "Brandon", email: "brandon@pointfree.co", subscriptionId: 1)

		let users = try decodeList(UserPlain.self, from: usersJson)
		XCTAssertEqual(users.count, 3)
		XCTAssertEqual(users.first, brandonUser)

		let subscriptions = try decodeList(SubscriptionPlain.self, from: subscriptionsJson)
		XCTAssertEqual(subscriptions.count, 1)
		XCTAssertEqual(subscriptions.first, .init(id: 1, ownerId: 1))

		let subscriptionOwner = subscriptions.first.map { subscription in users.first(where: { user in user.subscriptionId == subscription.id }) }
		XCTAssertEqual(subscriptionOwner, brandonUser)
	}

	typealias Record = RawRepresentable & Decodable & Equatable

	struct UserRecord: Decodable, Equatable {
		struct Id: Record { var rawValue: Int }
		struct Name: Record { var rawValue: String }
		struct Email: Record { var rawValue: String }

		let id: Id
		let name: Name
		let email: Email
		let subscriptionId: SubscriptionRecord.Id?
	}

	struct SubscriptionRecord: Decodable, Equatable {
		struct Id: Record { var rawValue: Int }

		let id: Id
		let ownerId: UserRecord.Id
	}

	func testRawRepresantable() throws {
		let brandonUser = UserRecord(id: .init(rawValue: 1), name: .init(rawValue: "Brandon"), email: .init(rawValue: "brandon@pointfree.co"), subscriptionId: .init(rawValue: 1))

		let users = try decodeList(UserRecord.self, from: usersJson)
		XCTAssertEqual(users.count, 3)
		XCTAssertEqual(users.first, brandonUser)

		let subscriptions = try decodeList(SubscriptionRecord.self, from: subscriptionsJson)
		XCTAssertEqual(subscriptions.count, 1)
		XCTAssertEqual(subscriptions.first, .init(id: .init(rawValue: 1), ownerId: .init(rawValue: 1)))

		let subscriptionOwner = subscriptions.first.map { subscription in users.first(where: { user in user.subscriptionId == subscription.id }) }
		XCTAssertEqual(subscriptionOwner, brandonUser)
	}

	struct UserTagged: Decodable, Equatable {
		enum IdTag {}
		enum NameTag {}
		enum EmailTag {}

		typealias Id = Tagged<IdTag, Int>
		typealias Name = Tagged<NameTag, String>
		typealias Email = Tagged<EmailTag, String>

		let id: Id
		let name: Name
		let email: Email
		let subscriptionId: SubscriptionTagged.Id?
	}

	struct SubscriptionTagged: Decodable, Equatable {
		enum IdTag {}
		typealias Id = Tagged<IdTag, Int>
		typealias OwnerId = Tagged<UserTagged.IdTag, Int>

		let id: Id
		let ownerId: OwnerId
	}

	func testTagged() throws {
		let brandonUser = UserTagged(id: 1, name: "Brandon", email: "brandon@pointfree.co", subscriptionId: .init(rawValue: 1))

		let users = try decodeList(UserTagged.self, from: usersJson)
		XCTAssertEqual(users.count, 3)
		XCTAssertEqual(users.first, brandonUser)

		let subscriptions = try decodeList(SubscriptionTagged.self, from: subscriptionsJson)
		XCTAssertEqual(subscriptions.count, 1)
		XCTAssertEqual(subscriptions.first, .init(id: 1, ownerId: .init(rawValue: 1)))

		let subscriptionOwner = subscriptions.first.map { subscription in users.first(where: { user in user.subscriptionId == subscription.id }) }
		XCTAssertEqual(subscriptionOwner, brandonUser)
	}

	private func decodeList<T: Decodable>(_ type: T.Type, from string: String) throws -> [T] {
		guard let data = string.data(using: .utf8) else { throw TestError.failedToDecodeDataFromString }
		return try JSONDecoder().decode([T].self, from: data)
	}

	func testMeasurementsCalculations() {
		let value1: Measure<Units.Mass.Kilogramms, Int> = 21
		let value2: Measure<Units.Mass.Kilogramms, Int> = 100
		let sum = value1 + value2

		XCTAssertEqual(sum, 121)

		let value3: Measure<Units.Mass.Tons, Int> = 4
		// let sum2 = value2 + value3

		func tonsToKilos<T: Numeric>(_ tons: Measure<Units.Mass.Tons, T>) -> Measure<Units.Mass.Kilogramms, T> {
			return .init(rawValue: tons.rawValue * 1000)
		}
	}
}
