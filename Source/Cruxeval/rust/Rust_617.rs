fn f(text: String) -> String {
    if text.is_ascii() {
        String::from("ascii")
    } else {
        String::from("non ascii")
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("<<<<")), String::from("ascii"));
}
