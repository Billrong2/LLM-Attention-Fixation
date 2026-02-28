fn f(text: String, char: String, replace: String) -> String {
    text.replace(&char, &replace)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a1a8"), String::from("1"), String::from("n2")), String::from("an2a8"));
}
