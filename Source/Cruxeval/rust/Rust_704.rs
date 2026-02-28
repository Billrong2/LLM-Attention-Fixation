fn f(s: String, n: usize, c: String) -> String {
    let width = c.len() * n;
    let mut new_s = s.clone();
    while new_s.len() < width {
        new_s = format!("{}{}", c, new_s);
    }
    new_s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("."), 0, String::from("99")), String::from("."));
}
