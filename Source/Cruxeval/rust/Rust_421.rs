fn f(s: String, n: isize) -> String {
    if s.len() < n as usize {
        s.clone()
    } else {
        s.strip_prefix(&s[..n as usize]).unwrap_or("").to_string()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("try."), 5), String::from("try."));
}
