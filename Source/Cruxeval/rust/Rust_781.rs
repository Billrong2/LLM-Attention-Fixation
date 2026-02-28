fn f(s: String, ch: String) -> String {
    if !s.contains(&ch) {
        return String::new();
    }
    let mut s = s.splitn(2, &ch).collect::<Vec<&str>>()[1].chars().rev().collect::<String>();
    for _ in 0..s.len() {
        s = s.splitn(2, &ch).collect::<Vec<&str>>()[1].chars().rev().collect::<String>();
    }
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("shivajimonto6"), String::from("6")), String::from(""));
}
