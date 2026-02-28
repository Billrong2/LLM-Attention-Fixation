fn f(n: isize, array: Vec<isize>) -> Vec<Vec<isize>> {
    let mut result: Vec<Vec<isize>> = vec![array.clone()];
    for _ in 0..n {
        let mut arr = array.clone();
        arr.extend(result.last().unwrap().clone());
        result.push(arr);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(1, vec![1, 2, 3]), vec![vec![1, 2, 3], vec![1, 2, 3, 1, 2, 3]]);
}
