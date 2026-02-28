fn f(cat: String) -> isize {
    let mut digits = 0;
    for char in cat.chars() {
        if char.is_numeric() {
            digits += 1;
        }
    }
    digits
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("C24Bxxx982ab")), 5);
}
