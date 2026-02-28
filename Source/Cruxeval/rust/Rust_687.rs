fn f(text: String) -> String {
    let mut t: Vec<String> = text.chars().map(|c| c.to_string()).collect();
    t.remove(t.len() / 2);
    t.push(text.to_lowercase());
    t.join(":")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Rjug nzufE")), String::from("R:j:u:g: :z:u:f:E:rjug nzufe"));
}
