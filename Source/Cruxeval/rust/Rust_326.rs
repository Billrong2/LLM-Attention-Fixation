fn f(text: String) -> isize {
    let mut number = 0;
    for t in text.chars() {
        if t.is_numeric() {
            number += 1;
        }
    }
    number
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Thisisastring")), 0);
}
