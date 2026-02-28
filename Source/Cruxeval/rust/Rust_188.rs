fn f(strings: Vec<String>) -> Vec<String> {
    let mut new_strings: Vec<String> = Vec::new();
    for string in strings {
        let first_two = string.chars().take(2).collect::<String>();
        if first_two.starts_with('a') || first_two.starts_with('p') {
            new_strings.push(first_two);
        }
    }
    new_strings
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![String::from("a"), String::from("b"), String::from("car"), String::from("d")]), vec![String::from("a")]);
}
