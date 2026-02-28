use std::convert::TryInto;

fn f(mut array: Vec<isize>, ind: isize, elem: isize) -> Vec<isize> {
    array.insert(if ind < 0 { (array.len() as isize + ind).try_into().unwrap() } else { ind as usize + 1 }, elem);
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![1, 5, 8, 2, 0, 3], 2, 7), vec![1, 5, 8, 7, 2, 0, 3]);
}
