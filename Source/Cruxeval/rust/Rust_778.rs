fn f(prefix: String, text: String) -> String {
    if text.starts_with(&prefix) {
        text
    } else {
        format!("{}{}", prefix, text)
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mjs"), String::from("mjqwmjsqjwisojqwiso")), String::from("mjsmjqwmjsqjwisojqwiso"));
}
