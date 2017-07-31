extern crate num;

pub mod geometry {
    use std::cmp;
    use num;

    pub trait DimenstionMetric: num::Integer + Copy { }

    impl DimenstionMetric for i32 { }
    impl DimenstionMetric for i64 { }

    #[derive(Debug)]
    pub struct Point<T: DimenstionMetric> {
        pub x: T,
        pub y: T
    }

    impl<T: DimenstionMetric> cmp::PartialEq for Point<T> {
        fn eq(&self, other: &Point<T>) -> bool {
            self.x == other.x && self.y == other.y
        }
    }

    #[derive(Debug)]
    pub struct Size<T: DimenstionMetric> {
        pub width: T,
        pub height: T
    }

    impl<T: DimenstionMetric> cmp::PartialEq for Size<T> {
        fn eq(&self, other: &Size<T>) -> bool {
            self.width == other.width && self.height == other.height
        }
    }

    #[derive(Debug)]
    pub struct Rect<T: DimenstionMetric> {
        pub origin: Point<T>,
        pub size: Size<T>
    }

    impl<T: DimenstionMetric> Rect<T> {
        pub fn new(x: T, y: T, width: T, height: T) -> Rect<T> {
            Rect {
                origin: Point { x: x, y: y },
                size: Size { width: width, height: height }
            }
        }

        pub fn corner_point(&self) -> Point<T> {
            return Point {
                x: self.origin.x + self.size.width,
                y: self.origin.y + self.size.height
            }
        }
    }

    impl<T: DimenstionMetric> cmp::PartialEq for Rect<T> {
        fn eq(&self, other: &Rect<T>) -> bool {
            self.origin == other.origin && self.size == other.size
        }
    }

    impl<T: DimenstionMetric> Rect<T> {
        pub fn intersection(&self, other: &Rect<T>) -> Option<Rect<T>> {
            if self.intersects(other) {
                let min_x = cmp::max(self.origin.x, other.origin.x);
                let max_x = cmp::min(self.corner_point().x, other.corner_point().x);
                let min_y = cmp::max(self.origin.y, other.origin.y);
                let max_y = cmp::min(self.corner_point().y, other.corner_point().y);

                Some(Rect {
                    origin: Point { x: min_x, y: min_y },
                    size: Size { width: max_x - min_x, height: max_y - min_y }
                })
            } else {
                None
            }
        }

        pub fn intersects(&self, other: &Rect<T>) -> bool {
            let is_intersects_horizontally =
                (self.origin.x <= other.origin.x && other.origin.x <= self.corner_point().x) ||
                    (self.origin.x <= other.corner_point().x && other.corner_point().x <= self.corner_point().x);

            let is_intersects_vertically =
                (self.origin.y <= other.origin.y && other.origin.y <= self.corner_point().y) ||
                    (self.origin.y <= other.corner_point().y && other.corner_point().y <= self.corner_point().y);

            return is_intersects_horizontally && is_intersects_vertically;
        }

        pub fn contains(&self, other: &Rect<T>) -> bool {
            let is_contains_vertically =
                self.origin.x <= other.origin.x && self.corner_point().x >= other.corner_point().x;
            let is_contains_horizontally =
                self.origin.y <= other.origin.y && self.corner_point().x >= other.corner_point().y;

            return is_contains_horizontally && is_contains_vertically;
        }
    }
}
