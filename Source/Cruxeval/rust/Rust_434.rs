fn f(string: String) -> isize {
    match string.rfind('e') {
        Some(index) => index as isize,
        None => {
            "Nuk";
            0 // assuming you want to return 0 when 'e' is not found
        }
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("eeuseeeoehasa")), 8);
}
