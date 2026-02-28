fn f(text: String) -> String {
    for punct in vec!['!', '.', '?', ',', ':', ';'] {
        if text.matches(punct).count() > 1 {
            return String::from("no");
        }
        if text.ends_with(punct) {
            return String::from("no");
        }
    }
    let mut new_text: String = String::new();
    for (i, c) in text.chars().enumerate() {
        if i == 0 {
            new_text.push_str(&c.to_uppercase().to_string());
        } else {
            new_text.push(c);
        }
    }
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("djhasghasgdha")), String::from("Djhasghasgdha"));
}
