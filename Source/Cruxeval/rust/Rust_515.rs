fn f(array: Vec<isize>) -> Vec<isize> {
    let mut result = array.clone();
    result.reverse();
    result.iter_mut().for_each(|item| *item *= 2);
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 4, 5]), vec![10, 8, 6, 4, 2]);
}
