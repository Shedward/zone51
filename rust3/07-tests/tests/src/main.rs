use std::ops::{ Add, Sub, Mul };

#[derive(Debug, Clone, Copy)]
struct Point {
    x: f32,
    y: f32
}

impl Add for Point {
    type Output = Self;

    fn add(self, other: Point) -> Point {
        Point {
            x: self.x + other.x,
            y: self.y + other.y
        }
    }
}

impl Sub for Point {
    type Output = Self;

    fn sub(self, other: Point) -> Point {
        Point {
            x: self.x - other.x,
            y: self.y - other.y
        }
    }
}

struct Line {
    start: Point,
    end: Point
}

impl Line {
    fn length(self) -> f32 {
        let dx = self.end.x - self.start.x;
        let dy = self.end.y - self.start.y;
        (dx * dx + dy * dy).sqrt()
    }

    fn reversed(self) -> Line {
        Line {
            start: self.end,
            end: self.start
        }
    }
}

fn main() {

}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn check_length() {
        let base_line = Line { 
            start: Point { x: 0.0, y: 0.0 },
            end: Point { x: 1.0, y: 0.0 }
        };
        assert_eq!(base_line.length(), 1.0);

        let line2 = Line {
            start: Point { x: 3.0, y: 11.0 },
            end: Point { x: 7.0, y: 5.0 }
        };
        assert_eq!(line2.length(), line2.reversed().length());
    }
}