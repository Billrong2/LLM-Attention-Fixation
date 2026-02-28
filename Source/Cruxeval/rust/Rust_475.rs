fn f(array: Vec<isize>, index: isize) -> isize {
    let mut idx = index;
    if idx < 0 {
        idx = (array.len() as isize) + idx;
    }
    array[idx as usize]
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1], 0), 1);
}
