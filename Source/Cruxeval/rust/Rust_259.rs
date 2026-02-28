fn f(text: String) -> String {
    let mut new_text: Vec<char> = Vec::new();
    for character in text.chars() {
        if character.is_uppercase() {
            new_text.insert(new_text.len() / 2, character);
        }
    }
    if new_text.is_empty() {
        new_text = vec!['-'];
    }
    new_text.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("String matching is a big part of RexEx library.")), String::from("RES"));
}
