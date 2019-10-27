use std::collections::HashMap;

fn main() {
    let v = vec![1, 2, 3];
    println!("{:?}", v);

    let second = v.get(2).unwrap_or(&-1);
    println!("{:?}", second);

    let mut mut_v = v;

    let dup_indexes = vec![0, 2, 3, 14];
    for indx in dup_indexes {
        if let Some(value) = mut_v.get_mut(indx) {
            duplicate(value)
        }
    }
    println!("{:?}", mut_v);

    let string = String::from("Some weird text");
    let rev_string: String = string.chars().rev().collect();
    println!("{:?}", rev_string);

    let string = String::from(r#"
        It’s common to check whether a particular key has a value and, 
        if it doesn’t, insert a value for it. Hash maps have a special 
        API for this called entry that takes the key you want to check as a parameter. 
        The return value of the entry method is an enum called Entry that represents 
        a value that might or might not exist. Let’s say we want to check whether 
        the key for the Yellow team has a value associated with it. If it doesn’t, 
        we want to insert the value 50, and the same for the Blue team. 
        Using the entry API, the code looks like Listing 8-25.
        "#
    );
    let count = count_words(string);
    println!("{:?}", count);
}

fn duplicate(val: &mut i32) {
    *val *= 2;
}

fn count_words(string: String) -> HashMap<String, i32> {
    let mut count = HashMap::new();
    string.split_ascii_whitespace().for_each(|word| {
        let norm_word = word.to_lowercase();
        let val = count.get(&norm_word).unwrap_or(&0);
        count.insert(norm_word, *val + 1);
    });
    return count;
}
