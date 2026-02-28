fn f(arr: Vec<isize>) -> Vec<isize> {
    arr.into_iter().rev().collect()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2, 0, 1, 9999, 3, -5]), vec![-5, 3, 9999, 1, 0, 2]);
}
