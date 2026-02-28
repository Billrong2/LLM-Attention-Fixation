fn f(text: String) -> String {
    let mut result = String::new();
    for (i, ch) in text.chars().enumerate() {
        if ch == ch.to_ascii_lowercase() {
            continue;
        }
        if text.len() - 1 - i < text.rfind(ch.to_ascii_lowercase()).unwrap() {
            result.push(ch);
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ru")), String::from(""));
}
