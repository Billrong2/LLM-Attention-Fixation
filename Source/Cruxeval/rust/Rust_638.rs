fn f(s: String, suffix: String) -> String {
    let mut s = s.clone();
    
    if suffix.is_empty() {
        return s;
    }
    
    while s.ends_with(&suffix) {
        s = s[..s.len() - suffix.len()].to_string();
    }
    
    s
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ababa"), String::from("ab")), String::from("ababa"));
}
