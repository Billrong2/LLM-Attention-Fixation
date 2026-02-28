fn f(text: String, pref: String) -> String {
    let length = pref.len();
    if pref == &text[0..length] {
        return text.chars().skip(length).collect();
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("kumwwfv"), String::from("k")), String::from("umwwfv"));
}
