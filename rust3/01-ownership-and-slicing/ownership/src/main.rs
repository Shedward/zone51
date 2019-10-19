fn main() {
    let mut string = String::from("hello world");
    print_len(&string);
    duplicate_string(&mut string);
    print_len(&string);

    let first_word = first_word(&string);
    print_len(first_word);

    let words = words(&string);
    println!("Words count: {}", words.len());
    for word in words.iter() {
        print_len(word);
    }
}

fn print_len(s: &str) {
    println!("The length of '{}' is {}", s, s.len());
}

fn duplicate_string(string: &mut String) {
    string.push_str(&string.clone());
}

fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}

fn words(s: &str) -> Vec<&str> {
    let mut words = Vec::new();
    let bytes = s.as_bytes();
    let mut first_indx = 0;
    for (indx, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            words.push(&s[first_indx..indx]);
            first_indx = indx + 1;
        }
    }
    if first_indx < s.len() {
        words.push(&s[first_indx..]);
    }
    return words;
}