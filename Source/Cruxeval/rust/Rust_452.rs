fn f(text: String) -> isize {
    let mut counter = 0;
    for char in text.chars() {
        if char.is_alphabetic() {
            counter += 1;
        }
    }
    counter
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("l000*")), 1);
}
