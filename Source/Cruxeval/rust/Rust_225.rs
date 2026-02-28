fn f(text: String) -> bool {
    text.chars().all(|c| c.is_lowercase())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("54882")), false);
}
