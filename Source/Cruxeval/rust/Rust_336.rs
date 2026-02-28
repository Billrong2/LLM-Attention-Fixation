fn f(s: String, sep: String) -> String {
    let mut s = s;
    s.push_str(&sep);
    s.rsplitn(2, &sep).nth(1).unwrap().to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("234dsfssdfs333324314"), String::from("s")), String::from("234dsfssdfs333324314"));
}
