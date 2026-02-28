fn f(text: String, suffix: String) -> String {
    let mut text = text.clone();
    text.push_str(&suffix);
    while text[text.len() - suffix.len()..] == suffix {
        text.pop();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("faqo osax f"), String::from("f")), String::from("faqo osax "));
}
