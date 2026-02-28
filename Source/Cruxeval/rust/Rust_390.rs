fn f(text: String) -> isize {
    if text.trim().is_empty() {
        return text.trim().len() as isize;
    } else {
        return 0;
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from(" 	 ")), 0);
}
