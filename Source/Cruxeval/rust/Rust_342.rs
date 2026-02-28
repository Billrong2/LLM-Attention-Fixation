fn f(text: String) -> bool {
    text.matches('-').count() == text.len()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("---123-4")), false);
}
