fn f(text: String) -> String {
    let mut uppers = 0;
    for c in text.chars() {
        if c.is_uppercase() {
            uppers += 1;
        }
    }
    
    if uppers >= 10 {
        text.to_uppercase()
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("?XyZ")), String::from("?XyZ"));
}
