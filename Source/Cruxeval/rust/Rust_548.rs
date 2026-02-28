fn f(text: String, suffix: String) -> String {
    if !suffix.is_empty() && !text.is_empty() && text.ends_with(&suffix) {
        text.trim_end_matches(&suffix).to_string()
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("spider"), String::from("ed")), String::from("spider"));
}
