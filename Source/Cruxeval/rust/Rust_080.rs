fn f(s: String) -> String {
    s.trim_end().chars().rev().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ab        ")), String::from("ba"));
}
