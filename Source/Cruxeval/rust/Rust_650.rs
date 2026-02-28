fn f(string: String, substring: String) -> String {
    let mut string = string;
    while string.starts_with(&substring) {
        string = String::from(&string[substring.len()..]);
    }
    string
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(""), String::from("A")), String::from(""));
}
