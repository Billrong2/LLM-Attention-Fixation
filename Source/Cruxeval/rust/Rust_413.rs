use std::ops::Range;

fn f(s: String) -> String {
    let len = s.len();
    format!("{}{}{}", &s[3..len], &s[2..3], &s[5..8.min(len)])
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("jbucwc")), String::from("cwcuc"));
}
