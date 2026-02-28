fn f(challenge: String) -> String {
    challenge.to_lowercase().replace("l", ",")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("czywZ")), String::from("czywz"));
}
