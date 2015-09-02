use std::sync::{Arc, Mutex};  
use std::sync::mpsc;

fn main() {
	let data = Arc::new(Mutex::new(0u32));

	let count = 10;

	let (tx, rx) = mpsc::channel();

	for _ in 0..count {
		let data = data.clone();
		let tx = tx.clone();

		thread.spawn(move || {
			let mut data = data.lock().unwrap();
			*data += 1;

			tx.send(*data);
		});
	}

	for i in 0..count {
		println!("Received from {}: {}", i, rx.recv().unwrap());
	}
}