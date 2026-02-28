fn f(text: String, to_place: String) -> String {
    let after_place = text[..text.find(&to_place).unwrap_or(0) + 1].to_string();
    let before_place = text[text.find(&to_place).unwrap_or(0) + 1..].to_string();
    after_place + &before_place
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("some text"), String::from("some")), String::from("some text"));
}
