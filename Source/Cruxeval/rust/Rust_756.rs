fn f(text: String) -> String {
    if !text.is_empty() && text.chars().all(|c| c.is_digit(10)) {
        return String::from("integer");
    }
    String::from("string")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("")), String::from("string"));
}
