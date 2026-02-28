fn f(text: String) -> isize {
    text.chars().filter(|c| c.is_numeric()).count() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("so456")), 3);
}
