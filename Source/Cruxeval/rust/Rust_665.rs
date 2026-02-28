fn f(chars: String) -> String {
    let mut s = String::new();
    for ch in chars.chars() {
        if chars.matches(ch).count() % 2 == 0 {
            s.push(ch.to_ascii_uppercase());
        } else {
            s.push(ch);
        }
    }
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("acbced")), String::from("aCbCed"));
}
