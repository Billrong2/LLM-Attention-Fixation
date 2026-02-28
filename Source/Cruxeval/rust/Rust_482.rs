fn f(text: String) -> String {
    text.replace(r#"\\"#, "\"").to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Because it intrigues them")), String::from("Because it intrigues them"));
}
