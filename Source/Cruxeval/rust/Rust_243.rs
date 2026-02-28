fn f(text: String, char: String) -> bool {
    char.chars().next().unwrap().is_lowercase() && text.chars().all(|c| c.is_lowercase())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abc"), String::from("e")), true);
}
