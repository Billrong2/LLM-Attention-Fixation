fn f(text: String) -> String {
    let mut result = String::new();
    
    for c in text.chars() {
        if !c.is_ascii() {
            return String::from("False");
        } else if c.is_alphanumeric() {
            result.push(c.to_ascii_uppercase());
        } else {
            result.push(c);
        }
    }
    
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ua6hajq")), String::from("UA6HAJQ"));
}
