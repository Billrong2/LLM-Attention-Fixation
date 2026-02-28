fn f(text: String) -> String {
    let new_text: String = text.chars().map(|c| if c.is_numeric() {c} else {'*'}).collect();
    new_text
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("5f83u23saa")), String::from("5*83*23***"));
}
