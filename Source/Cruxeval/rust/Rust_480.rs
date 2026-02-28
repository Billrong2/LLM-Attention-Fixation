fn f(s: String, c1: String, c2: String) -> String {
    if s.is_empty() {
        return s;
    }
    let mut ls: Vec<&str> = s.split(c1.as_str()).collect();
    for item in ls.iter_mut() {
        if *item == c1.as_str() {
            *item = c2.as_str();
        }
    }
    ls.join(c1.as_str())
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(""), String::from("mi"), String::from("siast")), String::from(""));
}
