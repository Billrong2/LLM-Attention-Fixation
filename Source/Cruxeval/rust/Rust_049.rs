fn f(text: String) -> String {
    if text.chars().all(|c| c.is_alphanumeric()) {
        text.chars().filter(|c| c.is_numeric()).collect()
    } else {
        text.chars().collect()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("816")), String::from("816"));
}
