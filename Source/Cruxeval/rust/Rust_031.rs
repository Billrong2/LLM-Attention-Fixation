fn f(string: String) -> isize {
    let mut upper = 0;
    for c in string.chars() {
        if c.is_ascii_uppercase() {
            upper += 1;
        }
    }
    upper * if upper % 2 == 0 { 2 } else { 1 }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("PoIOarTvpoead")), 8);
}
