
#[derive(Debug, Clone, Copy)]
struct Color(i32, i32, i32);

#[derive(Debug, Clone, Copy)]
struct Point(i32, i32);

#[derive(Debug, Clone, Copy)]
struct Line {
    start: Point,
    end: Point
}

impl Line {
    fn length(&self) -> f32 {
        let d0 = (self.start.0 - self.end.0) as f32;
        let d1 = (self.start.1 - self.end.1) as f32;
        return (d0 * d0 + d1 * d1).sqrt();
    }
}

fn main() {
    let origin = Point(0, 0);

    let i = Line { start: origin.clone(), end: Point(1, 0) };
    let j = Line { start: origin.clone(), end: Point(0, 1) };

    let basis = ( i, j );

    println!("Basis: {:?}", basis);
    println!("Length of i: {}", &i.length());
}
