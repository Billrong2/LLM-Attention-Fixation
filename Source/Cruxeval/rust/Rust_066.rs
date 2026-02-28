fn f(text: String, prefix: String) -> String {
    let prefix_length = prefix.len();
    if text.starts_with(&prefix) {
        return "".to_string();
    } else {
        return text;
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("happy"), String::from("ha")), String::from(""));
}
