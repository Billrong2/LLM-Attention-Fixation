fn f(text: String, char: String) -> String {
    let mut text = text.clone();
    if !text.is_empty() {
        text = text.trim_start_matches(&char).to_string();
        text = text.trim_start_matches(text.chars().last().unwrap()).to_string();
        let last_char = text.chars().last().unwrap().to_uppercase().to_string();
        let rest = text.chars().take(text.len() - 1).collect::<String>();
        text = rest + &last_char;
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("querist"), String::from("u")), String::from("querisT"));
}
