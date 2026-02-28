fn f(text: String, prefix: String) -> String {
    if text.starts_with(&prefix) {
        text.trim_start_matches(&prefix).to_string()
    } else if text.contains(&prefix) {
        text.replace(&prefix, "").trim().to_string()
    } else {
        text.to_uppercase()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abixaaaily"), String::from("al")), String::from("ABIXAAAILY"));
}
