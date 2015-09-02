use std::thread;
use std::sync::{Arc, Mutex};

fn main() {

    let ints = Arc::new(Mutex::new(vec![1u32, 2, 3]));

    for i in 0..3 {
    	let data = ints.clone();

    	thread::spawn(move || {
    		let mut data = data.lock().unwrap();
    		println!("Hello from thread {}", data[i]);
    		data[i] += 1;
    	});
    }

    thread::sleep_ms(50);
}
