fn f(text: String) -> bool {
    for char in text.chars() {
        if !char.is_whitespace() {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("     i")), false);
}
