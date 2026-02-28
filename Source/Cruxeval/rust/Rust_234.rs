fn f(text: String, char: String) -> isize {
    let mut position = text.len();
    if text.contains(&char) {
        position = text.find(&char).unwrap_or(0);
        if position > 1 {
            position = (position + 1) % text.len();
        }
    }
    position as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wduhzxlfk"), String::from("w")), 0);
}
