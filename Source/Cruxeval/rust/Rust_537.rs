fn f(text: String, value: String) -> String {
    let mut new_text: Vec<char> = text.chars().collect();
    new_text.push(value.chars().nth(0).unwrap_or(' '));
    let length = new_text.len();
    format!("[{}]", length)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abv"), String::from("a")), String::from("[4]"));
}
