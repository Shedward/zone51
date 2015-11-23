puts (1..10).select(&:even?).join(', ')
puts ["one", "two", "three"].map(&:chars).join(', ')

class Point < Struct.new(:x, :y)
	def +(other_point)
		Point.new(x + other_poitn.x, y + other_point.y)
	end

	def inspect
		"#<Point {#{x}, #{y}}>"
	end
end