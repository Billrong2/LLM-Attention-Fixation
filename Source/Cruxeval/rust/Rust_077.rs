fn f(text: String, character: String) -> String {
    let start_index = text.rfind(&character).unwrap_or(0);
    let subject = &text[start_index..];
    let count = text.matches(&character).count();
    subject.repeat(count)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("h ,lpvvkohh,u"), String::from("i")), String::from(""));
}
