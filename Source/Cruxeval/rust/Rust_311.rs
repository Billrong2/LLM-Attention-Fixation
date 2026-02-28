fn f(text: String) -> String {
    let text = text.replace("#", "1").replace("$", "5");
    if text.parse::<i32>().is_ok() {
        String::from("yes")
    } else {
        String::from("no")
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("A")), String::from("no"));
}
