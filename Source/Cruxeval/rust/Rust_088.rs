fn f(s1: String, s2: String) -> String {
    if s2.ends_with(&s1) {
        let len = s1.len();
        let (_, end) = s2.split_at(s2.len() - len);
        return end.to_string();
    }
    s2
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("he"), String::from("hello")), String::from("hello"));
}
