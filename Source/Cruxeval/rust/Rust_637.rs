fn f(text: String) -> String {
    let words: Vec<&str> = text.split(' ').collect();
    for t in words {
        if !t.chars().all(char::is_numeric) {
            return String::from("no");
        }
    }
    String::from("yes")
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("03625163633 d")), String::from("no"));
}
