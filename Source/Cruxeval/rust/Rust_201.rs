fn f(text: String) -> String {
    let mut chars = Vec::new();
    for c in text.chars() {
        if c.is_numeric() {
            chars.push(c);
        }
    }
    chars.reverse();
    chars.into_iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("--4yrw 251-//4 6p")), String::from("641524"));
}
