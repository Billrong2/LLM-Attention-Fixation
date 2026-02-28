fn f(text: String) -> String {
    let mut result = String::new();
    for (i, c) in text.chars().enumerate() {
        if i % 2 == 0 {
            result.push(c.to_ascii_uppercase());
        } else {
            result.push(c);
        }
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("vsnlygltaw")), String::from("VsNlYgLtAw"));
}
