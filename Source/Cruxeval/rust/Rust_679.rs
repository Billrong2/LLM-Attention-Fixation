fn f(text: String) -> bool {
    if text.is_empty() {
        return false;
    }
    let first_char = text.chars().next().unwrap();
    if first_char.is_numeric() {
        return false;
    }
    for last_char in text.chars() {
        if (last_char != '_') && !last_char.is_alphanumeric() {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("meet")), true);
}
