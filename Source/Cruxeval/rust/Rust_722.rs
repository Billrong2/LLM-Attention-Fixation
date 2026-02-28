fn f(text: String) -> String {
    let mut out = String::new();
    for c in text.chars() {
        if c.is_ascii_uppercase() {
            out.push(c.to_ascii_lowercase());
        } else {
            out.push(c.to_ascii_uppercase());
        }
    }
    out
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(",wPzPppdl/")), String::from(",WpZpPPDL/"));
}
