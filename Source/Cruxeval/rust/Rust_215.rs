fn f(text: String) -> String {
    let mut new_text = text.clone();
    while new_text.len() > 1 && new_text.chars().next() == new_text.chars().rev().next() {
        new_text = new_text.chars().skip(1).take(new_text.len()-2).collect();
    }
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(")")), String::from(")"));
}
