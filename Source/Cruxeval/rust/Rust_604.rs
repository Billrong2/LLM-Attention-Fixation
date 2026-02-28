fn f(text: String, start: String) -> bool {
    text.starts_with(&start)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Hello world"), String::from("Hello")), true);
}
