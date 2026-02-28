fn f(text: String) -> String {
    if text.contains(",") {
        let (before, rest) = text.split_at(text.find(",").unwrap());
        let after = &rest[1..];
        return after.to_string() + " " + before;
    }
    String::from(",") + &text.split_whitespace().last().unwrap() + " 0"
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("244, 105, -90")), String::from(" 105, -90 244"));
}
