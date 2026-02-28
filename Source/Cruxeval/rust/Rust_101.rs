fn f(mut array: Vec<isize>, i_num: usize, elem: isize) -> Vec<isize> {
    array.insert(i_num, elem);
    array
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![-4, 1, 0], 1, 4), vec![-4, 4, 1, 0]);
}
