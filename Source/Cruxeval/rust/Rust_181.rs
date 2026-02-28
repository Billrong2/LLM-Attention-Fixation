fn f(s: String) -> (String, isize) {
    let mut count = 0;
    let mut digits = String::new();
    for c in s.chars() {
        if c.is_digit(10) {
            count += 1;
            digits.push(c);
        }
    }
    (digits, count)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("qwfasgahh329kn12a23")), (String::from("3291223"), 7));
}
