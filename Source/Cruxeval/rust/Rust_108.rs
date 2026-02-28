fn f(var: isize) -> isize {
    0
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1), 0);
}
