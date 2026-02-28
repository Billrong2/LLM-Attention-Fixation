fn f(text: String) -> bool {
    let valid_chars = vec!['-', '_', '+', '.', '/', ' '];
    let text = text.to_uppercase();
    for char in text.chars() {
        if !char.is_alphanumeric() && !valid_chars.contains(&char) {
            return false;
        }
    }
    true
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW")), false);
}
