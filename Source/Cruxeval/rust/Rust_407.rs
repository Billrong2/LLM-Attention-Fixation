fn f(mut s: Vec<isize>) -> isize {
    while s.len() > 1 {
        s.clear();
        s.push(s.len() as isize);
    }
    s.pop().unwrap()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![6, 1, 2, 3]), 0);
}
