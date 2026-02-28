fn f(text: String, length: isize) -> String {
    let mut length = if length < 0 { -length } else { length };
    let mut output = String::new();
    
    for idx in 0..length {
        if text.chars().nth(idx as usize % text.len()).unwrap() != ' ' {
            output.push(text.chars().nth(idx as usize % text.len()).unwrap());
        } else {
            break;
        }
    }
    
    output
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("I got 1 and 0."), 5), String::from("I"));
}
