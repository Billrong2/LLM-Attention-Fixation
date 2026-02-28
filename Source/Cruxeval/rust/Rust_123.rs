fn f(mut array: Vec<isize>, elem: isize) -> Vec<isize> {
    let mut idx = 0;
    while idx < array.len() {
        if array[idx] > elem && array.get(idx.wrapping_sub(1)).unwrap_or(&elem) < &elem {
            array.insert(idx, elem);
        }
        idx += 1;
    }
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 2, 3, 5, 8], 6), vec![1, 2, 3, 5, 6, 8]);
}
