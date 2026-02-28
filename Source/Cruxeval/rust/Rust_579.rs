fn f(text: String) -> String {
    if let Some(c) = text.chars().next() {
        if text.to_uppercase() == text && text.len() > 1 {
            let mut chars = text.chars().collect::<Vec<_>>();
            chars[0] = c.to_lowercase().next().unwrap();
            return chars.into_iter().collect::<String>();
        } else if text.chars().all(char::is_alphabetic) {
            let mut chars = text.chars().collect::<Vec<_>>();
            chars[0] = chars[0].to_uppercase().next().unwrap();
            return chars.into_iter().collect::<String>();
        }
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("")), String::from(""));
}
