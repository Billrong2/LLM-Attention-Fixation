fn f(text: String) -> String {
    let mut text = text.replace(" x", " x.");
    if text.chars().all(|c| c.is_ascii_lowercase() || c == ' ' || c == 'x' || c == '.') {
        text = text.replace(" x.", " x");
        return String::from("mixed");
    }
    return String::from("correct");
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("398 Is A Poor Year To Sow")), String::from("correct"));
}
