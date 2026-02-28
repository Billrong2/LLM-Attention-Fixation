fn f(text: String, search: String) -> bool {
    search.starts_with(&text)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("123"), String::from("123eenhas0")), true);
}
