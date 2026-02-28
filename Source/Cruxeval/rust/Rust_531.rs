fn f(text: String, x: String) -> String {
    if text.strip_prefix(&x).is_none() || text.strip_prefix(&x).unwrap() == &text {
        if text.len() > 0 {
            f(text[1..].to_string(), x.clone())
        } else {
            String::new()
        }
    } else {
        text
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Ibaskdjgblw asdl "), String::from("djgblw")), String::from("djgblw asdl "));
}
