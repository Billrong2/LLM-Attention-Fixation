fn f(text: String, prefix: String) -> String {
    let mut idx = 0;
    for letter in prefix.chars() {
        if text.chars().nth(idx) != Some(letter) {
            return "".to_string();
        }
        idx += 1;
    }
    text[idx..].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("bestest"), String::from("bestest")), String::from(""));
}
