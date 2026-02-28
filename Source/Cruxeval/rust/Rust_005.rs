fn f(text: String, lower: String, upper: String) -> (isize, String) {
    let mut count = 0;
    let mut new_text = String::new();
    for char in text.chars() {
        let char = if char.is_numeric() {
            lower.chars().next().unwrap()
        } else {
            upper.chars().next().unwrap()
        };
        if ['p', 'C'].contains(&char) {
            count += 1;
        }
        new_text.push(char);
    }
    (count, new_text)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("DSUWeqExTQdCMGpqur"), String::from("a"), String::from("x")), (0, String::from("xxxxxxxxxxxxxxxxxx")));
}
