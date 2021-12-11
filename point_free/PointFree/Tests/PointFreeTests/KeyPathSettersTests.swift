import XCTest
@testable import PointFree

private struct Food: Equatable {
	var name: String
}

private struct Location: Equatable {
	var name: String
}

private struct User: Equatable {
	var favoriteFoods: [Food]
	var location: Location
	var name: String
}

final class KeyPathSettersTests: XCTestCase {

	private let user = User(
		favoriteFoods: [
			Food(name: "Tacos"),
			Food(name: "Nachos")
		],
		location: Location(name: "Brooklyn"),
		name: "Blob"
	)

	func testKeyPathSetters() {
		XCTAssertEqual(
			(user |> setProp(\User.name, to: "Blobbo")).name,
			"Blobbo"
		)

		let newUser = user
			|> (prop(\User.name)) { $0.uppercased() }
			|> setProp(\User.location.name, to: "Los Angeles")
		XCTAssertEqual(
			newUser,
			User(
				favoriteFoods: [
					Food(name: "Tacos"),
					Food(name: "Nachos")
				],
				location: Location(name: "Los Angeles"),
				name: "BLOB"
			)
		)
	}

	func testWithFoundation() {
		let guaranteeHeaders = (prop(\URLRequest.allHTTPHeaderFields)) { $0 ?? [:] }

		func setHeader(_ header: String, to value: String) -> (URLRequest) -> URLRequest {
			(prop(\.allHTTPHeaderFields) <<< map <<< prop(\.[header])) { _ in value }
		}

		let postRequest = guaranteeHeaders <> setProp(\.httpMethod, to: "POST")
		let jsonContent = setHeader("Content-Type", to: "application/json; charset=utf-8")
		let gitHubAccept = setHeader("Accept", to: "application/vnd.github.v3+json")
		let addAuthToken = { (token: String) in setHeader("Authorization", to: "Token: \(token)") }

		let request = URLRequest(url: URL(string: "https://www.pointfree.co/hello")!)
			|> postRequest
			|> jsonContent
			|> addAuthToken("deadbeef")
			|> gitHubAccept

		XCTAssertEqual(request.httpMethod, "POST")
		XCTAssertEqual(
			request.allHTTPHeaderFields,
			[
				"Content-Type": "application/json; charset=utf-8",
				"Accept": "application/vnd.github.v3+json",
				"Authorization": "Token: deadbeef"
			]
		)
	}
}
