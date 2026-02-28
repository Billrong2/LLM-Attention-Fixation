fn f(text: String, chars: String) -> String {
    text.trim_end_matches(&chars).to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ha"), String::from("")), String::from("ha"));
}
