fn f(text: String) -> String {
    let mut new_text = String::new();
    for ch in text.to_lowercase().trim().chars() {
        if ch.is_numeric() || ch == 'Ä' || ch == 'ä' || ch == 'Ï' || ch == 'ï' || ch == 'Ö' || ch == 'ö' || ch == 'Ü' || ch == 'ü' {
            new_text.push(ch);
        }
    }
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("")), String::from(""));
}
