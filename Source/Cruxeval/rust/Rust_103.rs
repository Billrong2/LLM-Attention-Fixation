fn f(s: String) -> String {
    s.to_lowercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abcDEFGhIJ")), String::from("abcdefghij"));
}
