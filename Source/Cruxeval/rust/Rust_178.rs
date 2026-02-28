fn f(mut array: Vec<isize>, n: isize) -> Vec<isize> {
    array.split_off(n as usize)
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(vec![0, 0, 1, 2, 2, 2, 2], 4), vec![2, 2, 2]);
}
