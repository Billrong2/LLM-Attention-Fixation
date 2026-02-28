fn f(text: String) -> bool {
    let mut chars: Vec<char> = text.chars().collect();
    *chars.first_mut().unwrap() = chars.last().unwrap().to_uppercase().next().unwrap();
    *chars.last_mut().unwrap() = chars.first().unwrap().to_uppercase().next().unwrap();
    let new_text: String = chars.into_iter().collect();
    let words: Vec<&str> = new_text.split_whitespace().collect();
    words.iter().all(|word| word.chars().next().unwrap().is_uppercase() && word[1..].chars().all(|c| c.is_lowercase()))
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Josh")), false);
}
