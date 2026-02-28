fn f(text: String, char: String) -> String {
    if !text.ends_with(&char) {
        return f(char.clone() + &text, char.clone());
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("staovk"), String::from("k")), String::from("staovk"));
}
