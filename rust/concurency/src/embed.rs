use std::thread;

#[no_mangle]
pub fn process() {
	let handles: Vec<_> = (0..10).map(|_| {
		thread::spawn(|| {
			let mut x = 0;
			for _ in (0..5_000_000) {
				x += 1
			}

			x
		})
	}).collect();

	for h in handles {
		let res = h.join().map_err(|_| "Could not join a thread.").unwrap();
		println!("Thread finished wifh count={}", res);
	}

	println!("Done!");
}