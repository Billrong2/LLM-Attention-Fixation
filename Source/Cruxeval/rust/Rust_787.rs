fn f(text: String) -> String {
    if text.len() == 0 {
        return String::from("");
    }
    let text = text.to_lowercase();
    let first_char = text.chars().next().unwrap().to_uppercase();
    let rest_of_text = &text[1..];
    let result = first_char.to_string() + rest_of_text;
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("xzd")), String::from("Xzd"));
}
