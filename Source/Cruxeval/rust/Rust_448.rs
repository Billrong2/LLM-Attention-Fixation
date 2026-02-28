fn f(text: String, suffix: String) -> bool {
    text.ends_with(suffix.as_str())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("uMeGndkGh"), String::from("kG")), false);
}
