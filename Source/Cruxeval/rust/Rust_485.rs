fn f(tokens: String) -> String {
    let mut tokens: Vec<&str> = tokens.split_whitespace().collect();
    if tokens.len() == 2 {
        tokens.reverse();
    }
    format!("{:<5} {:<5}", tokens[0], tokens[1])
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("gsd avdropj")), String::from("avdropj gsd  "));
}
