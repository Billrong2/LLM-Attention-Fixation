fn f(text: String) -> bool {
    for c in text.chars() {
        if !c.is_numeric() {
            return false;
        }
    }
    !text.is_empty()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("99")), true);
}
