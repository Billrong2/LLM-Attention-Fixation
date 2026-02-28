fn f(s: String) -> (String, String) {
    let s_bytes = s.as_bytes();
    let len = s_bytes.len();
    if s_bytes[len - 5..].iter().all(u8::is_ascii) {
        (s[len - 5..].to_string(), s[0..3].to_string())
    } else if s_bytes[..5].iter().all(u8::is_ascii) {
        let s_end = &s[len - 3..];
        (s[0..5].to_string(), s_end.to_string())
    } else {
        (s, "".to_string())
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("a1234år")), (String::from("a1234"), String::from("år")));
}
