fn f(text: String, letter: String) -> isize {
    let mut counts = std::collections::HashMap::new();
    for char in text.chars() {
        let count = counts.entry(char.to_string()).or_insert(0);
        *count += 1;
    }
    *counts.get(&letter).unwrap_or(&0)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("za1fd1as8f7afasdfam97adfa"), String::from("7")), 2);
}
