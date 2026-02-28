fn f(array: Vec<isize>, elem: isize) -> isize {
    let mut array_copy = array.clone();
    array_copy.reverse();
    let found = match array_copy.iter().position(|&x| x == elem) {
        Some(idx) => idx,
        None => panic!("Element not found"),
    };
    array_copy.reverse();
    found as isize
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![5, -3, 3, 2], 2), 0);
}
