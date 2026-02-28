fn f(s: String) -> isize {
    let mut count = 0;
    for word in s.split_whitespace() {
        if !word.is_empty() && (word.chars().next().unwrap().is_ascii_uppercase() && word.chars().skip(1).all(|c| c.is_ascii_lowercase())) {
            count += 1;
        }
    }
    count
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("SOME OF THIS Is uknowN!")), 1);
}
