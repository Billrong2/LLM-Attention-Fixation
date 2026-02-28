fn f(txt: String) -> String {
    let mut d = String::new();
    for c in txt.chars() {
        if c.is_numeric() {
            continue;
        }
        if c.is_lowercase() {
            d.push(c.to_uppercase().to_string().chars().next().unwrap());
        } else if c.is_uppercase() {
            d.push(c.to_lowercase().to_string().chars().next().unwrap());
        }
    }
    d
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("5ll6")), String::from("LL"));
}
