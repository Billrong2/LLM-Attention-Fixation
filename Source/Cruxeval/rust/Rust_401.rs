fn f(text: String, suffix: String) -> String {
    if suffix != "" && text.ends_with(&suffix) {
        text[..text.len() - suffix.len()].to_string()
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("mathematics"), String::from("example")), String::from("mathematics"));
}
