import XCTest
@testable import PointFree

final class SingleTypeCompositionOperatorsTests: XCTestCase {
	struct StyleConfiguration: Equatable {
		var fontSize: Int
		var isBold: Bool
		var isItalic: Bool

		static let `default` = StyleConfiguration(fontSize: 16, isBold: false, isItalic: false)

		static func applyTitleStyle(_ self: inout Self) {
			self.fontSize = 20
			self.isBold = true
		}

		static func applyEmphasysStyle(_ self: inout Self) {
			self.isItalic = true
			self.fontSize += 1
		}

		static func applyBodyStyle(_ self: inout Self) {
			self.isBold = false
			self.isItalic = false
		}
	}

	func testMutating() {
		let headerStyle = StyleConfiguration.applyTitleStyle
			<> StyleConfiguration.applyEmphasysStyle

		var config = StyleConfiguration.default
		config |> headerStyle

		XCTAssertEqual(
			config,
			StyleConfiguration(
				fontSize: 21,
				isBold: true,
				isItalic: true
			)
		)

		config |> StyleConfiguration.applyBodyStyle
		XCTAssertEqual(
			config,
			StyleConfiguration(
				fontSize: 21,
				isBold: false,
				isItalic: false
			)
		)
	}

	func testInoutNonInout() {
		let config = StyleConfiguration.default

		let anotherConfig = config
			|> fromInout(StyleConfiguration.applyTitleStyle)
			<> fromInout(StyleConfiguration.applyEmphasysStyle)

		XCTAssertEqual(
			anotherConfig,
			StyleConfiguration(
				fontSize: 21,
				isBold: true,
				isItalic: true
			)
		)
	}
}
