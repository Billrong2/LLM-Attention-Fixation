fn f(s: String) -> String {
    if s.chars().all(char::is_alphabetic) {
        return String::from("yes");
    }
    if s.is_empty() {
        return String::from("str is empty");
    }
    return String::from("no");
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Boolean")), String::from("yes"));
}
