fn f(array: Vec<isize>, index: isize, value: isize) -> Vec<isize> {
    let mut array = array;
    array.insert(0, index + 1);
    if value >= 1 {
        array.insert(index as usize, value);
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![2], 0, 2), vec![2, 1, 2]);
}
