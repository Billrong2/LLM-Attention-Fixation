fn f(s: String, n: String) -> bool {
    s.to_lowercase() == n.to_lowercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("daaX"), String::from("daaX")), true);
}
