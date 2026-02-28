fn f(text: String) -> String {
    let mut i = 0;
    while i < text.len() && text.chars().nth(i).unwrap().is_whitespace() {
        i += 1;
    }
    if i == text.len() {
        return String::from("space");
    }
    return String::from("no");
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("     ")), String::from("space"));
}
