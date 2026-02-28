fn f(text: String, char: String) -> String {
    let mut text_chars: Vec<char> = text.chars().collect();
    for (index, item) in text_chars.iter().enumerate() {
        if *item == char.chars().next().unwrap() {
            text_chars.remove(index);
            return text_chars.iter().collect();
        }
    }
    text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("pn"), String::from("p")), String::from("n"));
}
