import XCTest
import UIKit

@testable import PointFree

final class UIKitStylingTests: XCTestCase {
	func testStyling() {
		let style = UIView.setRoundedBorders(radius: 8)
			<> UIView.setBackground(color: .gray)
			<> UIView.setBorders(color: .black, width: 1)
			<> UILabel.setHeaderStyle()

		let label = UILabel()
		label |> style

		XCTAssertEqual(label.layer.borderColor, UIColor.black.cgColor)
		XCTAssertEqual(label.font, .systemFont(ofSize: 18, weight: .semibold))
	}
}
