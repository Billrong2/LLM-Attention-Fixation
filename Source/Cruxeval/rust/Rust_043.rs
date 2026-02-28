fn f(n: String) -> isize {
    for i in n.chars() {
        if !i.is_numeric() {
            return -1;
        }
    }
    n.parse().unwrap_or(-1)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("6 ** 2")), -1);
}
