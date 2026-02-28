fn f(numbers: Vec<isize>, elem: isize, idx: usize) -> Vec<isize> {
    let mut result = numbers;
    if idx > result.len() {
        result.push(elem);
    } else {
        result.insert(idx, elem);
    }
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3], 8, 5), vec![1, 2, 3, 8]);
}
