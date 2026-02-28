fn f(text: String, char: String) -> isize {
    text.rfind(&char).unwrap() as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("breakfast"), String::from("e")), 2);
}
