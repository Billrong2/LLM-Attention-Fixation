fn f(text: String, pre: String) -> String {
    if !text.starts_with(&pre) {
        return text;
    }
    text.trim_start_matches(&pre).to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("@hihu@!"), String::from("@hihu")), String::from("@!"));
}
