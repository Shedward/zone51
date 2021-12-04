import UIKit

extension UIView {
	typealias StyleFunction<View: UIView> = (View) -> Void

	static func setAutolayout<V: UIView>() -> StyleFunction<V> {
		{
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}

	static func setAspectRatio<V: UIView>(ratio: CGSize) -> StyleFunction<V> {
		{
			$0.widthAnchor
				.constraint(equalTo: $0.heightAnchor, multiplier: ratio.width / ratio.height)
				.isActive = true
		}
	}

	static func setWidth<V: UIView>(_ width: CGFloat) -> StyleFunction<V> {
		{
			$0.widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}

	static func setHeight<V: UIView>(_ height: CGFloat) -> StyleFunction<V> {
		{
			$0.heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}

	static func setSize<V: UIView>(_ size: CGSize) -> StyleFunction<V> {
		setWidth(size.width) <> setHeight(size.height)
	}

	static func setRoundedBorders<V: UIView>(radius: CGFloat) -> StyleFunction<V> {
		{
			$0.layer.cornerRadius = radius
			$0.clipsToBounds = true
		}
	}

	static func setBorders<V: UIView>(color: UIColor, width: CGFloat) -> StyleFunction<V> {
		{
			$0.layer.borderColor = color.cgColor
			$0.layer.borderWidth = width
		}
	}

	static func setBackground<V: UIView>(color: UIColor) -> StyleFunction<V> {
		{
			$0.backgroundColor = color
		}
	}
}

extension UIButton {
	typealias StyleFunction<View: UIButton> = (View) -> Void

	static func setTitle<V: UIButton>(_ title: String?) -> StyleFunction<V> {
		{
			$0.setTitle(title, for: .normal)
		}
	}

	static func setImage<V: UIButton>(_ image: UIImage?) -> StyleFunction<V> {
		{
			$0.setImage(image, for: .normal)
		}
	}
}

extension UILabel {
	typealias StyleFunction<View: UILabel> = (View) -> Void

	static func setFont<V: UILabel>(_ font: UIFont) -> StyleFunction<V> {
		{
			$0.font = font
		}
	}

	static func setTextColor<V: UILabel>(_ color: UIColor) -> StyleFunction<V> {
		{
			$0.textColor = color
		}
	}

	static func setText<V: UILabel>(_ text: String) -> StyleFunction<V> {
		{
			$0.text = text
		}
	}

	static func setBodyStyle<V: UILabel>() -> StyleFunction<V> {
		setFont(.systemFont(ofSize: 14))
			<> setTextColor(.black)
	}

	static func setHeaderStyle<V: UILabel>() -> StyleFunction<V> {
		setFont(.systemFont(ofSize: 18, weight: .semibold))
			<> setTextColor(.black)
	}
}
