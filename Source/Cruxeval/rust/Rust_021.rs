fn f(mut array: Vec<isize>) -> Vec<isize> {
    let n = array.pop().unwrap();
    array.push(n);
    array.push(n);
    return array;
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 1, 2, 2]), vec![1, 1, 2, 2, 2]);
}
