fn f(lst: Vec<isize>, mode: isize) -> Vec<isize> {
    let mut result = lst.clone();
    if mode != 0 {
        result.reverse();
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 4], 1), vec![4, 3, 2, 1]);
}
