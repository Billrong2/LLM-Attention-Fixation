fn f(text: String) -> isize {
    let mut n = 0;
    for char in text.chars() {
        if char.is_uppercase() {
            n += 1;
        }
    }
    n
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("AAAAAAAAAAAAAAAAAAAA")), 20);
}
