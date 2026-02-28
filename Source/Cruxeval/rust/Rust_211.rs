fn f(s: String) -> isize {
    let mut count = 0;
    for c in s.chars() {
        if s.rfind(c).unwrap() != s.find(c).unwrap() {
            count += 1;
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("abca dea ead")), 10);
}
