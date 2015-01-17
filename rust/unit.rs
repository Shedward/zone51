use std::ops::Add;

#[derive(Show, Copy)]
enum Inch {}

#[derive(Show, Copy)]
enum Mm {}

#[derive(Show, Copy)]
struct Length<Unit, T>(T,);

impl <Unit, T: Add<T> + Copy> Add<Length<Unit, T>> for Length<Unit, T> {
	fn add(self, r: Length<Unit, T>) -> Length<Unit, T> {
		let Length(ref left) = self;
		let Length(ref right) = r;

		Length(*left + *right)
	}
}

fn main() {
	let one_foot: Length<Inch, f32> = Length(12.0);
	let one_meter: Length<Mm, f32> = Length(1000.0);

	println!("one foot = {}", one_foot);
}