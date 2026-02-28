fn f(text: String) -> String {
    let mut result = String::new();
    for space in text.chars() {
        if space == ' ' {
            result = text.strip_prefix(' ').unwrap_or(&text).to_string();
        } else {
            result = text.replace("cd", &space.to_string());
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("lorem ipsum")), String::from("lorem ipsum"));
}
