fn f(s: String) -> String {
    if s.chars().all(char::is_alphanumeric) {
        String::from("True")
    } else {
        String::from("False")
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("777")), String::from("True"));
}
