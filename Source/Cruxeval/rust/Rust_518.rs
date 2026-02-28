fn f(text: String) -> bool {
    !text.chars().all(char::is_numeric)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("the speed is -36 miles per hour")), true);
}
