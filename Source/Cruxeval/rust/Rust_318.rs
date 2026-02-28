fn f(value: String, char: String) -> isize {
    let mut total = 0;
    for c in value.chars() {
        if c.to_string() == char || c.to_string().to_lowercase() == char {
            total += 1;
        }
    }
    total
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("234rtccde"), String::from("e")), 1);
}
