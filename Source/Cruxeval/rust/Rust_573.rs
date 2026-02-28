fn f(string: String, prefix: String) -> String {
    if string.starts_with(&prefix) {
        string.trim_start_matches(&prefix).to_string()
    } else {
        string
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Vipra"), String::from("via")), String::from("Vipra"));
}
