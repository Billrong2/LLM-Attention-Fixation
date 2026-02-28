fn f(array: Vec<isize>, elem: isize) -> isize {
    array.iter().filter(|&x| *x == elem).count() as isize + elem
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1, 1], -2), -2);
}
