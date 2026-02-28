fn f(letters: String) -> isize {
    let mut count = 0;
    for l in letters.chars() {
        if l.is_numeric() {
            count += 1;
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("dp ef1 gh2")), 2);
}
