
//! The `adder` allow sum two integer numbers
//!
//! # Examples
//!
//! ```
//! assert_eq!(4, adder::adder(2, 2))
pub fn adder(lhs:i32, rhs:i32) -> i32 {
	lhs + rhs
}

#[test]
fn it_works() {
	assert_eq!(adder(2, 2), 4);
	assert_eq!(adder(-1, 1), 0);
}

#[test]
#[should_panic]
fn error_tests() {
	assert_eq!(adder(0x00FF, 0xFF00), 0xFFF0);
}