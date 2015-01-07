// This code is editable and runnable!
fn main() {
    // A simple integer calculator:
    // `+` or `-` means add or subtract by 1
    // `*` or `/` means multiply or divide by 2

    let program = "+ + * - /";

    let res = compile(program, 0i);
    println!("The program \"{}\" calculates the value {}",
              program, res);

    println!("Check zero point {}", test_matching(Point(0,0,0)));
    println!("Check x point {}", test_matching(Point(0,5,2)));
    
    let req = request();
    let Response { auth_token: (id, name), .. } = req;
    println!("Logged [{:x}] {}", id, name);

    if req.err_code > 0 {
    	println!("Error: {}", req.answer);
    }
}

fn compile(program: &str,  init: int) -> int{
	let mut acc = init;
    for token in program.chars() {
        match token {
            '+' => acc += 1,
            '-' => acc -= 1,
            '*' => acc *= 2,
            '/' => acc /= 2,
            'a'...'z' => acc += 5,
            _ => { /* ignore everything else */ }
        }
    }
    return acc;
}

struct Point(i32, i32, i32);
struct Response { 
	answer : String, 
	err_code : uint,
	auth_token : (u32, String)
}

fn request() -> Response {
	return Response {
		answer : "error".to_string(),
		err_code : 404,
		auth_token : (0x251BB52u32, "Shedward".to_string())
	}
}

fn test_matching(p : Point) -> &'static str {
	match p {
		Point(0, 0, 0) => "null",
		Point(0, _, _) => "on x",
		Point(_, 0, _) => "on y",
		Point(_, _, 0) => "on z",
		_ => "otherwise"
	}
}