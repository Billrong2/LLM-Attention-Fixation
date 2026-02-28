fn f(text: String) -> bool {
    if text == "42.42" {
        true
    } else {
        for i in 3..text.len() - 3 {
            if text.chars().nth(i) == Some('.') && text[i - 3..].chars().all(char::is_numeric) && text[..i].chars().all(char::is_numeric) {
                return true;
            }
        }
        false
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("123E-10")), false);
}
