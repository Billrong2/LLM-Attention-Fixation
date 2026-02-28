fn f(text: String, letter: String) -> String {
    let mut new_text = String::new();
    let mut changed_letter = letter.clone();
    
    if letter.chars().next().unwrap().is_ascii_lowercase() {
        changed_letter = letter.to_ascii_uppercase();
    }

    for char in text.chars() {
        if char.to_ascii_lowercase() == changed_letter.chars().next().unwrap() {
            new_text.push(changed_letter.chars().next().unwrap());
        } else {
            new_text.push(char);
        }
    }

    new_text = new_text.to_lowercase();
    new_text.replace_range(..1, &new_text[..1].to_uppercase());

    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("E wrestled evil until upperfeat"), String::from("e")), String::from("E wrestled evil until upperfeat"));
}
