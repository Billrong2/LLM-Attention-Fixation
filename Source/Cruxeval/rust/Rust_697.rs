fn f(s: String, sep: String) -> (String, String, String) {
    let sep_index = s.find(&sep).unwrap();
    let prefix = &s[..sep_index];
    let middle = &s[sep_index..sep_index + sep.len()];
    let right_str = &s[sep_index + sep.len()..];
    (prefix.to_string(), middle.to_string(), right_str.to_string())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("not it"), String::from("")), (String::from(""), String::from(""), String::from("not it")));
}
