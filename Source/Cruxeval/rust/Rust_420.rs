fn f(text: String) -> bool {
    text.chars().all(|c| c.is_alphabetic())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("x")), true);
}
