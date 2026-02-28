fn f(phrase: String) -> isize {
    let mut ans = 0;
    for w in phrase.split_whitespace() {
        for ch in w.chars() {
            if ch == '0' {
                ans += 1;
            }
        }
    }
    ans
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("aboba 212 has 0 digits")), 1);
}
