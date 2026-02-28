fn f(text: String, prefix: String) -> String {
    let mut text = text;
    while text.starts_with(&prefix) {
        text = text[prefix.len()..].to_string();
        if text.is_empty() {
            break;
        }
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ndbtdabdahesyehu"), String::from("n")), String::from("dbtdabdahesyehu"));
}
