fn f(string: String) -> String {
    if string.is_empty() || !string.chars().next().unwrap_or_default().is_numeric() {
        return "INVALID".to_string();
    }
    let mut cur = 0;
    for c in string.chars() {
        if let Some(digit) = c.to_digit(10) {
            cur = cur * 10 + digit as usize;
        } else {
            return "INVALID".to_string();
        }
    }
    cur.to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("3")), String::from("3"));
}
