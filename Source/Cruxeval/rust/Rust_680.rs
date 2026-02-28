fn f(text: String) -> String {
    let mut letters = String::new();
    for c in text.chars() {
        if c.is_alphanumeric() {
            letters.push(c);
        }
    }
    letters
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("we@32r71g72ug94=(823658*!@324")), String::from("we32r71g72ug94823658324"));
}
