fn f(text: String, value: String) -> String {
    text.trim_start_matches(value.to_lowercase().as_str()).to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("coscifysu"), String::from("cos")), String::from("cifysu"));
}
