fn f(text: String) -> String {
    let mut a = Vec::new();
    for c in text.chars() {
        if !c.is_numeric() {
            a.push(c);
        }
    }
    a.iter().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("seiq7229 d27")), String::from("seiq d"));
}
