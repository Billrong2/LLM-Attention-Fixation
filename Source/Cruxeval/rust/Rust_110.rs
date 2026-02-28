fn f(text: String) -> isize {
    let mut a = vec!["".to_string()];
    let mut b = String::new();
    for i in text.chars() {
        if !i.is_whitespace() {
            a.push(b.clone());
            b.clear();
        } else {
            b.push(i);
        }
    }
    a.len() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("       ")), 1);
}
