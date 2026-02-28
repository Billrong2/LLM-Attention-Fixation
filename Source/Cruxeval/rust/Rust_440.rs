fn f(text: String) -> String {
    if text.chars().all(|c| c.is_numeric()) {
        "yes".to_string()
    } else {
        "no".to_string()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abc")), String::from("no"));
}
