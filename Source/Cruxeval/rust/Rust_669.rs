fn f(t: String) -> String {
    let parts: Vec<&str> = t.rsplitn(2, '-').collect();
    let a = parts.get(1).unwrap_or(&"");
    let b = parts.get(0).unwrap_or(&"");
    if b.len() == a.len() {
        return String::from("imbalanced");
    }
    return a.to_string() + b
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("fubarbaz")), String::from("fubarbaz"));
}
