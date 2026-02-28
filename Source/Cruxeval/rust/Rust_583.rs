fn f(text: String, ch: String) -> String {
    let mut result = vec![];
    for line in text.lines() {
        if !line.is_empty() && line.chars().next() == Some(ch.chars().next().unwrap()) {
            result.push(line.to_lowercase());
        } else {
            result.push(line.to_uppercase());
        }
    }
    result.join("\n")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("t
za
a"), String::from("t")), String::from("t
ZA
A"));
}
