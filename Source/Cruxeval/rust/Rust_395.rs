fn f(s: String) -> isize {
    for (i, c) in s.chars().enumerate() {
        if c.is_numeric() {
            return i as isize + if c == '0' { 1 } else { 0 };
        } else if c == '0' {
            return -1;
        }
    }
    -1
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("11")), 0);
}
