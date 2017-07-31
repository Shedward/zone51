mod options;

use std::env;

fn main() {
    let arguments: Vec<_> = env::args().collect();
    let options = options::Options::new(&arguments);
    println!("Arguments {:?}", options);
}
