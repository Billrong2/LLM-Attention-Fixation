use std::collections::HashMap;

fn f(text: String) -> HashMap<String, isize> {
    let mut freq = HashMap::new();
    for c in text.to_lowercase().chars() {
        *freq.entry(c.to_string()).or_insert(0) += 1;
    }
    freq
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("HI")), HashMap::from([(String::from("h"), 1), (String::from("i"), 1)]));
}
