fn f(text: String) -> String {
    let mut odd = String::new();
    let mut even = String::new();
    for (i, c) in text.chars().enumerate() {
        if i % 2 == 0 {
            even.push(c);
        } else {
            odd.push(c);
        }
    }
    even + &odd.to_lowercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Mammoth")), String::from("Mmohamt"));
}
