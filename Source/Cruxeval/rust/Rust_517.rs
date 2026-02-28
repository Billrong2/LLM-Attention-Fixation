fn f(text: String) -> String {
    let len = text.len();
    for i in (1..len).rev() {
        if !text[i..i+1].chars().next().unwrap().is_uppercase() {
            return text[0..i].to_string();
        }
    }
    String::new()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("SzHjifnzog")), String::from("SzHjifnzo"));
}
