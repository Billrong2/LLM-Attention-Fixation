fn f(text: String, char: String) -> String {
    let split_text: Vec<&str> = text.split(&char).collect();
    split_text.join(" ")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a"), String::from("a")), String::from(" "));
}
