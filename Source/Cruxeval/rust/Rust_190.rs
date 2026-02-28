fn f(text: String) -> String {
    let mut short = String::new();
    for c in text.chars() {
        if c.is_lowercase() {
            short.push(c);
        }
    }
    short
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("980jio80jic kld094398IIl ")), String::from("jiojickldl"));
}
