fn f(text: String) -> String {
    for i in 0..text.len() {
        if text.get(0..i).unwrap_or_default().starts_with("two") {
            return text.get(i..).unwrap_or_default().to_string();
        }
    }
    "no".to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("2two programmers")), String::from("no"));
}
