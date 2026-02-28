fn f(s: String) -> Vec<String> {
    let mut keys: Vec<String> = Vec::new();
    for c in s.chars() {
        if !keys.contains(&c.to_string()) {
            keys.push(c.to_string());
        }
    }
    keys
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("12ab23xy")), vec![String::from("1"), String::from("2"), String::from("a"), String::from("b"), String::from("3"), String::from("x"), String::from("y")]);
}
