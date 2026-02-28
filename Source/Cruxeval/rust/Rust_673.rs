fn f(string: String) -> String {
    if string.chars().all(char::is_uppercase) {
        string.to_lowercase()
    } else if string.chars().all(char::is_lowercase) {
        string.to_uppercase()
    } else {
        string
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("cA")), String::from("cA"));
}
