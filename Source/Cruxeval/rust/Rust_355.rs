fn f(text: String, prefix: String) -> String {
    text[prefix.len()..].to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("123x John z"), String::from("z")), String::from("23x John z"));
}
