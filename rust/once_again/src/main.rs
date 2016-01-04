
fn find(haystack: &str, needle: char) -> Option<usize> {
	for (offcet, c) in haystack.char_indices() {
		if c == needle {
			return Some(offcet);
		}
	}

	None
}

fn and_then<F, T, A>(option: Option<T>, f: F) -> Option<A>
	where F: FnOnce(T) -> Option<A> {
		match option {
		    Some(value) => f(value),
		    None => None,
		}
}


fn main() {
    let file_name = "foobar.rs";

    match find(file_name, '.') {
        Some(ext_indx) => println!("File extension: {}", &file_name[ext_indx+1..]),
        None => println!("No file extension."),
    }
}