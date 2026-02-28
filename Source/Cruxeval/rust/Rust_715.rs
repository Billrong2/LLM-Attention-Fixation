fn f(text: String, char: String) -> bool {
    text.matches(&char).count() % 2 != 0
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abababac"), String::from("a")), false);
}
