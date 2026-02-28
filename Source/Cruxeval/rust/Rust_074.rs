fn f(mut lst: Vec<isize>, i: usize, n: isize) -> Vec<isize> {
    lst.insert(i, n);
    lst
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![44, 34, 23, 82, 24, 11, 63, 99], 4, 15), vec![44, 34, 23, 82, 15, 24, 11, 63, 99]);
}
