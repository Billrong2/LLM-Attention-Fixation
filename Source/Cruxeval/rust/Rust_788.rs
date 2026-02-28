fn f(text: String, suffix: String) -> String {
    if suffix.starts_with("/") {
        text.clone() + &suffix[1..]
    } else {
        text.clone()
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("hello.txt"), String::from("/")), String::from("hello.txt"));
}
