fn f(name: String) -> Vec<String> {
    vec![name.chars().nth(0).unwrap().to_string(), name.chars().nth(1).unwrap().to_string()]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("master. ")), vec![String::from("m"), String::from("a")]);
}
