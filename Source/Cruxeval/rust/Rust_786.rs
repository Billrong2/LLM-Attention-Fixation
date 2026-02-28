fn f(text: String, letter: String) -> String {
    if text.contains(&letter) {
        let start = text.find(&letter).unwrap();
        return text[start + 1..].to_string() + &text[..start + 1];
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("19kefp7"), String::from("9")), String::from("kefp719"));
}
