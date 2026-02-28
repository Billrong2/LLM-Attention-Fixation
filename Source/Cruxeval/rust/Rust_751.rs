fn f(text: String, char: String, min_count: usize) -> String {
    let count = text.matches(&char).count();
    if count < min_count {
        return text.to_ascii_uppercase();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("wwwwhhhtttpp"), String::from("w"), 3), String::from("wwwwhhhtttpp"));
}
