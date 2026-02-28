fn f(text: String) -> String {
    let mut chars = text.chars();
    let last_char = chars.next_back().unwrap();
    let rest_of_text: String = chars.collect();
    format!("{}{}", last_char, rest_of_text)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hellomyfriendear")), String::from("rhellomyfriendea"));
}
