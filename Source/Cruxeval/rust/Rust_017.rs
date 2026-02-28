fn f(text: String) -> isize {
    match text.find(',') {
        Some(index) => index as isize,
        None => -1,
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("There are, no, commas, in this text")), 9);
}
