fn f(mut values: Vec<isize>) -> Vec<isize> {
    values.sort_unstable();
    values
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1, 1, 1]), vec![1, 1, 1, 1]);
}
