extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number:");
    println!("Please input your guess.");

    let secret_number = rand::thread_rng().gen_range(1, 101);
    println!("Guessed num: {}", secret_number);

    let mut guess = String::new();	
    io::stdin().read_line(&mut guess)
    	.ok()
    	.expect("Failed to read line");

    let guess: u32 = guess.trim().parse()
    	.ok()
    	.expect("Inputed string not a number");

    println!("You guessed: {}", guess);

    match guess.cmp(&secret_number) {
    	Ordering::Less    => println!("Too small"),
    	Ordering::Greater => println!("Too big"),
    	Ordering::Equal   => println!("You win")
    }
}
