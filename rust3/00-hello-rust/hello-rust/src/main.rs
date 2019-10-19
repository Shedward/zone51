use std::io;
use rand::Rng;
use std::cmp::Ordering;

fn main() {
    let guessed_number = rand::thread_rng().gen_range(1, 101);

    loop {
            println!("Please input your guess");
        let mut guess = String::new();
        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("{} is not a number", guess);
                continue;
            }
        };

        match guess.cmp(&guessed_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
                break;
            }
        }
    }
}