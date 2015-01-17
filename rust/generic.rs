use std::fmt;

struct Pair<T> {
	first: T,
	second: T,
}

impl <T> fmt::Show for Pair<T> {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {

	}
}

fn swap<T>(pair: Pair<T>) -> Pair<T> {
	let Pair { first, second } = pair;
	Pair { first: second, second: first }
}

struct Tuple2<T, U>(T, U);

fn main() {
	let pair_of_chars = Pair { first: 'a', second: 'b' };
	let pair_of_ints = Pair { first: 11, second: 2 };

	println!("swap 1: {}", swap(pair_of_chars));
}