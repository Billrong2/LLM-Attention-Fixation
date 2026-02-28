fn f(text: String) -> String {
    let length = text.len() / 2;
    let left_half = &text[0..length];
    let right_half = text[length..].chars().rev().collect::<String>();
    format!("{}{}", left_half, right_half)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("n")), String::from("n"));
}
