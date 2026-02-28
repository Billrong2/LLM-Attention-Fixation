fn f(x: String) -> bool {
    let n = x.len();
    let mut i = 0;
    while i < n && x[i..i+1].chars().all(char::is_numeric) {
        i += 1;
    }
    i == n
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("1")), true);
}
